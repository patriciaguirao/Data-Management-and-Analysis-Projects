# Overview

```
Documentation
Name / Title: Ice Cream Dataset --> Ben & Jerry's
Link to Data: https://www.kaggle.com/tysonpo/ice-cream-dataset/version/3
Source / Origin:
	* Author or Creator: Tyson Pond
	* Publication Date: October 4, 2020
	* Publisher: kaggle
	* Version or Data Accessed: 3
License: CC0: Public Domain
Can You Use this Data Set for Your Intended Use Case? Yes
```

```
Format
* Format: CSV
* Size: 38 KB
* Number of Records: 57
```

```
Fields or Column Headers
* Field/Column 1: key --> string
* Field/Column 2: name --> string
* Field/Column 3: subhead --> string
* Field/Column 4: description --> string
* Field/Column 5: rating --> float
* Field/Column 6: rating_count --> int
* Field/Column 7: ingredients --> string
* Field/Column 8: base_flavor --> string
```

# Table Design

```
key --> set a max length of 5 because the longest key is 5 characters, set is as the primary key because each flavor has a unique one and it's a short way to refer to each one
name --> constrained it to be unique and not null because each flavor has a different name and all rows are filled in this column
subhead --> made it text data type since subheads are longer, constrained it to be unique and not null because each flavor has a different subhead and all rows are filled in this column
description --> made it text data type since descriptions are longer, constrained it to be unique and not null because each flavor has a different subhead and all rows are filled in this column
rating --> made it numeric since the numbers are decimals, constrained it to be not null because all rows are filled in this column but did not constrain it to be unique since multiple flavors can have the same rating
rating_count --> made it an integer since the numbers are all whole numbers, constrained it to be not null because all rows are filled in this column but did not constrain it to be unique since multiple flavors can have the same number rating counts
ingredients --> made it text data type since ingredients are longer, constrained it to be not null because all rows are filled in this column but did not constrain it to be unique since multiple flavors might have the same exact ingredients but what might make them different is the quantity in which certain ingredients in it are used (but how much is used of each ingredient is not represented in the ingredients string)
base_flavor --> constrained it to be not null because all rows are filled in this column but did not constrain it to be unique since multiple flavors can have the same base flavor
```

# Import

```
Import succeeded without errors.
```

# Database Information

```
postgres=# \l
                             List of databases
    Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges   
------------+----------+----------+---------+-------+-----------------------
 homework05 | postgres | UTF8     | C       | C     |
 postgres   | postgres | UTF8     | C       | C     |
 template0  | postgres | UTF8     | C       | C     | =c/postgres          +
            |          |          |         |       | postgres=CTc/postgres
 template1  | postgres | UTF8     | C       | C     | =c/postgres          +
            |          |          |         |       | postgres=CTc/postgres
```

```
postgres-# psql homework05
postgres-# \dt
           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | ice_cream | table | postgres
```

```
postgres-# \d ice_cream
                        Table "public.ice_cream"
    Column    |          Type          | Collation | Nullable | Default
--------------+------------------------+-----------+----------+---------
 key          | character varying(5)   |           | not null |
 name         | character varying(255) |           | not null |
 subhead      | text                   |           | not null |
 description  | text                   |           | not null |
 rating       | numeric                |           | not null |
 rating_count | integer                |           | not null |
 ingredients  | text                   |           | not null |
Indexes:
    "ice_cream_pkey" PRIMARY KEY, btree (key)
    "ice_cream_description_key" UNIQUE CONSTRAINT, btree (description)
    "ice_cream_name_key" UNIQUE CONSTRAINT, btree (name)
    "ice_cream_subhead_key" UNIQUE CONSTRAINT, btree (subhead)
```

# Query Results

```
### 1. the total number of rows in the database

count
-------
	 57
```

