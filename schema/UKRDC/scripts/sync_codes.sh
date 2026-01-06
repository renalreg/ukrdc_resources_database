
echo "Downloading latest lookup codes"
curl -L -f -o registry_codes.dump https://github.com/renalreg/registry-codes/releases/latest/download/registry_codes.dump
pg_restore --dbname=UKRDC4 \
--user=postgres \
--schema=extract \
--data-only \
--table=code_exclusion \
--table=code_map \
--table=facility \
--table=modality_codes \
--table=rr_codes \
--table=rr_data_definition \
--table=satellite_map \
--table=ukrdc_ods_gp_codes \
--verbose registry_codes.dump

rm registry_codes.dump