COPY staging_caers_events(report_id, created_date, event_date, product_type, product, product_code, description, patient_age,
age_units, sex, terms, outcomes)
FROM '/Users/patriciaguirao/patriciag48-homework06/data/CAERS_ASCII_11_14_to_12_17.csv'
(format csv, header, encoding 'LATIN1');
