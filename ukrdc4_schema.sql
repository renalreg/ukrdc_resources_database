--
-- PostgreSQL database dump
--

\restrict cEIo6ZSbGWmbDpbnCJ1V6lETZFAHMSOm9kryfuGnYd8dBupfyms0Hh8opoMh2pq

-- Dumped from database version 17.7 (Debian 17.7-3.pgdg13+1)
-- Dumped by pg_dump version 17.7 (Debian 17.7-3.pgdg13+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: extract; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA "extract";


ALTER SCHEMA "extract" OWNER TO postgres;

--
-- Name: investigations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA investigations;


ALTER SCHEMA investigations OWNER TO postgres;

--
-- Name: ukrdc-live; Type: SCHEMA; Schema: -; Owner: ukrdc
--

CREATE SCHEMA "ukrdc-live";


ALTER SCHEMA "ukrdc-live" OWNER TO ukrdc;

--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: facility_type_enum; Type: TYPE; Schema: extract; Owner: ukrdc
--

CREATE TYPE "extract".facility_type_enum AS ENUM (
    'Adult Renal Centre',
    'Paediatric Renal Centre',
    'Multiple Centre',
    'Other'
);


ALTER TYPE "extract".facility_type_enum OWNER TO ukrdc;

--
-- Name: gp_type; Type: TYPE; Schema: extract; Owner: ukrdc
--

CREATE TYPE "extract".gp_type AS ENUM (
    'GP',
    'PRACTICE'
);


ALTER TYPE "extract".gp_type OWNER TO ukrdc;

--
-- Name: trigger_fnc_set_laborder_repository_update_date(); Type: FUNCTION; Schema: extract; Owner: ukrdc
--

CREATE FUNCTION "extract".trigger_fnc_set_laborder_repository_update_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
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
                $$;


ALTER FUNCTION "extract".trigger_fnc_set_laborder_repository_update_date() OWNER TO ukrdc;

--
-- Name: trigger_fnc_set_update_date(); Type: FUNCTION; Schema: extract; Owner: ukrdc
--

CREATE FUNCTION "extract".trigger_fnc_set_update_date() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
                BEGIN
                  NEW.update_date = NOW();
                  RETURN NEW;
                END;
                $$;


ALTER FUNCTION "extract".trigger_fnc_set_update_date() OWNER TO ukrdc;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: address; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".address (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    addressuse character varying(10),
    fromtime date,
    totime date,
    street character varying(100),
    town character varying(100),
    county character varying(100),
    postcode character varying(10),
    countrycode character varying(100),
    countrycodestd character varying(100),
    countrydesc character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".address OWNER TO ukrdc;

--
-- Name: allergy; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".allergy (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    allergycode character varying(100),
    allergycodestd character varying(100),
    allergydesc character varying(100),
    allergycategorycode character varying(100),
    allergycategorycodestd character varying(100),
    allergycategorydesc character varying(100),
    severitycode character varying(100),
    severitycodestd character varying(100),
    severitydesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    discoverytime timestamp without time zone,
    confirmedtime timestamp without time zone,
    commenttext character varying(500),
    inactivetime timestamp without time zone,
    freetextallergy character varying(500),
    qualifyingdetails character varying(500),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".allergy OWNER TO ukrdc;

--
-- Name: assessment; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".assessment (
    id character varying NOT NULL,
    pid character varying,
    idx integer,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    assessmentstart timestamp without time zone,
    assessmentend timestamp without time zone,
    assessmenttypecode character varying(100),
    assessmenttypecodestd character varying(100),
    assessmenttypecodedesc character varying(100),
    assessmentoutcomecode character varying(100),
    assessmentoutcomecodestd character varying(100),
    assessmentoutcomecodedesc character varying(100)
);


ALTER TABLE "extract".assessment OWNER TO ukrdc;

--
-- Name: causeofdeath; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".causeofdeath (
    pid character varying(30) NOT NULL,
    diagnosistype character varying(50),
    diagnosingcliniciancode character varying(100),
    diagnosingcliniciancodestd character varying(100),
    diagnosingcliniciandesc character varying(100),
    diagnosiscode character varying(100),
    diagnosiscodestd character varying(100),
    diagnosisdesc character varying(255),
    comments text,
    enteredon timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    verificationstatus character varying(100),
    idx integer
);


ALTER TABLE "extract".causeofdeath OWNER TO ukrdc;

--
-- Name: clinicalrelationship; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".clinicalrelationship (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    facilitycode character varying(100),
    facilitycodestd character varying(100),
    facilitydesc character varying(100),
    fromtime date,
    totime date,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".clinicalrelationship OWNER TO ukrdc;

--
-- Name: code_exclusion; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".code_exclusion (
    coding_standard character varying NOT NULL,
    code character varying NOT NULL,
    system character varying NOT NULL
);


ALTER TABLE "extract".code_exclusion OWNER TO ukrdc;

--
-- Name: code_list; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".code_list (
    coding_standard character varying(256) NOT NULL,
    code character varying(256) NOT NULL,
    description character varying(256),
    object_type character varying(256),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    units character varying(256),
    pkb_reference_range character varying(10),
    pkb_comment text
);


ALTER TABLE "extract".code_list OWNER TO ukrdc;

--
-- Name: code_map; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".code_map (
    source_coding_standard character varying(256) NOT NULL,
    source_code character varying(256) NOT NULL,
    destination_coding_standard character varying(256) NOT NULL,
    destination_code character varying(256) NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".code_map OWNER TO ukrdc;

--
-- Name: contactdetail; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".contactdetail (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    contactuse character varying(10),
    contactvalue character varying(100),
    commenttext character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".contactdetail OWNER TO ukrdc;

--
-- Name: diagnosis; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".diagnosis (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    diagnosistype character varying(50),
    diagnosingcliniciancode character varying(100),
    diagnosingcliniciancodestd character varying(100),
    diagnosingcliniciandesc character varying(100),
    diagnosiscode character varying(100),
    diagnosiscodestd character varying(100),
    diagnosisdesc character varying(255),
    comments text,
    identificationtime timestamp without time zone,
    onsettime timestamp without time zone,
    enteredon timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    encounternumber character varying(100),
    verificationstatus character varying(100),
    biopsyperformed character varying(100)
);


ALTER TABLE "extract".diagnosis OWNER TO ukrdc;

--
-- Name: dialysisprescription; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".dialysisprescription (
    id character varying(20) NOT NULL,
    pid character varying(20),
    idx integer,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    enteredon timestamp without time zone,
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    sessiontype character varying(5),
    sessionsperweek integer,
    timedialysed integer,
    vascularaccess character varying(5)
);


ALTER TABLE "extract".dialysisprescription OWNER TO ukrdc;

--
-- Name: dialysissession; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".dialysissession (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    proceduretypecode character varying(100),
    proceduretypecodestd character varying(100),
    proceduretypedesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    proceduretime timestamp without time zone,
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    qhd19 character varying(255),
    qhd20 character varying(255),
    qhd21 character varying(255),
    qhd22 character varying(255),
    qhd30 character varying(255),
    qhd31 character varying(255),
    qhd32 character varying(255),
    qhd33 character varying(255),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".dialysissession OWNER TO ukrdc;

--
-- Name: document; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".document (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    documenttime timestamp without time zone,
    notetext text,
    documenttypecode character varying(100),
    documenttypecodestd character varying(100),
    documenttypedesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    documentname character varying(100),
    statuscode character varying(100),
    statuscodestd character varying(100),
    statusdesc character varying(100),
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    filetype character varying(100),
    filename character varying(100),
    stream bytea,
    documenturl character varying(100),
    repositoryupdatedate timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".document OWNER TO ukrdc;

--
-- Name: encounter; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".encounter (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    encounternumber character varying(100),
    encountertype character varying(100),
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    admittingcliniciancode character varying(100),
    admittingcliniciancodestd character varying(100),
    admittingcliniciandesc character varying(100),
    admitreasoncode character varying(100),
    admitreasoncodestd character varying(100),
    admitreasondesc character varying(100),
    admissionsourcecode character varying(100),
    admissionsourcecodestd character varying(100),
    admissionsourcedesc character varying(100),
    dischargereasoncode character varying(100),
    dischargereasoncodestd character varying(100),
    dischargereasondesc character varying(100),
    dischargelocationcode character varying(100),
    dischargelocationcodestd character varying(100),
    dischargelocationdesc character varying(100),
    healthcarefacilitycode character varying(100),
    healthcarefacilitycodestd character varying(100),
    healthcarefacilitydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    visitdescription character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".encounter OWNER TO ukrdc;

--
-- Name: eventcontrol; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".eventcontrol (
    eventtype character(20) NOT NULL,
    eventdate timestamp without time zone NOT NULL,
    pendingeventdate timestamp without time zone,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".eventcontrol OWNER TO ukrdc;

--
-- Name: facility; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".facility (
    code character varying(256) NOT NULL,
    pkb_out boolean DEFAULT false,
    pkb_in boolean DEFAULT false,
    pkb_msg_exclusions text[],
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    ukrdc_out_pkb boolean DEFAULT false,
    pv_out_pkb boolean DEFAULT false
);


ALTER TABLE "extract".facility OWNER TO ukrdc;

--
-- Name: facility_new; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".facility_new (
    facilitycode character varying(100) NOT NULL,
    facilitycodestd character varying(100) NOT NULL,
    facilitytype "extract".facility_type_enum NOT NULL,
    pkbout boolean DEFAULT false NOT NULL,
    pkbmsgexclusions text[],
    ukrdcoutpkb boolean DEFAULT false NOT NULL,
    pvoutpkb boolean DEFAULT false NOT NULL,
    startdate timestamp(6) without time zone,
    enddate timestamp(6) without time zone,
    firstdataquarter integer,
    pkboutstartdate timestamp(6) without time zone,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE "extract".facility_new OWNER TO ukrdc;

--
-- Name: familydoctor; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".familydoctor (
    id character varying(100) NOT NULL,
    gpname character varying(100),
    gpid character varying(20),
    gppracticeid character varying(20),
    addressuse character varying(10),
    fromtime date,
    totime date,
    street character varying(100),
    town character varying(100),
    county character varying(100),
    postcode character varying(10),
    countrycode character varying(100),
    countrycodestd character varying(100),
    countrydesc character varying(100),
    contactuse character varying(10),
    contactvalue character varying(100),
    email character varying(100),
    commenttext character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".familydoctor OWNER TO ukrdc;

