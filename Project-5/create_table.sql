-- write your table creation sql here!

CREATE DATABASE homework05;

DROP TABLE IF EXISTS ice_cream;

CREATE TABLE ice_cream(
	 key varchar(5) PRIMARY KEY,
	 name varchar(255) UNIQUE NOT NULL,
	 subhead text UNIQUE NOT NULL,
   description text UNIQUE NOT NULL,
	 rating numeric NOT NULL,
   rating_count integer NOT NULL,
   ingredients text NOT NULL,
	 base_flavor varchar(255) NOT NULL
);
