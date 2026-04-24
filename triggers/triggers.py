import argparse
import json
import logging
import os.path
import sys
from typing import Optional

from sshtunnel import SSHTunnelForwarder

from ukrdc.database import Connection

logger = logging.getLogger("generate_triggers")


def get_ssh_config(fname: Optional[str] = None, key: Optional[str] = None):
    if not fname:
        fname = os.path.expanduser("~/.config/ukrdc/services/db_conf.json")
    with open(fname) as fhandle:
        params = json.load(fhandle)
        return params[key]


def main():
    parser = argparse.ArgumentParser(description="Update Triggers")
    parser.add_argument("--server", nargs="+", default=())
    parser.add_argument("--testrun", action="store_true")

    if not len(sys.argv) > 1:
        parser.print_help()
        return
    args = parser.parse_args()

    if args.testrun:
        output_file = open("C:/Temp/Triggers.txt", "w")

    for db_conf_name in args.server:
        try:
            db, env = db_conf_name.split("_")
        except Exception:
            print(
                "Server Names should be in the form 'jtrace_live', 'ukrdc_staging' etc."
            )
            sys.exit(1)

        if db == "ukrdc":
            schema_name = "extract"
        elif db == "jtrace":
            schema_name = "jtrace"

        ssh_conf_name = env + "_app_ssh"
        ssh_config = get_ssh_config(None, ssh_conf_name)

        # SSH Tunnel from localhost To UKRDC App -> UKRDC DB
        with SSHTunnelForwarder(
            (ssh_config["HOST"], 22),
            ssh_password=ssh_config["PASSWORD"],
            ssh_username=ssh_config["USER"],
            remote_bind_address=(ssh_config["DBHOST"], 5432),
        ) as server:
            server.start()
            port = str(server.local_bind_port)

            logger.info("Connecting to DB Servers")

            # The tunnel is created on a dynamic port
            # so I need to pass it in when creating the Session.
            print(db_conf_name)
            sql_engine = Connection.get_engine_from_file(None, db_conf_name, port=port)
            sql_connection = sql_engine.raw_connection()
            sql_cursor = sql_connection.cursor()

            logger.info("Connections Setup")

            # NOTE: These steps will fail if the account
            # being used isn't the owner of the table.

            # Check/Create Creation Date Field

            sql_string = f"""
                SELECT
                    A.table_name
                FROM
                    information_schema.tables A
                LEFT JOIN
                    information_schema.columns B ON
                        A.Table_Name = B.Table_Name AND
                        A.Table_schema = B.table_schema AND
                        B.column_name = 'creation_date'
                WHERE
                    A.table_schema = '{schema_name}' AND
                    A.table_type = 'BASE TABLE' AND
                    B.column_name IS NULL
                """

            sql_cursor.execute(sql_string)
            incomplete_tables = [row[0] for row in sql_cursor.fetchall()]

            for table_name in incomplete_tables:
                sql_string = f"""
                    ALTER TABLE {table_name}
                    ADD COLUMN creation_date timestamp NOT NULL DEFAULT Now();
                    """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

            # Check/Create Update Date Field

            sql_string = f"""
                SELECT
                    A.table_name
                FROM
                    information_schema.tables A
                LEFT JOIN
                    information_schema.columns B ON
                        A.Table_Name = B.Table_Name AND
                        A.Table_schema = B.table_schema AND
                        B.column_name = 'update_date'
                WHERE
                    A.table_schema = '{schema_name}' AND
                    A.table_type = 'BASE TABLE' AND
                    B.column_name IS NULL
                """

            sql_cursor.execute(sql_string)
            incomplete_tables = [row[0] for row in sql_cursor.fetchall()]

            for table_name in incomplete_tables:
                sql_string = f"""
                    ALTER TABLE {table_name}
                    ADD COLUMN update_date timestamp;
                    """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

            # Refresh Update Trigger on All Tables

            # Refresh Trigger Function
            sql_string = """
                CREATE OR REPLACE FUNCTION trigger_fnc_set_update_date()
                RETURNS TRIGGER AS $$
                BEGIN
                  NEW.update_date = NOW();
                  RETURN NEW;
                END;
                $$ LANGUAGE plpgsql;
                """

            if args.testrun:
                output_file.write(sql_string)
            else:
                sql_cursor.execute(sql_string)

            # Add/Refresh Trigger on Tables
            sql_string = f"""
                SELECT
                    A.table_name
                FROM
                    information_schema.tables A
                WHERE
                    A.table_schema = '{schema_name}' AND
                    A.table_type = 'BASE TABLE'
                """

            sql_cursor.execute(sql_string)
            tables = [row[0] for row in sql_cursor.fetchall()]

            for table_name in tables:
                sql_string = f"""DROP TRIGGER IF EXISTS trg_set_update_date ON {schema_name}.{table_name};"""

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

                sql_string = f"""
                    CREATE TRIGGER trg_set_update_date
                    BEFORE UPDATE ON {table_name}
                    FOR EACH ROW
                    EXECUTE PROCEDURE trigger_fnc_set_update_date();
                    """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

            # Add LabOrder/ResultItem Trigger
            if db == "ukrdc":
                # Create repository_update_date field
                # if it doesn't already exist

                sql_string = """
                SELECT
                    A.table_name
                FROM
                    information_schema.tables A
                LEFT JOIN
                    information_schema.columns B ON
                        A.Table_Name = B.Table_Name AND
                        A.Table_schema = B.table_schema AND
                        B.column_name = 'update_date'
                WHERE
                    A.table_schema = 'extract' AND
                    A.table_name = 'laborder' AND
                    A.table_type = 'BASE TABLE' AND
                    B.column_name IS NULL
                """

                sql_cursor.execute(sql_string)
                result = sql_cursor.fetchone()

                if not result:
                    sql_string = """
                    ALTER TABLE laborder
                    ADD COLUMN repository_update_date timestamp
                    """

                    if args.testrun:
                        output_file.write(sql_string)
                    else:
                        sql_cursor.execute(sql_string)

                # Refresh Trigger
                # Note that the Trigger goes on the ResultItem table.

                sql_string = """
                CREATE OR REPLACE FUNCTION trigger_fnc_set_laborder_repository_update_date()
                RETURNS TRIGGER AS $$
                BEGIN
                    IF TG_OP IN ('INSERT', 'UPDATE')
                    THEN
                        UPDATE laborder
                        SET repository_update_date = NOW()
                        WHERE
                            laborder.id = NEW.orderid;
                        RETURN NEW;
                    ELSIF TG_OP = 'DELETE'
                    THEN
                        UPDATE laborder
                        SET repository_update_date = NOW()
                        WHERE
                            laborder.id = OLD.orderid;
                        RETURN NEW;
                    END IF;
                END;
                $$ LANGUAGE plpgsql;
                """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

                # Refresh Trigger
                # Note that the trigger goes on the resultitem table
                sql_string = """
                DROP TRIGGER IF EXISTS trg_set_laborder_repository_update_date ON extract.resultitem;
                """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

                sql_string = """
                CREATE TRIGGER trg_set_laborder_repository_update_date
                AFTER INSERT OR UPDATE OR DELETE ON resultitem
                FOR EACH ROW
                    EXECUTE PROCEDURE trigger_fnc_set_laborder_repository_update_date();
                """

                if args.testrun:
                    output_file.write(sql_string)
                else:
                    sql_cursor.execute(sql_string)

            # NOTE: Something I didn't realise was that unlike SQL Server
            # You need to commit DDL in PostgreSQL
            if not args.testrun:
                sql_connection.commit()

            # NOTE: If you don't close the cursors/sessions/connectors
            # Before the SSHTunnel "with" ends you'll get an error
            # due to the connection being down when are otherwise closed.
            sql_cursor.close()
            sql_connection.close()


if __name__ == "__main__":
    main()