--
-- Name: familyhistory; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".familyhistory (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    familymembercode character varying(100),
    familymembercodestd character varying(100),
    familymemberdesc character varying(100),
    diagnosiscode character varying(100),
    diagnosiscodestd character varying(100),
    diagnosisdesc character varying(100),
    notetext character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".familyhistory OWNER TO ukrdc;

--
-- Name: generate_new_pid; Type: SEQUENCE; Schema: extract; Owner: postgres
--

CREATE SEQUENCE "extract".generate_new_pid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".generate_new_pid OWNER TO postgres;

--
-- Name: SEQUENCE generate_new_pid; Type: COMMENT; Schema: extract; Owner: postgres
--

COMMENT ON SEQUENCE "extract".generate_new_pid IS 'Sequence to generate new pids should be initiated as the maxiumum pid';


--
-- Name: generate_new_ukrdcid; Type: SEQUENCE; Schema: extract; Owner: postgres
--

CREATE SEQUENCE "extract".generate_new_ukrdcid
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".generate_new_ukrdcid OWNER TO postgres;

--
-- Name: SEQUENCE generate_new_ukrdcid; Type: COMMENT; Schema: extract; Owner: postgres
--

COMMENT ON SEQUENCE "extract".generate_new_ukrdcid IS 'Sequence mints new ukrdcids';


--
-- Name: laborder; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".laborder (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    placerid character varying(100),
    fillerid character varying(100),
    receivinglocationcode character varying(100),
    receivinglocationcodestd character varying(100),
    receivinglocationdesc character varying(100),
    orderedbycode character varying(100),
    orderedbycodestd character varying(100),
    orderedbydesc character varying(100),
    orderitemcode character varying(100),
    orderitemcodestd character varying(100),
    orderitemdesc character varying(100),
    prioritycode character varying(100),
    prioritycodestd character varying(100),
    prioritydesc character varying(100),
    status character varying(100),
    ordercategorycode character varying(100),
    ordercategorycodestd character varying(100),
    ordercategorydesc character varying(100),
    specimensource character varying(50),
    specimenreceivedtime timestamp without time zone,
    specimencollectedtime timestamp without time zone,
    duration character varying(50),
    patientclasscode character varying(100),
    patientclasscodestd character varying(100),
    patientclassdesc character varying(100),
    enteredon timestamp without time zone,
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    enteringorganizationcode character varying(100),
    enteringorganizationcodestd character varying(100),
    enteringorganizationdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    repository_update_date timestamp without time zone
);


ALTER TABLE "extract".laborder OWNER TO ukrdc;

--
-- Name: level; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".level (
    id character varying(100) NOT NULL,
    surveyid character varying(100) NOT NULL,
    idx integer,
    levelvalue character varying(100),
    leveltypecode character varying(100),
    leveltypecodestd character varying(100),
    leveltypedesc character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".level OWNER TO ukrdc;

--
-- Name: locations; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".locations (
    centre_code character varying(10) NOT NULL,
    centre_name character varying(255) NOT NULL,
    country_code character varying(6) NOT NULL,
    region_code character varying(10),
    paed_unit integer NOT NULL
);


ALTER TABLE "extract".locations OWNER TO ukrdc;

--
-- Name: medication; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".medication (
    id character varying(150) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    prescriptionnumber character varying(100),
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    orderedbycode character varying(100),
    orderedbycodestd character varying(100),
    orderedbydesc character varying(100),
    enteringorganizationcode character varying(100),
    enteringorganizationcodestd character varying(100),
    enteringorganizationdesc character varying(100),
    routecode character varying(10),
    routecodestd character varying(100),
    routedesc character varying(100),
    drugproductidcode character varying(100),
    drugproductidcodestd character varying(100),
    drugproductiddesc character varying(100),
    drugproductgeneric character varying(255),
    drugproductlabelname character varying(255),
    drugproductformcode character varying(100),
    drugproductformcodestd character varying(100),
    drugproductformdesc character varying(100),
    drugproductstrengthunitscode character varying(100),
    drugproductstrengthunitscodestd character varying(100),
    drugproductstrengthunitsdesc character varying(100),
    frequency character varying(255),
    commenttext character varying(1000),
    dosequantity numeric(19,2),
    doseuomcode character varying(100),
    doseuomcodestd character varying(100),
    doseuomdesc character varying(100),
    indication character varying(100),
    repositoryupdatedate timestamp without time zone NOT NULL,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    encounternumber character varying(100)
);


ALTER TABLE "extract".medication OWNER TO ukrdc;

--
-- Name: modality_codes; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".modality_codes (
    registry_code character varying(8) NOT NULL,
    registry_code_desc character varying(100),
    registry_code_type character varying(3) NOT NULL,
    acute bit(1) NOT NULL,
    transfer_in bit(1) NOT NULL,
    ckd bit(1) NOT NULL,
    cons bit(1) NOT NULL,
    rrt bit(1) NOT NULL,
    equiv_modality character varying(8),
    end_of_care bit(1) NOT NULL,
    is_imprecise bit(1) NOT NULL,
    nhsbt_transplant_type character varying(4),
    transfer_out bit(1)
);


ALTER TABLE "extract".modality_codes OWNER TO ukrdc;

--
-- Name: name; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".name (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    nameuse character varying(10),
    prefix character varying(10),
    family character varying(60),
    given character varying(60),
    othergivennames character varying(60),
    suffix character varying(10),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".name OWNER TO ukrdc;

--
-- Name: observation; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".observation (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    observationtime timestamp without time zone,
    observationcode character varying(100),
    observationcodestd character varying(100),
    observationdesc character varying(100),
    observationvalue character varying(100),
    observationunits character varying(100),
    prepost character varying(4),
    commenttext character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    enteringorganizationcode character varying(100),
    enteringorganizationcodestd character varying(100),
    enteringorganizationdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".observation OWNER TO ukrdc;

--
-- Name: optout; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".optout (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    programname character varying(100),
    programdescription character varying(100),
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    fromtime date,
    totime date,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".optout OWNER TO ukrdc;

--
-- Name: patient; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".patient (
    pid character varying(30) NOT NULL,
    birthtime timestamp without time zone,
    deathtime timestamp without time zone,
    gender character varying(2),
    countryofbirth character varying(3),
    ethnicgroupcode character varying(100),
    ethnicgroupcodestd character varying(100),
    ethnicgroupdesc character varying(100),
    occupationcode character varying(100),
    occupationcodestd character varying(100),
    occupationdesc character varying(100),
    primarylanguagecode character varying(100),
    primarylanguagecodestd character varying(100),
    primarylanguagedesc character varying(100),
    death boolean,
    persontocontactname character varying(100),
    persontocontact_relationship character varying(20),
    persontocontact_contactnumber character varying(20),
    persontocontact_contactnumbertype character varying(20),
    persontocontact_contactnumbercomments character varying(200),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    bloodgroup character varying(100),
    bloodrhesus character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".patient OWNER TO ukrdc;

--
-- Name: patientnumber; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".patientnumber (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    patientid character varying(50),
    numbertype character varying(3),
    organization character varying(50),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".patientnumber OWNER TO ukrdc;

--
-- Name: patientrecord; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".patientrecord (
    pid character varying(30) NOT NULL,
    sendingfacility character varying(7) NOT NULL,
    sendingextract character varying(6) NOT NULL,
    localpatientid character varying(17) NOT NULL,
    ukrdcid character varying(10),
    channelname character varying(50),
    channelid character varying(50),
    extracttime character varying(50),
    repositorycreationdate timestamp without time zone NOT NULL,
    repositoryupdatedate timestamp without time zone NOT NULL,
    startdate timestamp without time zone,
    stopdate timestamp without time zone,
    migrated boolean DEFAULT false NOT NULL,
    schemaversion character varying(50),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".patientrecord OWNER TO ukrdc;

--
-- Name: pkb_links; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".pkb_links (
    id integer NOT NULL,
    link character varying,
    link_name character varying,
    coding_standard character varying,
    code character varying
);


ALTER TABLE "extract".pkb_links OWNER TO ukrdc;

--
-- Name: pkb_links_id_seq; Type: SEQUENCE; Schema: extract; Owner: ukrdc
--

CREATE SEQUENCE "extract".pkb_links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".pkb_links_id_seq OWNER TO ukrdc;

--
-- Name: pkb_links_id_seq; Type: SEQUENCE OWNED BY; Schema: extract; Owner: ukrdc
--

ALTER SEQUENCE "extract".pkb_links_id_seq OWNED BY "extract".pkb_links.id;


--
-- Name: procedure; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".procedure (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    proceduretypecode character varying(100),
    proceduretypecodestd character varying(100),
    proceduretypedesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    proceduretime timestamp without time zone,
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".procedure OWNER TO ukrdc;

--
-- Name: programmembership; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".programmembership (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    programname character varying(100),
    programdescription character varying(100),
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    fromtime date,
    totime date,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".programmembership OWNER TO ukrdc;

--
-- Name: pvdata; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".pvdata (
    id character varying(100) NOT NULL,
    rrtstatus character varying(100),
    tpstatus character varying(100),
    diagnosisdate date,
    bloodgroup character varying(10),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".pvdata OWNER TO ukrdc;

--
-- Name: pvdelete; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".pvdelete (
    did integer NOT NULL,
    pid character varying(30) NOT NULL,
    observationtime timestamp without time zone,
    serviceidcode character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".pvdelete OWNER TO ukrdc;

--
-- Name: pvdelete_did_seq; Type: SEQUENCE; Schema: extract; Owner: ukrdc
--

CREATE SEQUENCE "extract".pvdelete_did_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".pvdelete_did_seq OWNER TO ukrdc;

--
-- Name: pvdelete_did_seq; Type: SEQUENCE OWNED BY; Schema: extract; Owner: ukrdc
--

ALTER SEQUENCE "extract".pvdelete_did_seq OWNED BY "extract".pvdelete.did;


--
-- Name: question; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".question (
    id character varying(100) NOT NULL,
    surveyid character varying(100) NOT NULL,
    idx integer,
    questiontypecode character varying(100),
    questiontypecodestd character varying(100),
    questiontypedesc character varying(100),
    response character varying(100),
    questiontext character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".question OWNER TO ukrdc;