```
### 2. show the first 15 rows, but only display 3 columns (your choice)
### showing the name, rating, and base_flavor columns

name              | rating |        base_flavor        
-------------------------------+--------+---------------------------
SALTED CARAMEL CORE           |    3.7 | SWEET CREAM
NETFLIX & CHILLL'D™           |    4.0 | PEANUT BUTTER
CHIP HAPPENS                  |    4.7 | CHOCOLATE
CANNOLI                       |    3.6 | MASCARPONE
GIMME S’MORE!™                |    4.5 | TOASTED MARSHMALLOW
PEANUT BUTTER HALF BAKED®     |    4.9 | CHOCOLATE & PEANUT BUTTER
BERRY SWEET MASCARPONE        |    4.6 | BLACKBERRY & MASCARPONE
CHOCOLATE PEANUT BUTTER SPLIT |    5.0 | CHOCOLATE & BANANA
JUSTICE REMIX'D ™             |    4.3 | CINNAMON & CHOCOLATE
BOOTS ON THE MOOOO’N™         |    4.7 | MILK CHOCOLATE
AMERICONE DREAM®              |    4.7 | VANILLA
BOURBON PECAN PIE             |    4.6 | BUTTERY BOURBON
BREWED TO MATTER™             |    4.7 | COFFEE
CARAMEL CHOCOLATE CHEESECAKE  |    4.0 | CARAMEL CHEESECAKE
CHERRY GARCIA®                |    4.4 | CHERRY
```

```
### 3. do the same as above, but chose a column to sort on, and sort in descending order
### showing the name, rating, and base_flavor columns and sorting on the rating column

name                | rating |        base_flavor        
------------------------------------+--------+---------------------------
ICE CREAM SAMMIE                   |    5.0 | VANILLA
CHOCOLATE PEANUT BUTTER SPLIT      |    5.0 | CHOCOLATE & BANANA
PEANUT BUTTER HALF BAKED®          |    4.9 | CHOCOLATE & PEANUT BUTTER
PEANUT BUTTER WORLD®               |    4.9 | MILK CHOCOLATE
NEW YORK SUPER FUDGE CHUNK®        |    4.9 | CHOCOLATE
COFFEE COFFEE BUZZBUZZBUZZ!®       |    4.9 | COFFEE
VANILLA CARAMEL FUDGE              |    4.8 | VANILLA
CHOCOLATE THERAPY®                 |    4.8 | CHOCOLATE
SWEET LIKE SUGAR COOKIE DOUGH CORE |    4.8 | SWEET CREAM
PHISH FOOD®                        |    4.8 | CHOCOLATE
MINTER WONDERLAND™                 |    4.7 | DARK CHOCOLATE MINT
BREWED TO MATTER™                  |    4.7 | COFFEE
CHIP HAPPENS                       |    4.7 | CHOCOLATE
MILK & COOKIES                     |    4.7 | VANILLA
AMERICONE DREAM®                   |    4.7 | VANILLA
```

```
### 4. add a new column without a default value
### adding a column that documents my opinion on each flavor

ALTER TABLE

(did \d ice_cream to get below)
Table "public.ice_cream"
Column    |          Type          | Collation | Nullable | Default
--------------+------------------------+-----------+----------+---------
key          | character varying(5)   |           | not null |
name         | character varying(255) |           | not null |
subhead      | text                   |           | not null |
description  | text                   |           | not null |
rating       | numeric                |           | not null |
rating_count | integer                |           | not null |
ingredients  | text                   |           | not null |
base_flavor  | character varying(255) |           | not null |
my_opinion   | text                   |           |          |
Indexes:
"ice_cream_pkey" PRIMARY KEY, btree (key)
"ice_cream_description_key" UNIQUE CONSTRAINT, btree (description)
"ice_cream_name_key" UNIQUE CONSTRAINT, btree (name)
"ice_cream_subhead_key" UNIQUE CONSTRAINT, btree (subhead)
```

