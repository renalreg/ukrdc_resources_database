delete from "extract".address;
delete from "extract".allergy;
delete from "extract".causeofdeath;
delete from "extract".clinicalrelationship;
-- Don't clear Code_List definitions
-- Don't clear Code_Map definitions
delete from "extract".contactdetail;
delete from "extract".diagnosis;
delete from "extract".dialysissession;
delete from "extract".document;
delete from "extract".encounter;
delete from "extract".eventcontrol;
delete from "extract".facility;
delete from "extract".familydoctor;
delete from "extract".familyhistory;
delete from "extract".laborder;
delete from "extract".level;
delete from "extract".medication;
delete from "extract".name;
delete from "extract".observation;
delete from "extract".optout;
delete from "extract".patient;
delete from "extract".patientnumber;
delete from "extract".patientrecord;
delete from "extract".procedure;
delete from "extract".programmembership;
delete from "extract".pvdata;
delete from "extract".pvdelete;
delete from "extract".question;
delete from "extract".renaldiagnosis;
delete from "extract".resultitem;
delete from "extract".score;
delete from "extract".socialhistory;
delete from "extract".survey;
delete from "extract".transplant;
delete from "extract".transplantlist;
delete from "extract".treatment;
delete from "extract".validationerror;
delete from "extract".vascularaccess;
delete from "extract".pvdata;

INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('PVEXTRACT',TIMESTAMP '1970-01-01 00:00:00');
INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('PVSURVEYEXTRACT',TIMESTAMP '1970-01-01 00:00:00');
INSERT INTO "extract".eventcontrol(eventtype, eventdate)
	VALUES ('RADAREXTRACT',TIMESTAMP '1970-01-01 00:00:00');