--
-- Name: renaldiagnosis; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".renaldiagnosis (
    pid character varying(30) NOT NULL,
    diagnosistype character varying(50),
    diagnosingcliniciancode character varying(100),
    diagnosingcliniciancodestd character varying(100),
    diagnosingcliniciandesc character varying(100),
    diagnosiscode character varying(100),
    diagnosiscodestd character varying(100),
    diagnosisdesc character varying(255),
    comments text,
    identificationtime timestamp without time zone,
    onsettime timestamp without time zone,
    enteredon timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone,
    idx integer,
    biopsyperformed character varying(100),
    verificationstatus character varying(100)
);


ALTER TABLE "extract".renaldiagnosis OWNER TO ukrdc;

--
-- Name: resultitem; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".resultitem (
    id character varying(100) NOT NULL,
    orderid character varying(100) NOT NULL,
    resulttype character varying(2),
    serviceidcode character varying(100),
    serviceidcodestd character varying(100),
    serviceiddesc character varying(100),
    subid character varying(50),
    resultvalue character varying(30),
    resultvalueunits character varying(30),
    referencerange character varying(30),
    interpretationcodes character varying(50),
    status character varying(5),
    observationtime timestamp without time zone,
    commenttext character varying(1000),
    referencecomment character varying(1000),
    prepost character varying(4),
    enteredon timestamp without time zone,
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".resultitem OWNER TO ukrdc;

--
-- Name: rr_codes; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".rr_codes (
    id character varying(10) NOT NULL,
    rr_code character varying(10) NOT NULL,
    description_1 character varying(255),
    description_2 character varying(70),
    description_3 character varying(60),
    old_value character varying(10),
    old_value_2 character varying(10),
    new_value character varying(10)
);


ALTER TABLE "extract".rr_codes OWNER TO ukrdc;

--
-- Name: rr_data_definition; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".rr_data_definition (
    upload_key character varying(5),
    "TABLE_NAME" character varying(30) NOT NULL,
    field_name character varying(30) NOT NULL,
    code_id character varying(10),
    mandatory numeric(1,0),
    "TYPE" character varying(1),
    alt_constraint character varying(30),
    alt_desc character varying(30),
    extra_val character varying(1),
    error_type integer,
    paed_mand numeric(1,0),
    ckd5_mand numeric(1,0),
    dependant_field character varying(30),
    alt_validation character varying(30),
    file_prefix character varying(20),
    load_min numeric(38,4),
    load_max numeric(38,4),
    remove_min numeric(38,4),
    remove_max numeric(38,4),
    in_month numeric(1,0),
    aki_mand numeric(1,0),
    rrt_mand numeric(1,0),
    cons_mand numeric(1,0),
    ckd4_mand numeric(1,0),
    valid_before_dob numeric(1,0),
    valid_after_dod numeric(1,0),
    in_quarter numeric(1,0)
);


ALTER TABLE "extract".rr_data_definition OWNER TO ukrdc;

--
-- Name: satellite_map; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".satellite_map (
    satellite_code character varying(10) NOT NULL,
    main_unit_code character varying(10) NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".satellite_map OWNER TO ukrdc;

--
-- Name: score; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".score (
    id character varying(100) NOT NULL,
    surveyid character varying(100) NOT NULL,
    idx integer,
    scorevalue character varying(100),
    scoretypecode character varying(100),
    scoretypecodestd character varying(100),
    scoretypedesc character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".score OWNER TO ukrdc;

--
-- Name: socialhistory; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".socialhistory (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    socialhabitcode character varying(100),
    socialhabitcodestd character varying(100),
    socialhabitdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".socialhistory OWNER TO ukrdc;

--
-- Name: survey; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".survey (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    surveytime timestamp without time zone NOT NULL,
    surveytypecode character varying(100),
    surveytypecodestd character varying(100),
    surveytypedesc character varying(100),
    typeoftreatment character varying(100),
    hdlocation character varying(100),
    template character varying(100),
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".survey OWNER TO ukrdc;

--
-- Name: transplant; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".transplant (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    proceduretypecode character varying(100),
    proceduretypecodestd character varying(100),
    proceduretypedesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    proceduretime timestamp without time zone,
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    tra64 timestamp without time zone,
    tra65 character varying(255),
    tra66 character varying(255),
    tra69 timestamp without time zone,
    tra76 character varying(255),
    tra77 character varying(255),
    tra78 character varying(255),
    tra79 character varying(255),
    tra80 character varying(255),
    tra8a character varying(255),
    tra81 character varying(255),
    tra82 character varying(255),
    tra83 character varying(255),
    tra84 character varying(255),
    tra85 character varying(255),
    tra86 character varying(255),
    tra87 character varying(255),
    tra88 character varying(255),
    tra89 character varying(255),
    tra90 character varying(255),
    tra91 character varying(255),
    tra92 character varying(255),
    tra93 character varying(255),
    tra94 character varying(255),
    tra95 character varying(255),
    tra96 character varying(255),
    tra97 character varying(255),
    tra98 character varying(255),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".transplant OWNER TO ukrdc;

--
-- Name: transplantlist; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".transplantlist (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    encounternumber character varying(100),
    encountertype character varying(100),
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    admittingcliniciancode character varying(100),
    admittingcliniciancodestd character varying(100),
    admittingcliniciandesc character varying(100),
    admitreasoncode character varying(100),
    admitreasoncodestd character varying(100),
    admitreasondesc character varying(100),
    admissionsourcecode character varying(100),
    admissionsourcecodestd character varying(100),
    admissionsourcedesc character varying(100),
    dischargereasoncode character varying(100),
    dischargereasoncodestd character varying(100),
    dischargereasondesc character varying(100),
    dischargelocationcode character varying(100),
    dischargelocationcodestd character varying(100),
    dischargelocationdesc character varying(100),
    healthcarefacilitycode character varying(100),
    healthcarefacilitycodestd character varying(100),
    healthcarefacilitydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    visitdescription character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".transplantlist OWNER TO ukrdc;

--
-- Name: treatment; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".treatment (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    encounternumber character varying(100),
    encountertype character varying(100),
    fromtime timestamp without time zone,
    totime timestamp without time zone,
    admittingcliniciancode character varying(100),
    admittingcliniciancodestd character varying(100),
    admittingcliniciandesc character varying(100),
    admitreasoncode character varying(100),
    admitreasoncodestd character varying(100),
    admitreasondesc character varying(100),
    admissionsourcecode character varying(100),
    admissionsourcecodestd character varying(100),
    admissionsourcedesc character varying(100),
    dischargereasoncode character varying(100),
    dischargereasoncodestd character varying(100),
    dischargereasondesc character varying(100),
    dischargelocationcode character varying(100),
    dischargelocationcodestd character varying(100),
    dischargelocationdesc character varying(100),
    healthcarefacilitycode character varying(100),
    healthcarefacilitycodestd character varying(100),
    healthcarefacilitydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    visitdescription character varying(255),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    hdp01 character varying(255),
    hdp02 character varying(255),
    hdp03 character varying(255),
    hdp04 character varying(255),
    qbl05 character varying(255),
    qbl06 character varying(255),
    qbl07 character varying(255),
    erf61 character varying(255),
    pat35 character varying(255),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".treatment OWNER TO ukrdc;

--
-- Name: ukrdc_ods_gp_codes; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".ukrdc_ods_gp_codes (
    code character varying(8) NOT NULL,
    name character varying(50),
    address1 character varying(35),
    postcode character varying(8),
    phone character varying(12),
    type "extract".gp_type,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".ukrdc_ods_gp_codes OWNER TO ukrdc;

--
-- Name: validationerror; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".validationerror (
    vid integer NOT NULL,
    pid character varying(30) NOT NULL,
    updatedon timestamp without time zone,
    errortype integer NOT NULL,
    message character varying(200),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".validationerror OWNER TO ukrdc;

--
-- Name: validationerror_vid_seq; Type: SEQUENCE; Schema: extract; Owner: ukrdc
--

CREATE SEQUENCE "extract".validationerror_vid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE "extract".validationerror_vid_seq OWNER TO ukrdc;

--
-- Name: validationerror_vid_seq; Type: SEQUENCE OWNED BY; Schema: extract; Owner: ukrdc
--

ALTER SEQUENCE "extract".validationerror_vid_seq OWNED BY "extract".validationerror.vid;


--
-- Name: value_exclusion; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".value_exclusion (
    system character varying(20) NOT NULL,
    norm_value character varying(100) NOT NULL
);


ALTER TABLE "extract".value_exclusion OWNER TO ukrdc;

--
-- Name: vascularaccess; Type: TABLE; Schema: extract; Owner: ukrdc
--

