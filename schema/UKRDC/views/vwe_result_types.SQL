-- View: "extract".vwe_result_types

CREATE VIEW "extract".vwe_result_types AS
 SELECT
   a.sendingfacility,
   c.serviceidcodestd,
   c.serviceidcode,
   c.serviceiddesc,
   c.resultvalueunits,
   count(*) AS result_count
 FROM "extract".patientrecord a
 JOIN "extract".laborder b
   ON (a.pid)::text = (b.pid)::text
 JOIN "extract".resultitem c
   ON (c.orderid)::text = (b.id)::text
 WHERE
   (a.sendingextract)::text = ANY (
     ARRAY[
       ('PV'::character varying)::text,
       ('UKRDC'::character varying)::text
     ]
   )
   AND c.observationtime > '2023-01-01 00:00:00'::timestamp without time zone
 GROUP BY
   a.sendingfacility,
   c.serviceidcodestd,
   c.serviceidcode,
   c.serviceiddesc,
   c.resultvalueunits
 ORDER BY
   c.serviceidcodestd,
   c.serviceidcode;

ALTER VIEW "extract".vwe_result_types
  OWNER TO ukrdc;