-- write your queries underneath each number:

-- 1. the total number of rows in the table

SELECT COUNT(*) FROM ice_cream;

-- 2. show the first 15 rows, but only display 3 columns (your choice)
-- showing the name, rating, and base_flavor columns

SELECT name, rating, base_flavor FROM ice_cream LIMIT 15;

-- 3. do the same as above, but chose a column to sort on, and sort in descending order
-- showing the name, rating, and base_flavor columns and sorting on the rating column

SELECT name, rating, base_flavor FROM ice_cream ORDER BY rating desc LIMIT 15;

-- 4. add a new column without a default value
-- adding a column that documents my opinion on each flavor

ALTER TABLE ice_cream ADD COLUMN my_opinion text;

-- 5. set the value of that new column
-- defaulting each row in the my_opinion column to be "Yum"

UPDATE ice_cream SET my_opinion = 'YUM';

-- 6. show only the unique (non duplicates) of a column of your choice
-- showing the unique values of the base_flavor column

SELECT DISTINCT base_flavor FROM ice_cream;

-- 7. group rows together by a column value (your choice) and use an aggregate function to calculate something about that group
-- grouping rows together based on base_flavor and counting how many flavors have each base flavor as a base

SELECT base_flavor, COUNT(name) FROM ice_cream GROUP BY base_flavor;

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups
-- grouping rows together based on base_flavor and counting how many flavors have each base flavor as a base and filtering to only see the base flavors that have a count greater than 1

SELECT base_flavor, COUNT(name) FROM ice_cream GROUP BY base_flavor HAVING COUNT(name) > 1;

-- 9. find the average rating of all the flavors

SELECT AVG(rating) FROM ice_cream;

-- 10. find the top 5 rated flavors --> determined first based on rating and then based on rating count if ratings are the same

SELECT name, rating, base_flavor FROM ice_cream ORDER BY rating desc, rating_count desc LIMIT 5;

-- 11. find how many flavors use chocolate as one of their main components

SELECT COUNT(name) FROM ice_cream WHERE subhead ILIKE '%CHOCOLATE%';

-- 12. find the flavors that are rated below average

SELECT name, subhead, rating FROM ice_cream WHERE rating < 3;