CREATE TABLE "extract".vascularaccess (
    id character varying(100) NOT NULL,
    pid character varying(30) NOT NULL,
    idx integer,
    proceduretypecode character varying(100),
    proceduretypecodestd character varying(100),
    proceduretypedesc character varying(100),
    cliniciancode character varying(100),
    cliniciancodestd character varying(100),
    cliniciandesc character varying(100),
    proceduretime timestamp without time zone,
    enteredbycode character varying(100),
    enteredbycodestd character varying(100),
    enteredbydesc character varying(100),
    enteredatcode character varying(100),
    enteredatcodestd character varying(100),
    enteredatdesc character varying(100),
    updatedon timestamp without time zone,
    actioncode character varying(3),
    externalid character varying(100),
    acc19 character varying(255),
    acc20 character varying(255),
    acc21 character varying(255),
    acc22 character varying(255),
    acc30 character varying(255),
    acc40 character varying(255),
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE "extract".vascularaccess OWNER TO ukrdc;

--
-- Name: vwe_pkb_members; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_pkb_members AS
 SELECT DISTINCT pr.ukrdcid
   FROM ("extract".programmembership pm
     JOIN "extract".patientrecord pr ON (((pm.pid)::text = (pr.pid)::text)))
  WHERE (((pm.programname)::text ~~ 'PKB%'::text) AND (pm.totime IS NULL));


ALTER VIEW "extract".vwe_pkb_members OWNER TO ukrdc;

--
-- Name: vwe_extract_pkb_deceased; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pkb_deceased AS
 SELECT DISTINCT pr.ukrdcid
   FROM ("extract".patientrecord pr
     JOIN "extract".vwe_pkb_members ON (((pr.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
  WHERE ((pr.ukrdcid)::text IN ( SELECT a.ukrdcid
           FROM ("extract".patientrecord a
             JOIN "extract".patient b ON (((a.pid)::text = (b.pid)::text)))
          WHERE (b.deathtime IS NOT NULL)));


ALTER VIEW "extract".vwe_extract_pkb_deceased OWNER TO ukrdc;

--
-- Name: vwe_pkb_test_patients; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_pkb_test_patients AS
 SELECT DISTINCT pid
   FROM "extract".patientnumber
  WHERE ((patientid)::text = ANY (ARRAY[('4802588151'::character varying)::text, ('4587392774'::character varying)::text]));


ALTER VIEW "extract".vwe_pkb_test_patients OWNER TO ukrdc;

--
-- Name: vwe_extract_pkb_deceased_test; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pkb_deceased_test AS
 SELECT DISTINCT ukrdcid
   FROM "extract".patientrecord pr
  WHERE ((pid)::text IN ( SELECT vwe_pkb_test_patients.pid
           FROM "extract".vwe_pkb_test_patients));


ALTER VIEW "extract".vwe_extract_pkb_deceased_test OWNER TO ukrdc;

--
-- Name: vwe_pv_members; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_pv_members AS
 SELECT DISTINCT pr.ukrdcid
   FROM ("extract".programmembership pm
     JOIN "extract".patientrecord pr ON (((pm.pid)::text = (pr.pid)::text)))
  WHERE (((pm.programname)::text ~~ 'PV.%'::text) AND (pm.totime IS NULL));


ALTER VIEW "extract".vwe_pv_members OWNER TO ukrdc;

--
-- Name: vwe_extract_pkb_new; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pkb_new AS
 SELECT DISTINCT ukrdcid
   FROM "extract".patientrecord pr
  WHERE ((NOT ((ukrdcid)::text IN ( SELECT vwe_pkb_members.ukrdcid
           FROM "extract".vwe_pkb_members))) AND ((ukrdcid)::text IN ( SELECT vwe_pv_members.ukrdcid
           FROM "extract".vwe_pv_members)) AND (NOT ((ukrdcid)::text IN ( SELECT a.ukrdcid
           FROM ("extract".patientrecord a
             JOIN "extract".patient b ON (((a.pid)::text = (b.pid)::text)))
          WHERE (b.deathtime IS NOT NULL)))));


ALTER VIEW "extract".vwe_extract_pkb_new OWNER TO ukrdc;

--
-- Name: vwe_extract_pkb_new_test; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pkb_new_test AS
 SELECT DISTINCT ukrdcid
   FROM "extract".patientrecord pr
  WHERE ((pid)::text IN ( SELECT vwe_pkb_test_patients.pid
           FROM "extract".vwe_pkb_test_patients));


ALTER VIEW "extract".vwe_extract_pkb_new_test OWNER TO ukrdc;

--
-- Name: vwe_extract_pkb_updates; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pkb_updates AS
 SELECT patientrecord.pid,
    NULL::text AS id,
    'ADT_A28'::text AS msg_type
   FROM (("extract".patientrecord
     JOIN "extract".vwe_pkb_members ON (((patientrecord.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
     JOIN "extract".facility ON (((patientrecord.sendingfacility)::text = (facility.code)::text)))
  WHERE (((((patientrecord.sendingextract)::text = 'UKRDC'::text) AND (facility.ukrdc_out_pkb = true)) OR (((patientrecord.sendingextract)::text = 'PV'::text) AND (facility.pv_out_pkb = true))) AND (((patientrecord.update_date IS NULL) AND (patientrecord.creation_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR (EXISTS ( SELECT medication.id
           FROM "extract".medication
          WHERE (((medication.pid)::text = (patientrecord.pid)::text) AND (((medication.update_date IS NULL) AND (medication.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((medication.update_date IS NOT NULL) AND (medication.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))))))) OR (EXISTS ( SELECT diagnosis.id
           FROM "extract".diagnosis
          WHERE (((diagnosis.pid)::text = (patientrecord.pid)::text) AND (((diagnosis.update_date IS NULL) AND (diagnosis.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((diagnosis.update_date IS NOT NULL) AND (diagnosis.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))))))) OR (EXISTS ( SELECT renaldiagnosis.pid
           FROM "extract".renaldiagnosis
          WHERE (((renaldiagnosis.pid)::text = (patientrecord.pid)::text) AND (((renaldiagnosis.update_date IS NULL) AND (renaldiagnosis.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((renaldiagnosis.update_date IS NOT NULL) AND (renaldiagnosis.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar))))))))))
UNION ALL
 SELECT patientrecord.pid,
    NULL::text AS id,
    'MDM_T02_CP'::text AS msg_type
   FROM ((("extract".patientrecord
     LEFT JOIN "extract".pvdata ON (((patientrecord.pid)::text = (pvdata.id)::text)))
     JOIN "extract".vwe_pkb_members ON (((patientrecord.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
     JOIN "extract".facility ON (((patientrecord.sendingfacility)::text = (facility.code)::text)))
  WHERE (((((patientrecord.sendingextract)::text = 'UKRDC'::text) AND (facility.ukrdc_out_pkb = true)) OR (((patientrecord.sendingextract)::text = 'PV'::text) AND (facility.pv_out_pkb = true))) AND (((pvdata.update_date IS NULL) AND (pvdata.creation_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((pvdata.update_date IS NOT NULL) AND (pvdata.update_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR (EXISTS ( SELECT diagnosis.id
           FROM "extract".diagnosis
          WHERE (((diagnosis.pid)::text = (patientrecord.pid)::text) AND (((diagnosis.update_date IS NULL) AND (diagnosis.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((diagnosis.update_date IS NOT NULL) AND (diagnosis.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))))))) OR (EXISTS ( SELECT renaldiagnosis.pid
           FROM "extract".renaldiagnosis
          WHERE (((renaldiagnosis.pid)::text = (patientrecord.pid)::text) AND (((renaldiagnosis.update_date IS NULL) AND (renaldiagnosis.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((renaldiagnosis.update_date IS NOT NULL) AND (renaldiagnosis.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))))))) OR (EXISTS ( SELECT a.id
           FROM ("extract".pvdata a
             JOIN "extract".patientrecord b ON (((a.id)::text = (b.pid)::text)))
          WHERE (((b.ukrdcid)::text = (patientrecord.ukrdcid)::text) AND ((b.sendingfacility)::text = 'NHSBT'::text) AND (((a.update_date IS NULL) AND (a.creation_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((a.update_date IS NOT NULL) AND (a.update_date > ( SELECT eventcontrol.eventdate
                   FROM "extract".eventcontrol
                  WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar))))))))))
UNION ALL
 SELECT document.pid,
    document.id,
    'MDM_T02_DOC'::text AS msg_type
   FROM ((("extract".document
     JOIN "extract".patientrecord ON (((document.pid)::text = (patientrecord.pid)::text)))
     JOIN "extract".vwe_pkb_members ON (((patientrecord.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
     JOIN "extract".facility ON (((patientrecord.sendingfacility)::text = (facility.code)::text)))
  WHERE (((((patientrecord.sendingextract)::text = 'UKRDC'::text) AND (facility.ukrdc_out_pkb = true)) OR (((patientrecord.sendingextract)::text = 'PV'::text) AND (facility.pv_out_pkb = true))) AND (((document.update_date IS NULL) AND (document.creation_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((document.update_date IS NOT NULL) AND (document.update_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar))))))
UNION ALL
 SELECT laborder.pid,
    laborder.id,
    'ORU_R01_LAB'::text AS msg_type
   FROM ((("extract".laborder
     JOIN "extract".patientrecord ON (((laborder.pid)::text = (patientrecord.pid)::text)))
     JOIN "extract".vwe_pkb_members ON (((patientrecord.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
     JOIN "extract".facility ON (((patientrecord.sendingfacility)::text = (facility.code)::text)))
  WHERE (((((patientrecord.sendingextract)::text = 'UKRDC'::text) AND (facility.ukrdc_out_pkb = true)) OR (((patientrecord.sendingextract)::text = 'PV'::text) AND (facility.pv_out_pkb = true))) AND (((laborder.update_date IS NULL) AND (laborder.creation_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((laborder.update_date IS NOT NULL) AND (laborder.update_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((laborder.repository_update_date IS NOT NULL) AND (laborder.repository_update_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar))))))
UNION ALL
 SELECT observation.pid,
    observation.id,
    'ORU_R01_OBS'::text AS msg_type
   FROM ((("extract".observation
     JOIN "extract".patientrecord ON (((observation.pid)::text = (patientrecord.pid)::text)))
     JOIN "extract".vwe_pkb_members ON (((patientrecord.ukrdcid)::text = (vwe_pkb_members.ukrdcid)::text)))
     JOIN "extract".facility ON (((patientrecord.sendingfacility)::text = (facility.code)::text)))
  WHERE (((((patientrecord.sendingextract)::text = 'UKRDC'::text) AND (facility.ukrdc_out_pkb = true)) OR (((patientrecord.sendingextract)::text = 'PV'::text) AND (facility.pv_out_pkb = true))) AND (((observation.update_date IS NULL) AND (observation.creation_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar)))) OR ((observation.update_date IS NOT NULL) AND (observation.update_date > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PKBEXTRACT'::bpchar))))));


ALTER VIEW "extract".vwe_extract_pkb_updates OWNER TO ukrdc;

--
-- Name: vwe_extract_pv_pvxml; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pv_pvxml AS
 SELECT pr.pid
   FROM ("extract".patientrecord pr
     JOIN "extract".vwe_pv_members ON (((pr.ukrdcid)::text = (vwe_pv_members.ukrdcid)::text)))
  WHERE (((pr.sendingextract)::text = ANY (ARRAY[('PV'::character varying)::text, ('UKRDC'::character varying)::text])) AND ((pr.sendingfacility)::text <> ALL (ARRAY[('PV'::character varying)::text, ('PKB'::character varying)::text, ('NHSBT'::character varying)::text, ('TRACING'::character varying)::text])) AND (pr.repositoryupdatedate > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PVEXTRACT'::bpchar))));


ALTER VIEW "extract".vwe_extract_pv_pvxml OWNER TO ukrdc;

--
-- Name: vwe_extract_pv_pvxml_eligable; Type: VIEW; Schema: extract; Owner: postgres
--

CREATE VIEW "extract".vwe_extract_pv_pvxml_eligable AS
 SELECT pid
   FROM "extract".patientrecord pr
  WHERE (((sendingextract)::text = ANY (ARRAY[('PV'::character varying)::text, ('UKRDC'::character varying)::text])) AND ((sendingfacility)::text <> 'PV'::text) AND ((ukrdcid)::text IN ( SELECT pr2.ukrdcid
           FROM ("extract".programmembership pm
             JOIN "extract".patientrecord pr2 ON (((pm.pid)::text = (pr2.pid)::text)))
          WHERE (((pm.programname)::text ~~ 'PV.%'::text) AND (pm.totime IS NULL)))));


ALTER VIEW "extract".vwe_extract_pv_pvxml_eligable OWNER TO postgres;

--
-- Name: vwe_extract_pv_rda; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_pv_rda AS
 SELECT pid
   FROM "extract".patientrecord pr
  WHERE (((sendingextract)::text = 'SURVEY'::text) AND (repositoryupdatedate > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'PVSURVEYEXTRACT'::bpchar))) AND ((ukrdcid)::text IN ( SELECT pr2.ukrdcid
           FROM ("extract".programmembership pm
             JOIN "extract".patientrecord pr2 ON (((pm.pid)::text = (pr2.pid)::text)))
          WHERE (((pm.programname)::text ~~ 'PV.%'::text) AND (pm.totime IS NULL)))));


ALTER VIEW "extract".vwe_extract_pv_rda OWNER TO ukrdc;

--
-- Name: vwe_extract_radar; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_extract_radar AS
 SELECT pid,
    sendingfacility
   FROM "extract".patientrecord pr
  WHERE (((((sendingextract)::text = ANY (ARRAY[('PV'::character varying)::text, ('UKRDC'::character varying)::text])) AND (repositoryupdatedate > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'RADAREXTRACT'::bpchar)))) OR (((sendingextract)::text = 'RADAR'::text) AND (repositorycreationdate > ( SELECT eventcontrol.eventdate
           FROM "extract".eventcontrol
          WHERE (eventcontrol.eventtype = 'RADAREXTRACT'::bpchar))))) AND ((ukrdcid)::text IN ( SELECT pr2.ukrdcid
           FROM ("extract".programmembership pm
             JOIN "extract".patientrecord pr2 ON (((pm.pid)::text = (pr2.pid)::text)))
          WHERE (((pm.programname)::text = ANY (ARRAY[('RADAR'::character varying)::text, ('NURTURE'::character varying)::text])) AND (pm.totime IS NULL)))) AND (NOT (EXISTS ( SELECT 1
           FROM ("extract".programmembership pm2
             JOIN "extract".patientrecord pr3 ON (((pm2.pid)::text = (pr3.pid)::text)))
          WHERE (((pr3.ukrdcid)::text = (pr.ukrdcid)::text) AND ((pm2.programname)::text = ANY (ARRAY[('RADAR.COHORT.NOCON'::character varying)::text, ('RADAR.COHORT.CONS_WTDWN'::character varying)::text])) AND (pm2.totime IS NULL))))));


ALTER VIEW "extract".vwe_extract_radar OWNER TO ukrdc;

--
-- Name: vwe_facility_relationship; Type: MATERIALIZED VIEW; Schema: extract; Owner: ukrdc
--

CREATE MATERIALIZED VIEW "extract".vwe_facility_relationship AS
 SELECT f2.facilitycode AS parentfacilitycode,
    f2.facilitycodestd AS parentfacilitycodestd,
    f1.facilitycode AS childfacilitycode,
    f1.facilitycodestd AS childfacilitycodestd,
        CASE
            WHEN (((f1.facilitycodestd)::text = 'RR1+'::text) AND ((f2.facilitycodestd)::text = 'RR1+'::text) AND ((cm.source_coding_standard)::text = 'RR1+_FEEDSHARE_CHILD'::text) AND ((cm.destination_coding_standard)::text = 'RR1+_FEEDSHARE_PARENT'::text)) THEN 'FEED-SHARE'::text
            WHEN (((f1.facilitycodestd)::text = 'RR1+'::text) AND ((f2.facilitycodestd)::text = 'RR1+'::text) AND ((cm.source_coding_standard)::text = 'RR1+_SATELLITE'::text) AND ((cm.destination_coding_standard)::text = 'RR1+_MAIN'::text)) THEN 'MAIN-SATELLITE'::text
            WHEN (((f1.facilitycodestd)::text = 'RR1+'::text) AND ((f2.facilitycodestd)::text = 'RR1+'::text) AND ((cm.source_coding_standard)::text = 'RR1+_CURRENT'::text) AND ((cm.destination_coding_standard)::text = 'RR1+_DEPRECATED'::text)) THEN 'DEPRECATED-CURRENT'::text
            ELSE NULL::text
        END AS relationshiptype
   FROM (("extract".facility_new f1
     JOIN "extract".code_map cm ON (((f1.facilitycode)::text = (cm.source_code)::text)))
     JOIN "extract".facility_new f2 ON (((f2.facilitycode)::text = (cm.destination_code)::text)))
  WHERE ((cm.source_coding_standard)::text = ANY (ARRAY[('RR1+_FEEDSHARE_CHILD'::character varying)::text, ('RR1+_SATELLITE'::character varying)::text, ('RR1+_CURRENT'::character varying)::text]))
  WITH NO DATA;


ALTER MATERIALIZED VIEW "extract".vwe_facility_relationship OWNER TO ukrdc;

--
-- Name: vwe_result_types; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_result_types AS
 SELECT a.sendingfacility,
    c.serviceidcodestd,
    c.serviceidcode,
    c.serviceiddesc,
    c.resultvalueunits,
    count(*) AS result_count
   FROM (("extract".patientrecord a
     JOIN "extract".laborder b ON (((a.pid)::text = (b.pid)::text)))
     JOIN "extract".resultitem c ON (((c.orderid)::text = (b.id)::text)))
  WHERE (((a.sendingextract)::text = ANY (ARRAY[('PV'::character varying)::text, ('UKRDC'::character varying)::text])) AND (c.observationtime > '2023-01-01 00:00:00'::timestamp without time zone))
  GROUP BY a.sendingfacility, c.serviceidcodestd, c.serviceidcode, c.serviceiddesc, c.resultvalueunits
  ORDER BY c.serviceidcodestd, c.serviceidcode;


ALTER VIEW "extract".vwe_result_types OWNER TO ukrdc;

--
-- Name: vwe_satellite_map; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_satellite_map AS
 SELECT parentfacilitycode AS main_unit_code,
    childfacilitycode AS satellite_code
   FROM "extract".vwe_facility_relationship
  WHERE (relationshiptype = 'MAIN-SATELLITE'::text);


ALTER VIEW "extract".vwe_satellite_map OWNER TO ukrdc;

--
-- Name: vwe_survey_data; Type: VIEW; Schema: extract; Owner: ukrdc
--

CREATE VIEW "extract".vwe_survey_data AS
SELECT
    NULL::character varying(30) AS pid,
    NULL::character varying(7) AS sendingfacility,
    NULL::character varying(256) AS sendingfacility_desc,
    NULL::character varying(10) AS main_unit_code,
    NULL::character varying(256) AS main_unit_desc,
    NULL::timestamp without time zone AS repositorycreationdate,
    NULL::character varying(50) AS "NHS Number",
    NULL::character varying(60) AS forename,
    NULL::character varying(60) AS surname,
    NULL::timestamp without time zone AS dob,
    NULL::character varying(100) AS ethnicity,
    NULL::character varying(2) AS gender,
    NULL::character varying(10) AS "Post Code",
    NULL::timestamp without time zone AS "Date Completed",
    NULL::character varying(100) AS enteredatcode,
    NULL::text AS ysq1,
    NULL::text AS ysq2,
    NULL::text AS ysq3,
    NULL::text AS ysq4,
    NULL::text AS ysq5,
    NULL::text AS ysq6,
    NULL::text AS ysq7,
    NULL::text AS ysq8,
    NULL::text AS ysq9,
    NULL::text AS ysq10,
    NULL::text AS ysq11,
    NULL::text AS ysq12,
    NULL::text AS ysq13,
    NULL::text AS ysq14,
    NULL::text AS ysq15,
    NULL::text AS ysq16,
    NULL::text AS ysq17,
    NULL::text AS yohq1,
    NULL::text AS yohq2,
    NULL::text AS yohq3,
    NULL::text AS yohq4,
    NULL::text AS yohq5,
    NULL::text AS myhq1,
    NULL::text AS myhq2,
    NULL::text AS myhq3,
    NULL::text AS myhq4,
    NULL::text AS myhq5,
    NULL::text AS myhq6,
    NULL::text AS myhq7,
    NULL::text AS myhq8,
    NULL::text AS myhq9,
    NULL::text AS myhq10,
    NULL::text AS myhq11,
    NULL::text AS myhq12,
    NULL::text AS myhq13,
    NULL::text AS pam_13_score,
    NULL::text AS pam_13_level,
    NULL::text AS shq1,
    NULL::text AS shq2,
    NULL::text AS shq3,
    NULL::text AS shq4,
    NULL::text AS shq5,
    NULL::text AS shq6,
    NULL::text AS shq7,
    NULL::text AS shq8,
    NULL::text AS shq9,
    NULL::text AS shq10,
    NULL::text AS shq11,
    NULL::text AS shq12,
    NULL::text AS shq13,
    NULL::text AS shq14,
    NULL::text AS shq15,
    NULL::text AS shq16,
    NULL::text AS shq17,
    NULL::text AS yhs1,
    NULL::text AS yhs2,
    NULL::text AS yhs3,
    NULL::text AS yhs4,
    NULL::text AS yhs5,
    NULL::text AS yhs6,
    NULL::text AS yhs,
    NULL::text AS shd,
    NULL::text AS lcc;


ALTER VIEW "extract".vwe_survey_data OWNER TO ukrdc;

--
-- Name: issue; Type: TABLE; Schema: investigations; Owner: ukrdc
--

CREATE TABLE investigations.issue (
    id integer NOT NULL,
    issue_id integer,
    date_created timestamp without time zone NOT NULL,
    error_message text,
    filename character varying(100),
    xml_file_id integer,
    is_resolved boolean DEFAULT false NOT NULL,
    is_blocking boolean DEFAULT true NOT NULL,
    status_id integer DEFAULT 0,
    priority integer,
    attributes json
);


ALTER TABLE investigations.issue OWNER TO ukrdc;

--
-- Name: issue_id_seq; Type: SEQUENCE; Schema: investigations; Owner: ukrdc
--

CREATE SEQUENCE investigations.issue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE investigations.issue_id_seq OWNER TO ukrdc;

--
-- Name: issue_id_seq; Type: SEQUENCE OWNED BY; Schema: investigations; Owner: ukrdc
--

ALTER SEQUENCE investigations.issue_id_seq OWNED BY investigations.issue.id;


--
-- Name: issuetype; Type: TABLE; Schema: investigations; Owner: ukrdc
--

CREATE TABLE investigations.issuetype (
    id integer NOT NULL,
    issue_type character varying(100) NOT NULL,
    is_domain_issue boolean NOT NULL
);


ALTER TABLE investigations.issuetype OWNER TO ukrdc;

--
-- Name: issuetype_id_seq; Type: SEQUENCE; Schema: investigations; Owner: ukrdc
--

CREATE SEQUENCE investigations.issuetype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE investigations.issuetype_id_seq OWNER TO ukrdc;

--
-- Name: issuetype_id_seq; Type: SEQUENCE OWNED BY; Schema: investigations; Owner: ukrdc
--

ALTER SEQUENCE investigations.issuetype_id_seq OWNED BY investigations.issuetype.id;


--
-- Name: patientid; Type: TABLE; Schema: investigations; Owner: ukrdc
--

CREATE TABLE investigations.patientid (
    id integer NOT NULL,
    pid character varying(50),
    ukrdcid character varying(50)
);


ALTER TABLE investigations.patientid OWNER TO ukrdc;

--
-- Name: patientid_id_seq; Type: SEQUENCE; Schema: investigations; Owner: ukrdc
--

CREATE SEQUENCE investigations.patientid_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE investigations.patientid_id_seq OWNER TO ukrdc;

--
-- Name: patientid_id_seq; Type: SEQUENCE OWNED BY; Schema: investigations; Owner: ukrdc
--

ALTER SEQUENCE investigations.patientid_id_seq OWNED BY investigations.patientid.id;


--
-- Name: patientidtoissue; Type: TABLE; Schema: investigations; Owner: ukrdc
--

CREATE TABLE investigations.patientidtoissue (
    id integer NOT NULL,
    patient_id integer,
    issue_id integer,
    rank integer
);


ALTER TABLE investigations.patientidtoissue OWNER TO ukrdc;

--
-- Name: patientidtoissue_id_seq; Type: SEQUENCE; Schema: investigations; Owner: ukrdc
--

CREATE SEQUENCE investigations.patientidtoissue_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE investigations.patientidtoissue_id_seq OWNER TO ukrdc;

--
-- Name: patientidtoissue_id_seq; Type: SEQUENCE OWNED BY; Schema: investigations; Owner: ukrdc
--

ALTER SEQUENCE investigations.patientidtoissue_id_seq OWNED BY investigations.patientidtoissue.id;


--
-- Name: status; Type: TABLE; Schema: investigations; Owner: ukrdc
--

CREATE TABLE investigations.status (
    id integer NOT NULL,
    status character varying(100) NOT NULL
);


ALTER TABLE investigations.status OWNER TO ukrdc;

--
-- Name: status_id_seq; Type: SEQUENCE; Schema: investigations; Owner: ukrdc
--

CREATE SEQUENCE investigations.status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE investigations.status_id_seq OWNER TO ukrdc;

--
-- Name: status_id_seq; Type: SEQUENCE OWNED BY; Schema: investigations; Owner: ukrdc
--

ALTER SEQUENCE investigations.status_id_seq OWNED BY investigations.status.id;


--
-- Name: xmlfile; Type: TABLE; Schema: investigations; Owner: postgres
--

CREATE TABLE investigations.xmlfile (
    id integer NOT NULL,
    file_hash character varying(64) NOT NULL,
    file text NOT NULL,
    is_reprocessed boolean DEFAULT false
);


ALTER TABLE investigations.xmlfile OWNER TO postgres;

--
-- Name: code_exclusion; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.code_exclusion (
    coding_standard character varying NOT NULL,
    code character varying NOT NULL,
    system character varying NOT NULL
);


ALTER TABLE public.code_exclusion OWNER TO postgres;

--
-- Name: code_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.code_map (
    source_coding_standard character varying(256) NOT NULL,
    source_code character varying(256) NOT NULL,
    destination_coding_standard character varying(256) NOT NULL,
    destination_code character varying(256) NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE public.code_map OWNER TO postgres;

--
-- Name: modality_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modality_codes (
    registry_code character varying(8) NOT NULL,
    registry_code_desc character varying(100),
    registry_code_type character varying(3) NOT NULL,
    acute bit(1) NOT NULL,
    transfer_in bit(1) NOT NULL,
    ckd bit(1) NOT NULL,
    cons bit(1) NOT NULL,
    rrt bit(1) NOT NULL,
    equiv_modality character varying(8),
    end_of_care bit(1) NOT NULL,
    is_imprecise bit(1) NOT NULL,
    nhsbt_transplant_type character varying(4),
    transfer_out bit(1)
);


ALTER TABLE public.modality_codes OWNER TO postgres;

--
-- Name: rr_codes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rr_codes (
    id character varying NOT NULL,
    rr_code character varying NOT NULL,
    description_1 character varying(255),
    description_2 character varying(70),
    description_3 character varying(60),
    old_value character varying(10),
    old_value_2 character varying(10),
    new_value character varying(10)
);


ALTER TABLE public.rr_codes OWNER TO postgres;

--
-- Name: rr_data_definition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rr_data_definition (
    upload_key character varying(5) NOT NULL,
    "TABLE_NAME" character varying(30) NOT NULL,
    feild_name character varying(30) NOT NULL,
    code_id character varying(10),
    mandatory numeric(1,0),
    "TYPE" character varying(1),
    alt_constraint character varying(30),
    alt_desc character varying(30),
    extra_val character varying(1),
    error_type integer,
    paed_mand numeric(1,0),
    ckd5_mand numeric(1,0),
    dependant_field character varying(30),
    alt_validation character varying(30),
    file_prefix character varying(20),
    load_min numeric(38,4),
    load_max numeric(38,4),
    remove_min numeric(38,4),
    remove_max numeric(38,4),
    in_month numeric(1,0),
    aki_mand numeric(1,0),
    rrt_mand numeric(1,0),
    cons_mand numeric(1,0),
    ckd4_mand numeric(1,0),
    valid_before_dob numeric(1,0),
    valid_after_dod numeric(1,0),
    in_quarter numeric(1,0)
);


ALTER TABLE public.rr_data_definition OWNER TO postgres;

--
-- Name: satellite_map; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.satellite_map (
    satellite_code character varying(10) NOT NULL,
    main_unit_code character varying(10) NOT NULL,
    creation_date timestamp without time zone DEFAULT now() NOT NULL,
    update_date timestamp without time zone
);


ALTER TABLE public.satellite_map OWNER TO postgres;

--
-- Name: pkb_links id; Type: DEFAULT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pkb_links ALTER COLUMN id SET DEFAULT nextval('"extract".pkb_links_id_seq'::regclass);


--
-- Name: pvdelete did; Type: DEFAULT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pvdelete ALTER COLUMN did SET DEFAULT nextval('"extract".pvdelete_did_seq'::regclass);


--
-- Name: validationerror vid; Type: DEFAULT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".validationerror ALTER COLUMN vid SET DEFAULT nextval('"extract".validationerror_vid_seq'::regclass);


--
-- Name: address address_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".address
    ADD CONSTRAINT address_pkey PRIMARY KEY (id);


--
-- Name: allergy allergy_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".allergy
    ADD CONSTRAINT allergy_pkey PRIMARY KEY (id);


--
-- Name: assessment assessment_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".assessment
    ADD CONSTRAINT assessment_pkey PRIMARY KEY (id);


--
-- Name: causeofdeath causeofdeath_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".causeofdeath
    ADD CONSTRAINT causeofdeath_pkey PRIMARY KEY (pid);


--
-- Name: clinicalrelationship clinicalrelationship_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".clinicalrelationship
    ADD CONSTRAINT clinicalrelationship_pkey PRIMARY KEY (id);


--
-- Name: code_exclusion code_exclusion_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".code_exclusion
    ADD CONSTRAINT code_exclusion_pkey PRIMARY KEY (coding_standard, code, system);


--
-- Name: code_list code_list_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".code_list
    ADD CONSTRAINT code_list_pkey PRIMARY KEY (coding_standard, code);


--
-- Name: code_map code_map_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".code_map
    ADD CONSTRAINT code_map_pkey PRIMARY KEY (source_coding_standard, source_code, destination_coding_standard, destination_code);


--
-- Name: contactdetail contactdetail_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".contactdetail
    ADD CONSTRAINT contactdetail_pkey PRIMARY KEY (id);


--
-- Name: diagnosis diagnosis_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".diagnosis
    ADD CONSTRAINT diagnosis_pkey PRIMARY KEY (id);


--
-- Name: dialysisprescription dialysisprescription_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".dialysisprescription
    ADD CONSTRAINT dialysisprescription_pkey PRIMARY KEY (id);


--
-- Name: dialysissession dialysissession_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".dialysissession
    ADD CONSTRAINT dialysissession_pkey PRIMARY KEY (id);


--
-- Name: document document_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".document
    ADD CONSTRAINT document_pkey PRIMARY KEY (id);


--
-- Name: encounter encounter_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".encounter
    ADD CONSTRAINT encounter_pkey PRIMARY KEY (id);


--
-- Name: eventcontrol eventcontrol_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".eventcontrol
    ADD CONSTRAINT eventcontrol_pkey PRIMARY KEY (eventtype);


--
-- Name: facility_new facility_new_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".facility_new
    ADD CONSTRAINT facility_new_pkey PRIMARY KEY (facilitycode, facilitycodestd);


--
-- Name: familydoctor familydoctor_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familydoctor
    ADD CONSTRAINT familydoctor_pkey PRIMARY KEY (id);


--
-- Name: familyhistory familyhistory_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familyhistory
    ADD CONSTRAINT familyhistory_pkey PRIMARY KEY (id);


--
-- Name: laborder laborder_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".laborder
    ADD CONSTRAINT laborder_pkey PRIMARY KEY (id);


--
-- Name: level level_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".level
    ADD CONSTRAINT level_pkey PRIMARY KEY (id);


--
-- Name: medication medication_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".medication
    ADD CONSTRAINT medication_pkey PRIMARY KEY (id);


--
-- Name: name name_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".name
    ADD CONSTRAINT name_pkey PRIMARY KEY (id);


--
-- Name: observation observation_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".observation
    ADD CONSTRAINT observation_pkey PRIMARY KEY (id);


--
-- Name: optout optout_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".optout
    ADD CONSTRAINT optout_pkey PRIMARY KEY (id);


--
-- Name: patient patient_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patient
    ADD CONSTRAINT patient_pkey PRIMARY KEY (pid);


--
-- Name: patientnumber patientnumber_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patientnumber
    ADD CONSTRAINT patientnumber_pkey PRIMARY KEY (id);


--
-- Name: patientrecord patientrecord_key2; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patientrecord
    ADD CONSTRAINT patientrecord_key2 UNIQUE (sendingfacility, sendingextract, localpatientid);


--
-- Name: patientrecord patientrecord_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patientrecord
    ADD CONSTRAINT patientrecord_pkey PRIMARY KEY (pid);


--
-- Name: facility pk_facility; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".facility
    ADD CONSTRAINT pk_facility PRIMARY KEY (code);


--
-- Name: ukrdc_ods_gp_codes pk_ukrdc_ods_gp_codes; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".ukrdc_ods_gp_codes
    ADD CONSTRAINT pk_ukrdc_ods_gp_codes PRIMARY KEY (code);


--
-- Name: pkb_links pkb_links_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pkb_links
    ADD CONSTRAINT pkb_links_pkey PRIMARY KEY (id);


--
-- Name: procedure procedure_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".procedure
    ADD CONSTRAINT procedure_pkey PRIMARY KEY (id);


--
-- Name: programmembership programmembership_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".programmembership
    ADD CONSTRAINT programmembership_pkey PRIMARY KEY (id);


--
-- Name: pvdata pvdata_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pvdata
    ADD CONSTRAINT pvdata_pkey PRIMARY KEY (id);


--
-- Name: pvdelete pvdelete_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pvdelete
    ADD CONSTRAINT pvdelete_pkey PRIMARY KEY (did);


--
-- Name: question question_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".question
    ADD CONSTRAINT question_pkey PRIMARY KEY (id);


--
-- Name: renaldiagnosis renaldiagnosis_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".renaldiagnosis
    ADD CONSTRAINT renaldiagnosis_pkey PRIMARY KEY (pid);


--
-- Name: resultitem resultitem_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".resultitem
    ADD CONSTRAINT resultitem_pkey PRIMARY KEY (id);


--
-- Name: satellite_map satellite_map_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".satellite_map
    ADD CONSTRAINT satellite_map_pkey PRIMARY KEY (satellite_code, main_unit_code);


--
-- Name: score score_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".score
    ADD CONSTRAINT score_pkey PRIMARY KEY (id);


--
-- Name: socialhistory socialhistory_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".socialhistory
    ADD CONSTRAINT socialhistory_pkey PRIMARY KEY (id);


--
-- Name: survey survey_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".survey
    ADD CONSTRAINT survey_pkey PRIMARY KEY (id);


--
-- Name: transplant transplant_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".transplant
    ADD CONSTRAINT transplant_pkey PRIMARY KEY (id);


--
-- Name: transplantlist transplantlist_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".transplantlist
    ADD CONSTRAINT transplantlist_pkey PRIMARY KEY (id);


--
-- Name: treatment treatment_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".treatment
    ADD CONSTRAINT treatment_pkey PRIMARY KEY (id);


--
-- Name: validationerror validationerror_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".validationerror
    ADD CONSTRAINT validationerror_pkey PRIMARY KEY (vid);


--
-- Name: value_exclusion value_exclusion_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".value_exclusion
    ADD CONSTRAINT value_exclusion_pkey PRIMARY KEY (system, norm_value);


--
-- Name: vascularaccess vascularaccess_pkey; Type: CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".vascularaccess
    ADD CONSTRAINT vascularaccess_pkey PRIMARY KEY (id);


--
-- Name: ix_address_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_address_pid ON "extract".address USING btree (pid);


--
-- Name: ix_contactdetail_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_contactdetail_pid ON "extract".contactdetail USING btree (pid);


--
-- Name: ix_diagnosis_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_diagnosis_pid ON "extract".diagnosis USING btree (pid);


--
-- Name: ix_dialysissession_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_dialysissession_pid ON "extract".dialysissession USING btree (pid);


--
-- Name: ix_document_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_document_pid ON "extract".document USING btree (pid);


--
-- Name: ix_observation_pid_obstime; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_observation_pid_obstime ON "extract".observation USING btree (pid, observationtime);


--
-- Name: ix_patientrecord_ukrdcid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_patientrecord_ukrdcid ON "extract".patientrecord USING btree (ukrdcid);


--
-- Name: ix_programmembership_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_programmembership_pid ON "extract".programmembership USING btree (pid);


--
-- Name: ix_pvdelete_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_pvdelete_pid ON "extract".pvdelete USING btree (pid);


--
-- Name: ix_treatment_pid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_treatment_pid ON "extract".treatment USING btree (pid);


--
-- Name: ix_treatment_pid_fromtime; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX ix_treatment_pid_fromtime ON "extract".treatment USING btree (pid, fromtime);


--
-- Name: laborder_creation_date_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX laborder_creation_date_idx ON "extract".laborder USING btree (creation_date);


--
-- Name: laborder_pid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX laborder_pid_idx ON "extract".laborder USING btree (pid);


--
-- Name: laborder_repository_update_date_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX laborder_repository_update_date_idx ON "extract".laborder USING btree (repository_update_date);


--
-- Name: laborder_update_date_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX laborder_update_date_idx ON "extract".laborder USING btree (update_date);


--
-- Name: medication_pid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX medication_pid_idx ON "extract".medication USING btree (pid);


--
-- Name: name_pid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX name_pid_idx ON "extract".name USING btree (pid);


--
-- Name: observation_pid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX observation_pid_idx ON "extract".observation USING btree (pid);


--
-- Name: patientnumber_patientid; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX patientnumber_patientid ON "extract".patientnumber USING btree (patientid);


--
-- Name: patientnumber_pid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX patientnumber_pid_idx ON "extract".patientnumber USING btree (pid);


--
-- Name: resultitem_orderid_firstpart; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX resultitem_orderid_firstpart ON "extract".resultitem USING btree ("left"((orderid)::text, '-32'::integer));


--
-- Name: resultitem_orderid_idx; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX resultitem_orderid_idx ON "extract".resultitem USING btree (orderid);


--
-- Name: resultitem_serviceidcode; Type: INDEX; Schema: extract; Owner: ukrdc
--

CREATE INDEX resultitem_serviceidcode ON "extract".resultitem USING btree (serviceidcode);


--
-- Name: vwe_survey_data _RETURN; Type: RULE; Schema: extract; Owner: ukrdc
--

CREATE OR REPLACE VIEW "extract".vwe_survey_data AS
 SELECT a.pid,
    a.sendingfacility,
    i.description AS sendingfacility_desc,
        CASE
            WHEN (k.main_unit_code IS NOT NULL) THEN k.main_unit_code
            ELSE l.main_unit_code
        END AS main_unit_code,
        CASE
            WHEN (k.main_unit_code IS NOT NULL) THEN m.description
            ELSE n.description
        END AS main_unit_desc,
    a.repositorycreationdate,
    h.patientid AS "NHS Number",
    g.given AS forename,
    g.family AS surname,
    f.birthtime AS dob,
    f.ethnicgroupdesc AS ethnicity,
    f.gender,
    j.postcode AS "Post Code",
    b.surveytime AS "Date Completed",
    b.enteredatcode,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ1'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq1,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ2'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq2,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ3'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq3,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ4'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq4,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ5'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq5,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ6'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq6,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ7'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq7,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ8'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq8,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ9'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq9,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ10'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq10,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ11'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq11,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ12'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq12,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ13'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq13,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ14'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq14,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ15'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq15,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ16'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq16,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YSQ17'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS ysq17,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YOHQ1'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yohq1,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YOHQ2'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yohq2,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YOHQ3'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yohq3,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YOHQ4'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yohq4,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YOHQ5'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yohq5,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ1'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq1,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ2'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq2,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ3'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq3,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ4'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq4,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ5'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq5,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ6'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq6,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ7'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq7,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ8'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq8,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ9'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq9,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ10'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq10,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ11'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq11,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ12'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq12,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'MYHQ13'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS myhq13,
    max((
        CASE
            WHEN ((d.scoretypecode)::text = '925431000000109'::text) THEN d.scorevalue
            ELSE NULL::character varying
        END)::text) AS pam_13_score,
    max((
        CASE
            WHEN ((e.leveltypecode)::text = '962851000000103'::text) THEN e.levelvalue
            ELSE NULL::character varying
        END)::text) AS pam_13_level,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ1'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq1,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ2'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq2,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ3'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq3,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ4'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq4,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ5'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq5,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ6'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq6,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ7'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq7,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ8'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq8,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ9'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq9,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ10'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq10,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ11'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq11,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ12'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq12,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ13'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq13,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ14'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq14,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ15'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq15,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ16'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq16,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'SHQ17'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS shq17,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS1'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs1,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS2'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs2,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS3'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs3,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS4'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs4,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS5'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs5,
    max((
        CASE
            WHEN ((c.questiontypecode)::text = 'YHS6'::text) THEN c.response
            ELSE NULL::character varying
        END)::text) AS yhs6,
        CASE
            WHEN (pm_yhs.pid IS NOT NULL) THEN 'YES'::text
            ELSE NULL::text
        END AS yhs,
        CASE
            WHEN (pm_shd.pid IS NOT NULL) THEN 'YES'::text
            ELSE NULL::text
        END AS shd,
        CASE
            WHEN (pm_lcc.pid IS NOT NULL) THEN 'YES'::text
            ELSE NULL::text
        END AS lcc
   FROM (((((((((((((((("extract".patientrecord a
     LEFT JOIN "extract".survey b ON (((a.pid)::text = (b.pid)::text)))
     LEFT JOIN "extract".question c ON (((b.id)::text = (c.surveyid)::text)))
     LEFT JOIN "extract".score d ON (((b.id)::text = (d.surveyid)::text)))
     LEFT JOIN "extract".level e ON (((b.id)::text = (e.surveyid)::text)))
     LEFT JOIN "extract".patient f ON (((a.pid)::text = (f.pid)::text)))
     LEFT JOIN "extract".name g ON ((((a.pid)::text = (g.pid)::text) AND ((g.nameuse)::text = 'L'::text))))
     LEFT JOIN "extract".patientnumber h ON (((a.pid)::text = (h.pid)::text)))
     LEFT JOIN "extract".code_list i ON ((((a.sendingfacility)::text = (i.code)::text) AND ((i.coding_standard)::text = 'RR1+'::text))))
     LEFT JOIN "extract".address j ON (((a.pid)::text = (j.pid)::text)))
     LEFT JOIN "extract".satellite_map k ON (((a.sendingfacility)::text = (k.satellite_code)::text)))
     LEFT JOIN "extract".satellite_map l ON (((a.sendingfacility)::text = (l.main_unit_code)::text)))
     LEFT JOIN "extract".code_list m ON ((((k.main_unit_code)::text = (m.code)::text) AND ((m.coding_standard)::text = 'RR1+'::text))))
     LEFT JOIN "extract".code_list n ON ((((l.main_unit_code)::text = (n.code)::text) AND ((n.coding_standard)::text = 'RR1+'::text))))
     LEFT JOIN "extract".programmembership pm_yhs ON ((((a.pid)::text = (pm_yhs.pid)::text) AND ((pm_yhs.programname)::text = 'YHS'::text))))
     LEFT JOIN "extract".programmembership pm_shd ON ((((a.pid)::text = (pm_shd.pid)::text) AND ((pm_shd.programname)::text = 'SHD'::text))))
     LEFT JOIN "extract".programmembership pm_lcc ON ((((a.pid)::text = (pm_lcc.pid)::text) AND ((pm_lcc.programname)::text = 'LCC'::text))))
  WHERE ((a.sendingextract)::text = 'SURVEY'::text)
  GROUP BY a.pid, a.sendingfacility, i.description, k.main_unit_code, l.main_unit_code, m.description, n.description, a.repositorycreationdate, g.given, g.family, h.patientid, f.birthtime, f.gender, f.ethnicgroupdesc, j.postcode, b.surveytime, b.enteredatcode, pm_yhs.pid, pm_shd.pid, pm_lcc.pid
  ORDER BY a.repositoryupdatedate, a.pid;


--
-- Name: resultitem trg_set_laborder_repository_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_laborder_repository_update_date AFTER INSERT OR DELETE OR UPDATE ON "extract".resultitem FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_laborder_repository_update_date();


--
-- Name: address trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".address FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: allergy trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".allergy FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: causeofdeath trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".causeofdeath FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: clinicalrelationship trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".clinicalrelationship FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: code_list trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".code_list FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: code_map trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".code_map FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: contactdetail trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".contactdetail FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: diagnosis trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".diagnosis FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: dialysissession trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".dialysissession FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: document trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".document FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: encounter trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".encounter FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: eventcontrol trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".eventcontrol FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: facility trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".facility FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: familydoctor trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".familydoctor FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: familyhistory trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".familyhistory FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: laborder trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".laborder FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: level trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".level FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: medication trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".medication FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: name trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".name FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: observation trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".observation FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: optout trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".optout FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: patient trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".patient FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: patientnumber trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".patientnumber FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: patientrecord trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".patientrecord FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: procedure trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".procedure FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: programmembership trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".programmembership FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: pvdata trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".pvdata FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: pvdelete trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".pvdelete FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: question trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".question FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: renaldiagnosis trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".renaldiagnosis FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: resultitem trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".resultitem FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: satellite_map trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".satellite_map FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: score trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".score FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: socialhistory trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".socialhistory FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: survey trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".survey FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: transplant trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".transplant FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: transplantlist trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".transplantlist FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: treatment trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".treatment FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: ukrdc_ods_gp_codes trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".ukrdc_ods_gp_codes FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: validationerror trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".validationerror FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: vascularaccess trg_set_update_date; Type: TRIGGER; Schema: extract; Owner: ukrdc
--

CREATE TRIGGER trg_set_update_date BEFORE UPDATE ON "extract".vascularaccess FOR EACH ROW EXECUTE FUNCTION "extract".trigger_fnc_set_update_date();


--
-- Name: address address_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".address
    ADD CONSTRAINT address_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patient(pid);


--
-- Name: allergy allergy_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".allergy
    ADD CONSTRAINT allergy_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: assessment assessment_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".assessment
    ADD CONSTRAINT assessment_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: causeofdeath causeofdeath_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".causeofdeath
    ADD CONSTRAINT causeofdeath_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: clinicalrelationship clinicalrelationship_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".clinicalrelationship
    ADD CONSTRAINT clinicalrelationship_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: contactdetail contactdetail_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".contactdetail
    ADD CONSTRAINT contactdetail_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patient(pid);


--
-- Name: diagnosis diagnosis_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".diagnosis
    ADD CONSTRAINT diagnosis_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: dialysisprescription dialysisprescription_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".dialysisprescription
    ADD CONSTRAINT dialysisprescription_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: dialysissession dialysissession_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".dialysissession
    ADD CONSTRAINT dialysissession_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: document document_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".document
    ADD CONSTRAINT document_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: encounter encounter_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".encounter
    ADD CONSTRAINT encounter_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: familydoctor familydoctor_gpid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familydoctor
    ADD CONSTRAINT familydoctor_gpid_fkey FOREIGN KEY (gpid) REFERENCES "extract".ukrdc_ods_gp_codes(code);


--
-- Name: familydoctor familydoctor_gppracticeid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familydoctor
    ADD CONSTRAINT familydoctor_gppracticeid_fkey FOREIGN KEY (gppracticeid) REFERENCES "extract".ukrdc_ods_gp_codes(code);


--
-- Name: familydoctor familydoctor_id_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familydoctor
    ADD CONSTRAINT familydoctor_id_fkey FOREIGN KEY (id) REFERENCES "extract".patient(pid);


--
-- Name: familyhistory familyhistory_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".familyhistory
    ADD CONSTRAINT familyhistory_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: laborder laborder_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".laborder
    ADD CONSTRAINT laborder_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: level level_surveyid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".level
    ADD CONSTRAINT level_surveyid_fkey FOREIGN KEY (surveyid) REFERENCES "extract".survey(id);


--
-- Name: medication medication_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".medication
    ADD CONSTRAINT medication_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: name name_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".name
    ADD CONSTRAINT name_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patient(pid);


--
-- Name: observation observation_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".observation
    ADD CONSTRAINT observation_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: optout optout_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".optout
    ADD CONSTRAINT optout_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: patient patient_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patient
    ADD CONSTRAINT patient_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: patientnumber patientnumber_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".patientnumber
    ADD CONSTRAINT patientnumber_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patient(pid);


--
-- Name: procedure procedure_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".procedure
    ADD CONSTRAINT procedure_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: programmembership programmembership_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".programmembership
    ADD CONSTRAINT programmembership_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: pvdata pvdata_id_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pvdata
    ADD CONSTRAINT pvdata_id_fkey FOREIGN KEY (id) REFERENCES "extract".patientrecord(pid);


--
-- Name: pvdelete pvdelete_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".pvdelete
    ADD CONSTRAINT pvdelete_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: question question_surveyid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".question
    ADD CONSTRAINT question_surveyid_fkey FOREIGN KEY (surveyid) REFERENCES "extract".survey(id);


--
-- Name: renaldiagnosis renaldiagnosis_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".renaldiagnosis
    ADD CONSTRAINT renaldiagnosis_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: resultitem resultitem_orderid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".resultitem
    ADD CONSTRAINT resultitem_orderid_fkey FOREIGN KEY (orderid) REFERENCES "extract".laborder(id);


--
-- Name: score score_surveyid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".score
    ADD CONSTRAINT score_surveyid_fkey FOREIGN KEY (surveyid) REFERENCES "extract".survey(id);


--
-- Name: socialhistory socialhistory_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".socialhistory
    ADD CONSTRAINT socialhistory_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: survey survey_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".survey
    ADD CONSTRAINT survey_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: transplant transplant_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".transplant
    ADD CONSTRAINT transplant_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: transplantlist transplantlist_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".transplantlist
    ADD CONSTRAINT transplantlist_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: treatment treatment_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".treatment
    ADD CONSTRAINT treatment_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: vascularaccess vascularaccess_pid_fkey; Type: FK CONSTRAINT; Schema: extract; Owner: ukrdc
--

ALTER TABLE ONLY "extract".vascularaccess
    ADD CONSTRAINT vascularaccess_pid_fkey FOREIGN KEY (pid) REFERENCES "extract".patientrecord(pid);


--
-- Name: SCHEMA "extract"; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA "extract" TO ukrdc;


--
-- Name: SEQUENCE generate_new_pid; Type: ACL; Schema: extract; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_pid TO ukrdc;


--
-- Name: SEQUENCE generate_new_ukrdcid; Type: ACL; Schema: extract; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE "extract".generate_new_ukrdcid TO ukrdc;


--
-- Name: TABLE vwe_extract_pv_pvxml_eligable; Type: ACL; Schema: extract; Owner: postgres
--

GRANT ALL ON TABLE "extract".vwe_extract_pv_pvxml_eligable TO ukrdc;


--
-- Name: TABLE code_exclusion; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.code_exclusion TO ukrdc;


--
-- Name: TABLE code_map; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.code_map TO ukrdc;


--
-- Name: TABLE modality_codes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.modality_codes TO ukrdc;


--
-- Name: TABLE rr_codes; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.rr_codes TO ukrdc;


--
-- Name: TABLE rr_data_definition; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.rr_data_definition TO ukrdc;


--
-- Name: TABLE satellite_map; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE public.satellite_map TO ukrdc;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extract; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA "extract" GRANT SELECT,USAGE ON SEQUENCES TO ukrdc;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extract; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA "extract" GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO ukrdc;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,USAGE ON SEQUENCES TO ukrdc;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,DELETE,UPDATE ON TABLES TO ukrdc;


--
-- PostgreSQL database dump complete
--

\unrestrict cEIo6ZSbGWmbDpbnCJ1V6lETZFAHMSOm9kryfuGnYd8dBupfyms0Hh8opoMh2pq

