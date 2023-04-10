-- write your COPY statement to import a csv here

COPY ice_cream(key, name, subhead, description, rating, rating_count, ingredients, base_flavor)
FROM '/Users/patriciaguirao/patriciag48-homework05/bj_flavors.csv'
DELIMITER ','
CSV HEADER;