```
### 5. set the value of that new column
### defaulting each row in the my_opinion column to be "Yum"

UPDATE 57

(did SELECT name, my_opinion FROM ice_cream; to get below)
name                 | my_opinion
--------------------------------------+------------
PEANUT BUTTER CUP                    | YUM
VANILLA                              | YUM
SALTED CARAMEL CORE                  | YUM
NETFLIX & CHILLL'D™                  | YUM
CHUNKY MONKEY®                       | YUM
PISTACHIO PISTACHIO                  | YUM
CHIP HAPPENS                         | YUM
CANNOLI                              | YUM
GIMME S’MORE!™                       | YUM
PEANUT BUTTER HALF BAKED®            | YUM
BERRY SWEET MASCARPONE               | YUM
CHOCOLATE PEANUT BUTTER SPLIT        | YUM
JUSTICE REMIX'D ™                    | YUM
BOOTS ON THE MOOOO’N™                | YUM
AMERICONE DREAM®                     | YUM
BOURBON PECAN PIE                    | YUM
BREWED TO MATTER™                    | YUM
CARAMEL CHOCOLATE CHEESECAKE         | YUM
CHERRY GARCIA®                       | YUM
CHILLIN' THE ROAST™                  | YUM
CHOCOLATE CHIP COOKIE DOUGH          | YUM
CHOCOLATE FUDGE BROWNIE              | YUM
CHOCOLATE SHAKE IT™                  | YUM
CHOCOLATE THERAPY®                   | YUM
CHUBBY HUBBY®                        | YUM
CINNAMON BUNS®                       | YUM
COFFEE COFFEE BUZZBUZZBUZZ!®         | YUM
COFFEE TOFFEE BAR CRUNCH             | YUM
COLD BREW CARAMEL LATTE              | YUM
EVERYTHING BUT THE...®               | YUM
GLAMPFIRE TRAIL MIX™                 | YUM
HALF BAKED®                          | YUM
ICE CREAM SAMMIE                     | YUM
MILK & COOKIES                       | YUM
MINT CHOCOLATE COOKIE                | YUM
MINTER WONDERLAND™                   | YUM
NEW YORK SUPER FUDGE CHUNK®          | YUM
OAT OF THIS SWIRLED™                 | YUM
PEANUT BUTTER WORLD®                 | YUM
PHISH FOOD®                          | YUM
PUMPKIN CHEESECAKE                   | YUM
RED, WHITE & BLUEBERRY               | YUM
S'MORES                              | YUM
SALTED CARAMEL ALMOND                | YUM
STRAWBERRY CHEESECAKE                | YUM
THE TONIGHT DOUGH®                   | YUM
TRIPLE CARAMEL CHUNK®                | YUM
URBAN BOURBON™                       | YUM
VANILLA CARAMEL FUDGE                | YUM
BOOM CHOCOLATTA™ COOKIE CORE         | YUM
CHOCOLATE CHIP COOKIE DOUGH CORE     | YUM
SWEET LIKE SUGAR COOKIE DOUGH CORE   | YUM
WAKE & " NO BAKE " COOKIE DOUGH CORE | YUM
BROWNIE BATTER CORE                  | YUM
COOKIES & CREAM CHEESECAKE CORE      | YUM
KARAMEL SUTRA® CORE                  | YUM
PEANUT BUTTER FUDGE CORE             | YUM
```

```
### 6. show only the unique (non duplicates) of a column of your choice

base_flavor        
---------------------------
CHOCOLATE
COOKIE MILK
PEPPERMINT
PUMPKIN CHEESECAKE
CHOCOLATE & CARAMEL
DARK CHOCOLATE MINT
BURNT CARAMEL
PISTACHIO
BUTTERY BROWN SUGAR
TOASTED MARSHMALLOW
SWEET CREAM
MILK CHOCOLATE
CINNAMON & CHOCOLATE
BLUEBERRY & RASPBERRY
CARAMEL & CHOCOLATE
CHOCOLATE & VANILLA
MASCARPONE
PEANUT BUTTER
CHOCOLATE & BANANA
MOCHA & CARAMEL
COLD BREW & SWEET CREAM
BANANA
CHOCOLATE & CHEESECAKE
CHOCOLATE & PEANUT BUTTER
CHERRY
CARAMEL
COFFEE
COLD BREW COFFEE
STRAWBERRY CHEESECAKE
VANILLA MALT
CHOCOLATE MALT MILKSHAKE
VANILLA BEAN
BUTTERY BOURBON
VANILLA
CARAMEL CHEESECAKE
BLACKBERRY & MASCARPONE
```

