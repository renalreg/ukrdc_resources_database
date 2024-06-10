# NOTE: This is compatible with V4+ of the RDA Schema (and hence NOT the Java code)

The codes below relate to how the Java code works and will need to be changed/moved as we move to CUPID.


# Database DDL and Scripts

## Database design notes

1) Uses an arbitrary generated PID for patient record and as the cascading key, rather than using the natural composite of facility + localid 
-- Means that a custom query is required to get the pid from facility + localid 
++ Keeps the relationships and keys easier to map in Hibernate

2) Currently saves Patient separately from PatientRecord
-- Works but should be reworked to make more sense. Probably a blind-spot on my side but I couldn't get the mappings right to make this work as one

3) In general mandatory fields are NOT enforced on the DB through NOT NULL constraints. 
   The only NOT NULLs are PK and the main application key of facility + localid
++ Allows validation to be done secondary to load as agreed
++ Prevents database failures due to bad data. What would we do with such failures?

4) The data model and field types/sizes have not been extensively considered so some fine-tuning in light of real data is likely

5) All character fields are character varying - Hibernate seems to like it that way and there seems no downside.

6) DialysisSession still has embedded attributes - this will be changing to use a separate attributes table
