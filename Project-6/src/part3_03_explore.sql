-- 1. Show all non-unique report_ids and their counts
SELECT report_id, COUNT(report_id) FROM staging_caers_events GROUP BY report_id HAVING COUNT(report_id) > 1;

-- 2. Find all the products that map to more than one product_code
SELECT product, COUNT(product_code) AS not_distinct
FROM (SELECT product, product_code FROM staging_caers_events GROUP BY product, product_code) AS products_and_codes_mapping
GROUP BY product HAVING COUNT(product_code) > 1;

-- 3. Finding a relatinoship between product_codes and description, after trimming all the description strings (so there) is no
-- more leading and trailing space, you can see that each product_code maps to only one description --> not_distinct represents
-- how many product_codes map to more than one description and if none are returned, each product_code maps to only one
SELECT product_code, COUNT(description_trim) AS not_distinct FROM (SELECT product_code, description_trim FROM (SELECT *,BTRIM(description)
AS description_trim FROM staging_caers_events) AS trimmed GROUP BY product_code, description_trim) AS products_and_codes_mapping
GROUP BY product_code HAVING COUNT(description_trim) > 1;

-- 4. This query works on finding a candidate key for the original data set by seeing if any rows in the data field have all of
--- the same products, product_codes, and report_ids and if so which entries do --> the not_distinct id field tells us from
--- the products that map to multiple product_codes which also map to multiple report_ids and if so, how many ids they map to

SELECT report_id, product, COUNT(report_id) AS not_distinct_id FROM (SELECT staging_caers_events.product, report_id
FROM (SELECT product, COUNT(product_code) AS not_distinct_codes FROM (SELECT product, product_code FROM staging_caers_events
GROUP BY product, product_code) AS products_and_codes_mapping GROUP BY product HAVING COUNT(product_code) > 1)
AS non_distinct_codes_mapping INNER JOIN staging_caers_events ON non_distinct_codes_mapping.product = staging_caers_events.product)
AS not_distinct_id_mapping GROUP BY product, report_id HAVING COUNT(report_id) > 1;

-- 5. This query finds a candidate key for the original data set --> the original data set has 50440 rows and when concatenating
--- a primary key in the way I do using certain columns, it results in the same number of distinct values making it a possible
--- primary key
SELECT COUNT(*) FROM staging_caers_events;

SELECT COUNT(DISTINCT primary_key) AS distinct_keys
FROM (SELECT concat(report_id,' ',product_type,' ',product,' ',product_code) "primary_key"
FROM staging_caers_events) AS primary_keys;