```
### 7. group rows together by a column value (your choice) and use an aggregate function to calculate something about that group
### grouping rows together based on base_flavor and counting how many flavors have each base flavor as a base

base_flavor        | count
---------------------------+-------
MASCARPONE                |     1
CHOCOLATE                 |     7
COOKIE MILK               |     1
PEPPERMINT                |     1
PEANUT BUTTER             |     2
CHOCOLATE & BANANA        |     1
MOCHA & CARAMEL           |     1
COLD BREW & SWEET CREAM   |     1
BANANA                    |     1
CHOCOLATE & CHEESECAKE    |     1
CHOCOLATE & PEANUT BUTTER |     2
CHERRY                    |     1
PUMPKIN CHEESECAKE        |     1
CARAMEL                   |     2
COFFEE                    |     3
CHOCOLATE & CARAMEL       |     1
DARK CHOCOLATE MINT       |     1
BURNT CARAMEL             |     1
COLD BREW COFFEE          |     1
PISTACHIO                 |     1
BUTTERY BROWN SUGAR       |     1
STRAWBERRY CHEESECAKE     |     1
VANILLA MALT              |     1
CHOCOLATE MALT MILKSHAKE  |     1
VANILLA BEAN              |     1
TOASTED MARSHMALLOW       |     1
SWEET CREAM               |     2
MILK CHOCOLATE            |     2
CINNAMON & CHOCOLATE      |     1
BUTTERY BOURBON           |     1
BLUEBERRY & RASPBERRY     |     1
CARAMEL & CHOCOLATE       |     1
VANILLA                   |     7
CARAMEL CHEESECAKE        |     1
BLACKBERRY & MASCARPONE   |     1
CHOCOLATE & VANILLA       |     3
```

```
### 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups
### grouping rows together based on base_flavor and counting how many flavors have each base flavor as a base and filtering to only see the base flavors that have a count greater than 1

base_flavor        | count
---------------------------+-------
CHOCOLATE                 |     7
PEANUT BUTTER             |     2
CHOCOLATE & PEANUT BUTTER |     2
CARAMEL                   |     2
COFFEE                    |     3
SWEET CREAM               |     2
MILK CHOCOLATE            |     2
VANILLA                   |     7
CHOCOLATE & VANILLA       |     3
```

```
### 9. find the average rating of all the flavors

avg         
--------------------
4.3315789473684211
```

```
### 10. find the top 5 rated flavors --> determined first based on rating and then based on rating count if ratings are the same

name              | rating |    base_flavor     
-------------------------------+--------+--------------------
ICE CREAM SAMMIE              |    5.0 | VANILLA
CHOCOLATE PEANUT BUTTER SPLIT |    5.0 | CHOCOLATE & BANANA
PEANUT BUTTER WORLD®          |    4.9 | MILK CHOCOLATE
NEW YORK SUPER FUDGE CHUNK®   |    4.9 | CHOCOLATE
COFFEE COFFEE BUZZBUZZBUZZ!®  |    4.9 | COFFEE
```

```
### 11. find how many flavors use chocolate as one of their main components

count
-------
	 30
```

```
### 12. find the flavors that are rated below average


name               |                                   subhead                                   | rating
----------------------------------+-----------------------------------------------------------------------------+--------
COFFEE TOFFEE BAR CRUNCH         | COFFEE ICE CREAM WITH FUDGE-COVERED TOFFEE PIECES                           |    2.9
CHOCOLATE CHIP COOKIE DOUGH CORE | COOKIE MILK ICE CREAM WITH FUDGE CHIPS & A CHOCOLATE CHIP COOKIE DOUGH CORE |    1.8
(2 rows)

```
