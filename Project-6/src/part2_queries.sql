-- 1. Show the possible values of the year column in the country_stats table sorted by most recent year first.
SELECT DISTINCT year FROM country_stats ORDER BY year desc;

-- 2. Show the names of the first 5 countries in the database when sorted in alphabetical order by name.
SELECT name FROM countries ORDER BY name LIMIT 5;

-- 3. Adjust the previous query to show both the country name and the gdp from 2018, but this time show the top 5 countries
-- by gdp.
SELECT name, gdp FROM countries, country_stats WHERE countries.country_id = country_stats.country_id AND year = 2018
ORDER BY gdp desc LIMIT 5;

-- 4. How many countries are associated with each region id?
SELECT region_id, COUNT(region_id) AS country_count FROM countries GROUP BY region_id ORDER BY COUNT(region_id) desc;

-- 5. What is the average area of countries in each region id?
SELECT region_id, ROUND(AVG(area)) AS avg_area FROM countries GROUP BY region_id ORDER BY ROUND(AVG(area));

-- 6. Use the same query as above, but only show the groups with an average country area less than 1000
SELECT region_id, ROUND(AVG(area)) AS avg_area FROM countries GROUP BY region_id HAVING ROUND(AVG(area)) < 1000
ORDER BY ROUND(AVG(area));

-- 7. Create a report displaying the name and population of every continent in the database from the year 2018 in millions.
SELECT continents.name, ROUND(SUM(population)/1000000.::NUMERIC, 2) AS tot_pop FROM continents INNER JOIN regions ON
continents.continent_id = regions.continent_id INNER JOIN countries ON regions.region_id = countries.region_id
INNER JOIN country_stats ON countries.country_id = country_stats.country_id WHERE year = 2018 GROUP BY continents.name
ORDER BY ROUND(SUM(population)/1000000.::NUMERIC, 2) desc;

-- 8. List the names of all of the countries that do not have a language.
SELECT name FROM countries LEFT OUTER JOIN country_languages ON countries.country_id = country_languages.country_id
WHERE country_languages.language_id IS NULL;

-- 9. Show the country name and number of associated languages of the top 10 countries with most languages
SELECT name, COUNT(language_id) AS lang_count FROM countries, country_languages WHERE
countries.country_id = country_languages.country_id GROUP BY name ORDER BY COUNT(language_id) desc, name LIMIT 10;

-- 10. Repeat your previous query, but display a comma separated list of spoken languages rather than a count
-- (use the aggregate function for strings, string_agg. A single example row (note that results before and above have been
-- omitted for formatting):
SELECT name, string_agg(language, ',') FROM countries INNER JOIN country_languages ON
countries.country_id = country_languages.country_id INNER JOIN languages ON
country_languages.language_id = languages.language_id GROUP BY name ORDER BY COUNT(country_languages.language_id) desc, name
LIMIT 10;

-- 11. What's the average number of languages in every country in a region in the dataset? Show both the region's name and the
-- average. Make sure to include countries that don't have a language in your calculations. (Hint: using your previous queries
-- and additional subqueries may be useful)

SELECT regions.name, ROUND(AVG(count)::NUMERIC, 1) AS avg_lang_count_per_country FROM regions INNER JOIN
(SELECT countries.name, COUNT(language_id), countries.region_id FROM countries LEFT OUTER JOIN country_languages ON
countries.country_id = country_languages.country_id INNER JOIN regions on countries.region_id = regions.region_id GROUP BY
countries.name, countries.region_id) AS count ON regions.region_id = count.region_id GROUP BY regions.name
ORDER BY ROUND(AVG(count)::NUMERIC, 1) desc;

-- 12. Show the country name and its "national day" for the country with the most recent national day and the country with the
-- oldest national day.
SELECT name, national_day FROM countries WHERE national_day = (SELECT MAX (national_day) FROM countries) UNION
SELECT name, national_day FROM countries WHERE national_day = (SELECT MIN (national_day) FROM countries);
