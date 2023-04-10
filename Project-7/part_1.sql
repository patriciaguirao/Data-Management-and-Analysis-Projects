-- 1. Write a query to show the report_id and the uppercase version of product for all rows that contain a 75 year old patient
-- sorted by the report_id ascending.
SELECT report_id, UPPER(product) FROM staging_caers_events WHERE patient_age = 75 ORDER BY report_id;

-- 2. Use EXPLAIN ANALYZE to show how much time it takes to run your query
EXPLAIN ANALYZE SELECT report_id, UPPER(product) FROM staging_caers_events WHERE patient_age = 75 ORDER BY report_id;
```
QUERY PLAN
----------------------------------------------------------------------------------------------------------------------------
Sort  (cost=2001.46..2002.86 rows=560 width=39) (actual time=8.952..8.983 rows=561 loops=1)
Sort Key: report_id
Sort Method: quicksort  Memory: 76kB
->  Seq Scan on staging_caers_events  (cost=0.00..1975.90 rows=560 width=39) (actual time=0.068..8.614 rows=561 loops=1)
Filter: (patient_age = 75)
Rows Removed by Filter: 49879
Planning Time: 0.727 ms
Execution Time: 30.151 ms
```

-- 3. Write SQL to add a single column index to make your query run faster and verify that it has been created
CREATE INDEX index_patient_age ON staging_caers_events (patient_age);
```
Table "public.staging_caers_events"
Column     |          Type          | Collation | Nullable |                           Default
----------------+------------------------+-----------+----------+--------------------------------------------------------------
caers_event_id | integer                |           | not null | nextval('staging_caers_events_caers_event_id_seq'::regclass)
report_id      | character varying(255) |           |          |
created_date   | date                   |           |          |
event_date     | date                   |           |          |
product_type   | text                   |           |          |
product        | text                   |           |          |
product_code   | text                   |           |          |
description    | text                   |           |          |
patient_age    | integer                |           |          |
age_units      | character varying(255) |           |          |
sex            | character varying(255) |           |          |
terms          | text                   |           |          |
outcomes       | text                   |           |          |
Indexes:
"staging_caers_events_pkey" PRIMARY KEY, btree (caers_event_id)
"index_patient_age" btree (patient_age)
```
SELECT report_id, UPPER(product) FROM staging_caers_events WHERE patient_age > 20;
