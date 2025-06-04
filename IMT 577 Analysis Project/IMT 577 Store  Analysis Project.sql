
------------------------------------------------------- SELECT STATEMENTS--------------------------------------------------------------------------------

----------------STAGING----------------------------------------------------------------------------------------------------------------------------------
-- SELECT * FROM PUBLIC_STAGING_CHANNEL;
-- SELECT * FROM PUBLIC_STAGING_CHANNEL_CATEGORY;
-- SELECT * FROM PUBLIC_CUSTOMER;
-- SELECT FROM PUBLIC_PRODUCT_CATEGORY;
-- SELECT FORM PRODUCT_PRODUCT;
-- SELECT FROM PUBLIC_PRODUCT_TYPE;
-- SELECT * FROM PUBLIC_RESELLER;
-- SEELCT * FROM PUBLI_SALES_DETAIL;
-- SELECT * FROM PUBLIC_SALES_HEADER_NEW;
-- SELECT * FROM PUBLIC_STORE;
-- SELECT * FROM PUBLIC__TARGET_DATE_CHANNEL;
-- SELECT * FROM PUBLIC_ TARGET_TARGET_DATA_PRODUCT;

-----------------DIM Tables-------------------------------------------------------------------------------------------------------------------------------
-- SELECT * FROM DIM_CHANNEL;
-- SELECT * FROM DIM_CUSTOMER;
-- SELECT * FROM DIM_DATE;
-- SELECT * FROM DIM_LOCATION;
-- SELECT * FROM DIM_PRODUCT;
-- SELECT * FROM DIM_RESELLER;
-- SELECT * FROM DIM_STORE;

----------------FACT TABLES--------------------------------------------------------------------------------------------------------------------------------
-- SELECT * FROM FACT_PRODUCTSALESTARGET;
-- SELECT * FROM FACT_SALESACTUAL;
-- SELECT * FROM FACT_SRCSALESTARGET;

---------------VIEW TABLES---------------------------------------------------------------------------------------------------------------------------------
-- SELECT * FROM STORE_5_8_SALES_COMPARISON;
-- SELECT * FROM CASUAL_SALES_BY_STOREYEAR;
-- SELECT * from bonus_allocation_store_5_8 
-- SELECT * FROM store5_8_weeklytrends;
-- SELECT * FROM STORE_STATE_COMPARISON;

--View Tables: 8.15 Data Warehouse Submission
-- Q1:How are they performing compared to target? Will they meet their 2014 target? 
 
--Stores 5 and 8 have actual sales of $1,883,515.59 and $1,969,308.37. The 2014 Target for Stores 5 and 8 is $1,640,000.00 and $1,720,000.00. Both Stores have exceeded the sales Target by 14%. There is no need to close the stores.  

--Q2. Recommend separate 2013 and 2014 bonus amounts for each store if the total bonus pool for 2013 is $500,000 and the total bonus pool for 2014 is $400,000. Base your recommendation on how well the stores are selling Product Types of Men’s Casual and Women’s Casual.

-- Based on the query. Women's casual in both 2013 and 2014 had significantly higher sales in Store 5 than store 8.  

-- Q3.Assess product sales by day of the week at Stores 5 and 8. What can we learn about sales trends?

-- Saturdays typically have the largest sale total with $54,993,874.00

-- Q4 Compare the performance of all stores located in states that have more than one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?
-- From the query, it seems that single store have a total sale of 4,149,372,943.00 while state with multiple store have a total sale of 676,924,308.00. We have learned that states with single stores have more sales than states with multiple stores.

/*FAILSAFE AKA DROPS
--DROP TABLE Dim_DATE;
--DROP TABLE DIM_LOCATION;
--DROP TABLE DIM_Store;
--DROP TABLE DIM_REseller;
--DROP TABLE DIM_Customer;
--DROP TABLE DIM_Product;
--DROP TABLE DIM_Channel*/

USE DATABASE IMT577_DW_ERIC_DOUANGDARA_DIMENSION;
CREATE or REPLACE TABLE PUBLIC_STAGING_CHANNEL(
    CHANNEL_ID INTEGER
    , CHANNEL_CATEGORY_ID INTEGER
    , CHANNEL VARCHAR(255)  );

CREATE or REPLACE TABLE PUBLIC_STAGING_CHANNEL_CATEGORY(
    CHANNEL_CATEGORY_ID INTEGER
     , CHANNEL_CATEGORY VARCHAR(255) );

CREATE or REPLACE TABLE PUBLIC_CUSTOMER(
CUSTOMER_ID VARCHAR(255)
, SUBSEGMENT_ID INTEGER
, FIRST_NAME VARCHAR(255)
, LAST_NAME VARCHAR(255)
, GENDER VARCHAR(255)
, EMAIL_ADDRESS VARCHAR(255)
, ADDRESS VARCHAR(255)
, CITY VARCHAR(255)
, STATE_PROVINCE VARCHAR(255)
, COUNTRY VARCHAR(255)
, POSTAL_CODE VARCHAR(255)
, PHONE_NUMBER VARCHAR(255) );

CREATE OR REPLACE TABLE PUBLIC_PRODUCT_CATEGORY(
PRODUCT_CATEGORY_ID INTEGER
, PRODUCT_CATEGORY VARCHAR(255) );

CREATE OR REPLACE TABLE PUBLIC_PRODUCT(
    PRODUCT_ID INTEGER
    , PRODUCT_TYPE_ID INTEGER
    , PRODUCT VARCHAR(255)
    , COLOR VARCHAR(255)
    , STYLE VARCHAR(255)
    , UNIT_OF_MEASURE_ID INTEGER
    , WEIGHT DECIMAL (10,2)
    , PRICE DECIMAL(10,2)
    , COST DECIMAL(10,2)
    , WHOLESALE_PRICE DECIMAL (10,2) 
    );

CREATE OR REPLACE TABLE PUBLIC_PRODUCT_TYPE(
    PRODUCT_TYPE_ID INTEGER
    , PRODUCT_CATEGORY_ID INTEGER
    , PRODUCT_TYPE VARCHAR(255)     );

CREATE OR REPLACE TABLE PUBLIC_RESELLER(
    RESELLER_ID VARCHAR(255)
    , CONTACT VARCHAR(255)
    , EMAIL_ADDRESS VARCHAR(255)
    , ADDRESS VARCHAR(255)
    , CITY VARCHAR(255)
    , STATE_PROVINCE VARCHAR(255)
    , COUNTRY VARCHAR(255)
    , POSTALCODE VARCHAR(255)
    , PHONE_NUMBER VARCHAR(255)
    , RESELLER_NAME VARCHAR(255) );

CREATE OR REPLACE TABLE PUBLIC_SALES_DETAIL(
    SALES_DETAIL_ID INTEGER
    , SALES_HEADER_ID INTEGER
    , PRODUCT_ID INTEGER 
    , SALES_QUANTITY NUMERIC
    , SALES_AMOUNT NUMERIC  );

CREATE OR REPLACE TABLE PUBLIC_SALES_HEADER_NEW(
    SALES_HEADER_ID INTEGER
    , DATE VARCHAR(255)
    , CHANNEL_ID INTEGER
    , STORE_ID INTEGER
    , CUSTOMER_ID VARCHAR(255)
    , RESELLER_ID VARCHAR(255)  );

CREATE OR REPLACE TABLE PUBLIC_STORE(
    STORE_ID INTEGER
    , SUBSEGMENT_ID INTEGER
    , STORE_NUMBER INTEGER
    , STORE_MANAGER VARCHAR(255)
    , ADDRESS VARCHAR(255)
    , CITY VARCHAR(255)
    , STATE_PROVINCE VARCHAR(255)
    , COUNTRY VARCHAR(255)
    , POSTALCODE VARCHAR(255)
    , PHONE_NUMBER VARCHAR(255) );

CREATE OR REPLACE TABLE PUBLIC_TARGET_DATE_CHANNEL(
    YEAR VARCHAR(255)
    , CHANNEL_NAME VARCHAR(255)
    , TARGET_NAME VARCHAR(255)
    , TARGET_SALES_AMOUNT VARCHAR(255)  );

CREATE OR REPLACE TABLE PUBLIC_TARGET_DATA_PRODUCT(
    PRODUCT_ID INTEGER
    , PRODUCT VARCHAR(255)
    , YEAR VARCHAR(255)
    , SALES_QUANTITY_TARGET VARCHAR(255) );


-- Create table script for Dimension DIM_DATE
create or replace table DIM_DATE (
	DATE_PKEY				number(9) PRIMARY KEY,
	DATE					date not null,
	FULL_DATE_DESC			varchar(64) not null,
	DAY_NUM_IN_WEEK			number(1) not null,
	DAY_NUM_IN_MONTH		number(2) not null,
	DAY_NUM_IN_YEAR			number(3) not null,
	DAY_NAME				varchar(10) not null,
	DAY_ABBREV				varchar(3) not null,
	WEEKDAY_IND				varchar(64) not null,
	US_HOLIDAY_IND			varchar(64) not null,
	/*<COMPANYNAME>*/_HOLIDAY_IND varchar(64) not null,
	MONTH_END_IND			varchar(64) not null,
	WEEK_BEGIN_DATE_NKEY		number(9) not null,
	WEEK_BEGIN_DATE			date not null,
	WEEK_END_DATE_NKEY		number(9) not null,
	WEEK_END_DATE			date not null,
	WEEK_NUM_IN_YEAR		number(9) not null,
	MONTH_NAME				varchar(10) not null,
	MONTH_ABBREV			varchar(3) not null,
	MONTH_NUM_IN_YEAR		number(2) not null,
	YEARMONTH				varchar(10) not null,
	QUARTER					number(1) not null,
	YEARQUARTER				varchar(10) not null,
	YEAR					number(5) not null,
	FISCAL_WEEK_NUM			number(2) not null,
	FISCAL_MONTH_NUM		number(2) not null,
	FISCAL_YEARMONTH		varchar(10) not null,
	FISCAL_QUARTER			number(1) not null,
	FISCAL_YEARQUARTER		varchar(10) not null,
	FISCAL_HALFYEAR			number(1) not null,
	FISCAL_YEAR				number(5) not null,
	SQL_TIMESTAMP			timestamp_ntz,
	CURRENT_ROW_IND			char(1) default 'Y',
	EFFECTIVE_DATE			date default to_date(current_timestamp),
	EXPIRATION_DATE			date default To_date('9999-12-31') 
)
comment = 'Type 0 Dimension Table Housing Calendar and Fiscal Year Date Attributes'; 

-- Populate data into DIM_DATE
insert into DIM_DATE
select DATE_PKEY,
		DATE_COLUMN,
        FULL_DATE_DESC,
		DAY_NUM_IN_WEEK,
		DAY_NUM_IN_MONTH,
		DAY_NUM_IN_YEAR,
		DAY_NAME,
		DAY_ABBREV,
		WEEKDAY_IND,
		US_HOLIDAY_IND,
        COMPANY_HOLIDAY_IND,
		MONTH_END_IND,
		WEEK_BEGIN_DATE_NKEY,
		WEEK_BEGIN_DATE,
		WEEK_END_DATE_NKEY,
		WEEK_END_DATE,
		WEEK_NUM_IN_YEAR,
		MONTH_NAME,
		MONTH_ABBREV,
		MONTH_NUM_IN_YEAR,
		YEARMONTH,
		CURRENT_QUARTER,
		YEARQUARTER,
		CURRENT_YEAR,
		FISCAL_WEEK_NUM,
		FISCAL_MONTH_NUM,
		FISCAL_YEARMONTH,
		FISCAL_QUARTER,
		FISCAL_YEARQUARTER,
		FISCAL_HALFYEAR,
		FISCAL_YEAR,
		SQL_TIMESTAMP,
		CURRENT_ROW_IND,
		EFFECTIVE_DATE,
		EXPIRA_DATE
	from 
	    
        
    --( select to_date('01-25-2019 23:25:11.120','MM-DD-YYYY HH24:MI:SS.FF') as DD, /*<<Modify date for preferred table start date*/    
    --( select to_date('2013-01-01 00:00:01','YYYY-MM-DD HH24:MI:SS') as DD, /*<<Modify date for preferred table start date*/
	  ( select to_date('2012-12-31 23:59:59','YYYY-MM-DD HH24:MI:SS') as DD, /*<<Modify date for preferred table start date*/
			seq1() as Sl,row_number() over (order by Sl) as row_numbers,
			dateadd(day,row_numbers,DD) as V_DATE,
			case when date_part(dd, V_DATE) < 10 and date_part(mm, V_DATE) > 9 then
				date_part(year, V_DATE)||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) < 10 and  date_part(mm, V_DATE) < 10 then 
				 date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||'0'||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) < 10 then
				 date_part(year, V_DATE)||'0'||date_part(mm, V_DATE)||date_part(dd, V_DATE)
				 when date_part(dd, V_DATE) > 9 and  date_part(mm, V_DATE) > 9 then
				 date_part(year, V_DATE)||date_part(mm, V_DATE)||date_part(dd, V_DATE) end as DATE_PKEY,
			V_DATE as DATE_COLUMN,
			dayname(dateadd(day,row_numbers,DD)) as DAY_NAME_1,
			case 
				when dayname(dateadd(day,row_numbers,DD)) = 'Mon' then 'Monday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Tue' then 'Tuesday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Wed' then 'Wednesday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Thu' then 'Thursday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Fri' then 'Friday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Sat' then 'Saturday'
				when dayname(dateadd(day,row_numbers,DD)) = 'Sun' then 'Sunday' end ||', '||
			case when monthname(dateadd(day,row_numbers,DD)) ='Jan' then 'January'
				   when monthname(dateadd(day,row_numbers,DD)) ='Feb' then 'February'
				   when monthname(dateadd(day,row_numbers,DD)) ='Mar' then 'March'
				   when monthname(dateadd(day,row_numbers,DD)) ='Apr' then 'April'
				   when monthname(dateadd(day,row_numbers,DD)) ='May' then 'May'
				   when monthname(dateadd(day,row_numbers,DD)) ='Jun' then 'June'
				   when monthname(dateadd(day,row_numbers,DD)) ='Jul' then 'July'
				   when monthname(dateadd(day,row_numbers,DD)) ='Aug' then 'August'
				   when monthname(dateadd(day,row_numbers,DD)) ='Sep' then 'September'
				   when monthname(dateadd(day,row_numbers,DD)) ='Oct' then 'October'
				   when monthname(dateadd(day,row_numbers,DD)) ='Nov' then 'November'
				   when monthname(dateadd(day,row_numbers,DD)) ='Dec' then 'December' end
				   ||' '|| to_varchar(dateadd(day,row_numbers,DD), ' dd, yyyy') as FULL_DATE_DESC,
			dateadd(day,row_numbers,DD) as V_DATE_1,
			dayofweek(V_DATE_1)+1 as DAY_NUM_IN_WEEK,
			Date_part(dd,V_DATE_1) as DAY_NUM_IN_MONTH,
			dayofyear(V_DATE_1) as DAY_NUM_IN_YEAR,
			case 
				when dayname(V_DATE_1) = 'Mon' then 'Monday'
				when dayname(V_DATE_1) = 'Tue' then 'Tuesday'
				when dayname(V_DATE_1) = 'Wed' then 'Wednesday'
				when dayname(V_DATE_1) = 'Thu' then 'Thursday'
				when dayname(V_DATE_1) = 'Fri' then 'Friday'
				when dayname(V_DATE_1) = 'Sat' then 'Saturday'
				when dayname(V_DATE_1) = 'Sun' then 'Sunday' end as	DAY_NAME,
			dayname(dateadd(day,row_numbers,DD)) as DAY_ABBREV,
			case  
				when dayname(V_DATE_1) = 'Sun' and dayname(V_DATE_1) = 'Sat' then 
                 'Not-Weekday'
				else 'Weekday' end as WEEKDAY_IND,
			 case 
				when (DATE_PKEY = date_part(year, V_DATE)||'0101' or DATE_PKEY = date_part(year, V_DATE)||'0704' or
				DATE_PKEY = date_part(year, V_DATE)||'1225' or DATE_PKEY = date_part(year, V_DATE)||'1226') then  
				'Holiday' 
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Wed' 
				and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Thu' 
				and dateadd(day,-3,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Fri' 
				and dateadd(day,-4,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sat' 
				and dateadd(day,-5,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Sun' 
				and dateadd(day,-6,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Mon' 
				and last_day(V_DATE_1) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='May' and dayname(last_day(V_DATE_1)) = 'Tue' 
				and dateadd(day,-1 ,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
				and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
				and (dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  or 
					 dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
				and ( dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
				and ( dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,20,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				 'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
				and ( dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
				and ( dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
				and (dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
				and (dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 or 
					 dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 ) then
				 'Holiday'    
				else
				'Not-Holiday' end as US_HOLIDAY_IND,
			/*Modify the following for Company Specific Holidays*/
			case 
				when (DATE_PKEY = date_part(year, V_DATE)||'0101' or DATE_PKEY = date_part(year, V_DATE)||'0219'
				or DATE_PKEY = date_part(year, V_DATE)||'0528' or DATE_PKEY = date_part(year, V_DATE)||'0704' 
				or DATE_PKEY = date_part(year, V_DATE)||'1225' )then 
				'Holiday'               
                when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Fri' 
				and last_day(V_DATE_1) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sat' 
				and dateadd(day,-1,last_day(V_DATE_1)) = V_DATE_1  then
				'Holiday'
				when monthname(V_DATE_1) ='Mar' and dayname(last_day(V_DATE_1)) = 'Sun' 
				and dateadd(day,-2,last_day(V_DATE_1)) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue'
                and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu'
                and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
				and date_part(year, V_DATE_1)||'-04-01' = V_DATE_1 then
				'Holiday'
                when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-04-01'= V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Apr' and dayname(date_part(year, V_DATE_1)||'-04-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-04-01')) = V_DATE_1  then
				'Holiday'   
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Wed' 
				and dateadd(day,5,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Thu' 
				and dateadd(day,4,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Fri' 
				and dateadd(day,3,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sat' 
				and dateadd(day,2,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Sun' 
				and dateadd(day,1,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Mon' 
                and date_part(year, V_DATE_1)||'-09-01' = V_DATE_1 then
				'Holiday' 
				when monthname(V_DATE_1) ='Sep' and dayname(date_part(year, V_DATE_1)||'-09-01') = 'Tue' 
				and dateadd(day,6 ,(date_part(year, V_DATE_1)||'-09-01')) = V_DATE_1  then
				'Holiday' 
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Wed' 
				and dateadd(day,23,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Thu' 
				and dateadd(day,22,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Fri' 
				and dateadd(day,21,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
				 'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sat' 
				and dateadd(day,27,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Sun' 
				and dateadd(day,26,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Mon' 
				and dateadd(day,25,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1 then
				'Holiday'
				when monthname(V_DATE_1) ='Nov' and dayname(date_part(year, V_DATE_1)||'-11-01') = 'Tue' 
				and dateadd(day,24,(date_part(year, V_DATE_1)||'-11-01')) = V_DATE_1  then
				 'Holiday'     
				else
				'Not-Holiday' end as COMPANY_HOLIDAY_IND,
			case                                           
				when last_day(V_DATE_1) = V_DATE_1 then 
				'Month-end'
				else 'Not-Month-end' end as MONTH_END_IND,
					
			case when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
					  date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
					  date_part(mm,date_trunc('week',V_DATE_1))||'0'||
					  date_part(dd,date_trunc('week',V_DATE_1))  
				 when date_part(mm,date_trunc('week',V_DATE_1)) < 10 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||'0'||
						date_part(mm,date_trunc('week',V_DATE_1))||date_part(dd,date_trunc('week',V_DATE_1))    
				 when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) < 10 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||date_part(mm,date_trunc('week',V_DATE_1))||
						'0'||date_part(dd,date_trunc('week',V_DATE_1))    
				when date_part(mm,date_trunc('week',V_DATE_1)) > 9 and date_part(dd,date_trunc('week',V_DATE_1)) > 9 then
						date_part(yyyy,date_trunc('week',V_DATE_1))||
						date_part(mm,date_trunc('week',V_DATE_1))||
						date_part(dd,date_trunc('week',V_DATE_1)) end as WEEK_BEGIN_DATE_NKEY,
			date_trunc('week',V_DATE_1) as WEEK_BEGIN_DATE,

			case when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) < 10 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
					  date_part(mm,last_day(V_DATE_1,'week'))||'0'||
					  date_part(dd,last_day(V_DATE_1,'week')) 
				 when  date_part(mm,last_day(V_DATE_1,'week')) < 10 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||'0'||
					  date_part(mm,last_day(V_DATE_1,'week'))||date_part(dd,last_day(V_DATE_1,'week'))   
				 when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) < 10  then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||date_part(mm,last_day(V_DATE_1,'week'))||'0'||
					  date_part(dd,last_day(V_DATE_1,'week'))   
				 when  date_part(mm,last_day(V_DATE_1,'week')) > 9 and date_part(dd,last_day(V_DATE_1,'week')) > 9 then
					  date_part(yyyy,last_day(V_DATE_1,'week'))||
					  date_part(mm,last_day(V_DATE_1,'week'))||
					  date_part(dd,last_day(V_DATE_1,'week')) end as WEEK_END_DATE_NKEY,
			last_day(V_DATE_1,'week') as WEEK_END_DATE,
			week(V_DATE_1) as WEEK_NUM_IN_YEAR,
			case when monthname(V_DATE_1) ='Jan' then 'January'
				   when monthname(V_DATE_1) ='Feb' then 'February'
				   when monthname(V_DATE_1) ='Mar' then 'March'
				   when monthname(V_DATE_1) ='Apr' then 'April'
				   when monthname(V_DATE_1) ='May' then 'May'
				   when monthname(V_DATE_1) ='Jun' then 'June'
				   when monthname(V_DATE_1) ='Jul' then 'July'
				   when monthname(V_DATE_1) ='Aug' then 'August'
				   when monthname(V_DATE_1) ='Sep' then 'September'
				   when monthname(V_DATE_1) ='Oct' then 'October'
				   when monthname(V_DATE_1) ='Nov' then 'November'
				   when monthname(V_DATE_1) ='Dec' then 'December' end as MONTH_NAME,
			monthname(V_DATE_1) as MONTH_ABBREV,
			month(V_DATE_1) as MONTH_NUM_IN_YEAR,
			case when month(V_DATE_1) < 10 then 
			year(V_DATE_1)||'-0'||month(V_DATE_1)   
			else year(V_DATE_1)||'-'||month(V_DATE_1) end as YEARMONTH,
			quarter(V_DATE_1) as CURRENT_QUARTER,
			year(V_DATE_1)||'-0'||quarter(V_DATE_1) as YEARQUARTER,
			year(V_DATE_1) as CURRENT_YEAR,
			/*Modify the following based on company fiscal year - assumes Jan 01*/
            to_date(year(V_DATE_1)||'-01-01','YYYY-MM-DD') as FISCAL_CUR_YEAR,
            to_date(year(V_DATE_1) -1||'-01-01','YYYY-MM-DD') as FISCAL_PREV_YEAR,
			case when   V_DATE_1 < FISCAL_CUR_YEAR then
			datediff('week', FISCAL_PREV_YEAR,V_DATE_1)
			else 
			datediff('week', FISCAL_CUR_YEAR,V_DATE_1)  end as FISCAL_WEEK_NUM  ,
			decode(datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ,-2,10,-1,11,0,12,
                   datediff('MONTH',FISCAL_CUR_YEAR, V_DATE_1)+1 ) as FISCAL_MONTH_NUM,
			concat( year(FISCAL_CUR_YEAR) 
				   ,case when to_number(FISCAL_MONTH_NUM) = 10 or 
							to_number(FISCAL_MONTH_NUM) = 11 or 
                            to_number(FISCAL_MONTH_NUM) = 12  then
							'-'||FISCAL_MONTH_NUM
					else  concat('-0',FISCAL_MONTH_NUM) end ) as FISCAL_YEARMONTH,
			case when quarter(V_DATE_1) = 4 then 4
				 when quarter(V_DATE_1) = 3 then 3
				 when quarter(V_DATE_1) = 2 then 2
				 when quarter(V_DATE_1) = 1 then 1 end as FISCAL_QUARTER,
			
			case when   V_DATE_1 < FISCAL_CUR_YEAR then
					year(FISCAL_CUR_YEAR)
					else year(FISCAL_CUR_YEAR)+1 end
					||'-0'||case when quarter(V_DATE_1) = 4 then 4
					 when quarter(V_DATE_1) = 3 then 3
					 when quarter(V_DATE_1) = 2 then 2
					 when quarter(V_DATE_1) = 1 then 1 end as FISCAL_YEARQUARTER,
			case when quarter(V_DATE_1) = 4  then 2 when quarter(V_DATE_1) = 3 then 2
				when quarter(V_DATE_1) = 1  then 1 when quarter(V_DATE_1) = 2 then 1
			end as FISCAL_HALFYEAR,
			year(FISCAL_CUR_YEAR) as FISCAL_YEAR,
			to_timestamp_ntz(V_DATE) as SQL_TIMESTAMP,
			'Y' as CURRENT_ROW_IND,
			to_date(current_timestamp) as EFFECTIVE_DATE,
			to_date('9999-12-31') as EXPIRA_DATE
			--from table(generator(rowcount => 8401)) /*<< Set to generate 20 years. Modify rowcount to increase or decrease size*/
	        from table(generator(rowcount => 730)) /*<< Set to generate 20 years. Modify rowcount to increase or decrease size*/
    )v;

--Miscellaneous queries
--select * from  DIM_DATE
--ORDER BY DATE;


--delete from DIM_DATE;

--drop table DIM_DATE;
 

-- Create Dim_Location
CREATE OR REPLACE TABLE Dim_Location (
    DimLocationID INT AUTOINCREMENT PRIMARY KEY,
    Address VARCHAR not null,
    City VARCHAR not null,
    PostalCode VARCHAR not null,
    State_Province VARCHAR not null,
    Country VARCHAR not null
);

-- Insert NULL values into Dim_Location
INSERT INTO Dim_Location (
    Address, City, PostalCode, State_Province, Country
) VALUES (
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown'
);

--Insert Values into Dim_Location
INSERT INTO Dim_Location (Address, City, PostalCode, State_Province, Country)
SELECT DISTINCT
    ADDRESS,
    CITY,
    POSTALCODE,
    STATE_PROVINCE,
    COUNTRY
FROM PUBLIC_STORE
WHERE CITY IS NOT NULL AND COUNTRY IS NOT NULL;

--SELECT * FROM DIM_LOCATION

-- Create Dim_Store
CREATE OR REPLACE TABLE Dim_Store (
    DIMStoreID int PRIMARY KEY,
    SOURCESTOREID INT NOT NULL,
    StoreName VARCHAR NOT NULL,
    StoreNumber INT not null,
    StoreManager VARCHAR not null,
    Address VARCHAR not null,
    City VARCHAR not null,
    State_Province VARCHAR not null,
    Country VARCHAR not null,
    PostalCode VARCHAR not null,
    PhoneNumber VARCHAR not null,
    DimLocationID INT not null
);
-- Add foreign keys
ALTER TABLE Dim_Store
ADD CONSTRAINT fk_store_location        
FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID);                     --DimlocationID is FK in Dim_Store

-- Insert NULL values into Dim_Store 
INSERT INTO Dim_Store (
    DimStoreID, SourceStoreID, StoreName, StoreNumber, StoreManager,
    Address, City, State_Province, Country, PostalCode, PhoneNumber, DimLocationID
)
VALUES (
    -1, -1, 'UNKNOWN', -1, 'UNKNOWN',
    'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 'UNKNOWN', 1
);
UPDATE PUBLIC_SALES_HEADER_NEW
SET STORE_ID = -1
WHERE STORE_ID IS NULL;

-- Replace NULL customer ID with '-1'
UPDATE PUBLIC_SALES_HEADER_NEW
SET CUSTOMER_ID = '-1'
WHERE CUSTOMER_ID IS NULL;

-- Insert Values into Dim_Store
INSERT INTO Dim_Store (
    DimStoreID, SourceStoreID, StoreName, StoreNumber, StoreManager,
    Address, City, State_Province, Country, PostalCode, PhoneNumber, DimLocationID
)
SELECT 
    s.STORE_ID AS DimStoreID,
    s.STORE_ID AS SourceStoreID,
    'Unknown' AS StoreName,
    COALESCE(s.STORE_NUMBER, -1),
    COALESCE(s.STORE_MANAGER, 'Unknown'),
    COALESCE(s.ADDRESS, 'Unknown'),
    COALESCE(s.CITY, 'Unknown'),
    COALESCE(s.STATE_PROVINCE, 'Unknown'),
    COALESCE(s.COUNTRY, 'Unknown'),
    COALESCE(s.POSTALCODE, 'Unknown'),
    COALESCE(s.PHONE_NUMBER, 'Unknown'),
    COALESCE(l.DimLocationID, 1)  -- default to 1 if location not found
FROM PUBLIC_STORE s
LEFT JOIN Dim_Location l 
  ON TRIM(UPPER(s.CITY)) = TRIM(UPPER(l.City))
 AND TRIM(UPPER(s.STATE_PROVINCE)) = TRIM(UPPER(l.State_Province))
 AND TRIM(UPPER(s.POSTALCODE)) = TRIM(UPPER(l.PostalCode));
  
--SELECT * FROM DIM_STORE

-- Create Dim_Reseller
CREATE OR REPLACE TABLE Dim_Reseller (
    ResellerID INT AUTOINCREMENT PRIMARY KEY,
    ResellerName VARCHAR not null,
    ContactName VARCHAR not null,
    PhoneNumber VARCHAR not null,
    Email VARCHAR not null,
    Address VARCHAR not null,
    City VARCHAR not null,
    State_Province VARCHAR not null,
    Country VARCHAR not null,
    PostalCode VARCHAR not null,
    DimLocationID INT not null
);
ALTER TABLE Dim_Reseller
ADD CONSTRAINT fk_reseller_location
FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID);                                 --DimlocationID is FK in Dim_Reseller


-- Insert NULL values into Dim_Reseller 
INSERT INTO Dim_Reseller (
    ResellerName, ContactName, PhoneNumber, Email, Address, City, State_Province, Country, PostalCode, DimLocationID
) VALUES (
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 1
);

INSERT INTO Dim_Reseller (
    ResellerName, ContactName, PhoneNumber, Email,
    Address, City, State_Province, Country, PostalCode, DimLocationID
)
SELECT 
    r.RESELLER_NAME,
    r.CONTACT,
    r.PHONE_NUMBER,
    r.EMAIL_ADDRESS,
    r.ADDRESS,
    r.CITY,
    r.STATE_PROVINCE,
    r.COUNTRY,
    r.POSTALCODE,
    COALESCE(loc.DimLocationID, 1)
FROM PUBLIC_RESELLER r
LEFT JOIN Dim_Location loc                                               -- JOIN Reseller, Store, and Location
  ON r.CITY = loc.CITY AND r.STATE_PROVINCE = loc.STATE_PROVINCE AND r.COUNTRY = loc.COUNTRY;

 -- SELECT * FROM Dim_Reseller

-- Create Dim_Customer
CREATE OR REPLACE TABLE Dim_Customer (
    DimCustomerID INT AUTOINCREMENT PRIMARY KEY,
    CustomerID VARCHAR not null , 
    CustomerFullName VARCHAR not null,
    CustomerFirstName VARCHAR not null,
    CustomerLastName VARCHAR not null,
    CustomerGender VARCHAR not null,
    Email VARCHAR not null,
    Address VARCHAR not null,
    City VARCHAR not null,
    State_Province VARCHAR not null,
    Country VARCHAR not null,
    PostalCode VARCHAR not null,
    PhoneNumber VARCHAR not null,
    DimLocationID INT not null
);
ALTER TABLE Dim_Customer
ADD CONSTRAINT fk_customer_location
FOREIGN KEY (DimLocationID) REFERENCES Dim_Location(DimLocationID);                     -- DIMLocation ID is FK in Dim_Customer

-- Insert NULL Values into Dim_Customer 
INSERT INTO Dim_Customer (
    CustomerID, CustomerFullName, CustomerFirstName, CustomerLastName, CustomerGender,
    Email, Address, City, State_Province, Country, PostalCode, PhoneNumber, DimLocationID
) VALUES (
    -1, 'Unknown Customer', 'Unknown', 'Unknown', 'Unknown',
    'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 'Unknown', 1
);

-- Insert Values into Dim_Customer
INSERT INTO Dim_Customer (
    CustomerID, CustomerFullName, CustomerFirstName, CustomerLastName, CustomerGender,
    Email, Address, City, State_Province, Country, PostalCode, PhoneNumber, DimLocationID
)
SELECT 
    c.CUSTOMER_ID,
    c.FIRST_NAME || ' ' || c.LAST_NAME AS CustomerFullName,
    c.FIRST_NAME,
    c.LAST_NAME,
    c.GENDER,
    c.EMAIL_ADDRESS,
    c.ADDRESS,
    c.CITY,
    c.STATE_PROVINCE,
    c.COUNTRY,
    c.POSTAL_CODE,
    c.PHONE_NUMBER,
    COALESCE(loc.DimLocationID, 1)
FROM PUBLIC_CUSTOMER c
LEFT JOIN Dim_Location loc
  ON c.CITY = loc.CITY
 AND c.STATE_PROVINCE = loc.STATE_PROVINCE
 AND c.COUNTRY = loc.COUNTRY;
--SELECT * FROM Dim_Customer

-- Create Dim_Product
CREATE OR REPLACE TABLE Dim_Product (
    DimProductID INT AUTOINCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    ProductTypeID INT NOT NULL,
    ProductCategoryID INT NOT NULL,
    ProductName VARCHAR(255) NOT NULL,
    ProductType VARCHAR(100) NOT NULL,
    ProductCategory VARCHAR(100) NOT NULL,
    ProductRetailPrice DECIMAL(10,2) NOT NULL,
    ProductWholesalePrice DECIMAL(10,2) NOT NULL,
    ProductCost DECIMAL(10,2) NOT NULL,
    ProductRetailProfit DECIMAL(10,2) NOT NULL,
    ProductWholesaleUnitProfit DECIMAL(10,2) NOT NULL,
    ProductProfitMarginUnitPercent DECIMAL(5,2) NOT NULL
);


-- Insert NULL values into Dim_Product
INSERT INTO Dim_Product (
    ProductID,
    ProductTypeID,
    ProductCategoryID,
    ProductName,
    ProductType,
    ProductCategory,
    ProductRetailPrice,
    ProductWholesalePrice,
    ProductCost,
    ProductRetailProfit,
    ProductWholesaleUnitProfit,
    ProductProfitMarginUnitPercent
)
VALUES (
    -1,       -- ProductID (INT)
    -1,       -- ProductTypeID (INT)
    -1,       -- ProductCategoryID (INT)
    'Unknown',
    'Unknown',
    'Unknown',
    -1.00,    -- ProductRetailPrice (NUMBER)
    -1.00,    -- ProductWholesalePrice (NUMBER)
    -1.00,    -- ProductCost (NUMBER)
    -1.00,    -- ProductRetailProfit (NUMBER)
    -1.00,    -- ProductWholesaleUnitProfit (NUMBER)
    -1.00     -- ProductProfitMarginUnitPercent (NUMBER)
);

-- Insert values into Dim_Product and join product, product category, product type together
INSERT INTO Dim_Product (
    ProductID, ProductTypeID, ProductCategoryID,
    ProductName, ProductType, ProductCategory,
    ProductRetailPrice, ProductWholesalePrice, ProductCost,
    ProductRetailProfit, ProductWholesaleUnitProfit, ProductProfitMarginUnitPercent
)

SELECT 
    p.PRODUCT_ID,
    p.PRODUCT_TYPE_ID,
    pt.PRODUCT_CATEGORY_ID,
    p.PRODUCT, 
    pt.PRODUCT_TYPE,
    pc.PRODUCT_CATEGORY,
    p.PRICE,
    p.WHOLESALE_PRICE,
    p.COST,
    (p.PRICE - p.COST) AS ProductRetailProfit,
    (p.WHOLESALE_PRICE - p.COST) AS ProductWholesaleUnitProfit,
    CASE WHEN p.PRICE != 0 THEN ROUND((p.PRICE - p.COST) / p.PRICE * 100, 2)
         ELSE NULL END AS ProductProfitMarginUnitPercent
FROM PUBLIC_PRODUCT p
JOIN PUBLIC_PRODUCT_TYPE pt ON p.PRODUCT_TYPE_ID = pt.PRODUCT_TYPE_ID                               -- JOIN Product, ProductType, and ProductCategory
JOIN PUBLIC_PRODUCT_CATEGORY pc ON pt.PRODUCT_CATEGORY_ID = pc.PRODUCT_CATEGORY_ID;

--SELECT * FROM Dim_Product;

-- Create Dim_Channel
CREATE OR REPLACE TABLE Dim_Channel (
    DimChannelID INT AUTOINCREMENT PRIMARY KEY,
    ChannelID VARCHAR not null,
    ChannelCategoryID VARCHAR not null,
    ChannelName VARCHAR not null,
    ChannelCategory VARCHAR not null
);

-- Insert NULL values into Dim_Channel
INSERT INTO Dim_Channel (
    ChannelID, ChannelCategoryID, ChannelName, ChannelCategory
) VALUES (
    'UNKNOWN', 'UNKNOWN', 'Unknown', 'Unknown'
);

-- Insert values into Dim_Channel
INSERT INTO Dim_Channel (
    ChannelID, ChannelCategoryID, ChannelName, ChannelCategory
)
SELECT 
    c.CHANNEL_ID,
    c.CHANNEL_CATEGORY_ID,
    c.CHANNEL,
    cc.CHANNEL_CATEGORY
FROM PUBLIC_STAGING_CHANNEL c                                   -- Join Channel and Channel CategoryID
JOIN PUBLIC_STAGING_CHANNEL_CATEGORY cc
  ON c.CHANNEL_CATEGORY_ID = cc.CHANNEL_CATEGORY_ID;
--SELECT * FROM DIM_CHANNEL;


-- 7.11 Create, Load Fact Tables
CREATE OR REPLACE TABLE Fact_SalesActual (
    SalesHeaderID INT,
    SalesDetailID INT PRIMARY KEY,

    DimProductID INT NOT NULL,
    DimStoreID INT NOT NULL,
    DimResellerID INT,                   
    DimCustomerID INT,
    DimChannelID INT NOT NULL,
    DimSaleDateID NUMBER(9) NOT NULL,   
    DimLocationID INT NOT NULL,         
    SaleAmount DECIMAL(12, 2),
    SaleQuantity INT,
    SaleUnitPrice DECIMAL(10, 2),
    SaleExtendedCost DECIMAL(12, 2),
    SaleTotalProfit DECIMAL(12, 2),

    -- Foreign key reference
    CONSTRAINT fk_product     FOREIGN KEY (DimProductID)   REFERENCES Dim_Product(DimProductID),
    CONSTRAINT fk_store       FOREIGN KEY (DimStoreID)     REFERENCES Dim_Store(DimStoreID),
    CONSTRAINT fk_reseller    FOREIGN KEY (DimResellerID)  REFERENCES Dim_Reseller(ResellerID),
    CONSTRAINT fk_customer    FOREIGN KEY (DimCustomerID)  REFERENCES Dim_Customer(DimCustomerID),
    CONSTRAINT fk_channel     FOREIGN KEY (DimChannelID)   REFERENCES Dim_Channel(DimChannelID),
    CONSTRAINT fk_date        FOREIGN KEY (DimSaleDateID)  REFERENCES Dim_Date(DATE_PKEY),
    CONSTRAINT fk_location    FOREIGN KEY (DimLocationID)  REFERENCES Dim_Location(DimLocationID)
);
-- Insert values into Fact_salesActual
INSERT INTO Fact_SalesActual (
    SalesHeaderID,
    SalesDetailID,
    DimProductID,
    DimStoreID,
    DimResellerID,
    DimCustomerID,
    DimChannelID,
    DimSaleDateID,
    DimLocationID,
    SaleAmount,
    SaleQuantity,
    SaleUnitPrice,
    SaleExtendedCost,
    SaleTotalProfit
)
SELECT
    PUBLIC_SALES_HEADER_NEW.SALES_HEADER_ID,
    PUBLIC_SALES_DETAIL.SALES_DETAIL_ID,
    Dim_Product.DimProductID,
    COALESCE(Dim_Store.DimStoreID, -1),
    COALESCE(Dim_Reseller.ResellerID, -1),
    COALESCE(Dim_Customer.DimCustomerID, -1),
    COALESCE(Dim_Channel.DimChannelID, -1),
    Dim_Date.DATE_PKEY,
    COALESCE(Dim_Store.DimLocationID, 1),
    PUBLIC_SALES_DETAIL.SALES_AMOUNT,
    PUBLIC_SALES_DETAIL.SALES_QUANTITY,

    -- SaleUnitPrice
    CASE 
        WHEN PUBLIC_SALES_DETAIL.SALES_QUANTITY = 0 THEN 0 
        ELSE PUBLIC_SALES_DETAIL.SALES_AMOUNT / PUBLIC_SALES_DETAIL.SALES_QUANTITY 
    END,

    -- SaleExtendedCost
    PUBLIC_SALES_DETAIL.SALES_QUANTITY * Dim_Product.ProductCost,

    -- SaleTotalProfit
    PUBLIC_SALES_DETAIL.SALES_AMOUNT - (PUBLIC_SALES_DETAIL.SALES_QUANTITY * Dim_Product.ProductCost)

FROM PUBLIC_SALES_DETAIL
JOIN PUBLIC_SALES_HEADER_NEW
    ON PUBLIC_SALES_DETAIL.SALES_HEADER_ID = PUBLIC_SALES_HEADER_NEW.SALES_HEADER_ID

JOIN Dim_Product
    ON PUBLIC_SALES_DETAIL.PRODUCT_ID = Dim_Product.ProductID

JOIN Dim_Store
    ON PUBLIC_SALES_HEADER_NEW.STORE_ID = Dim_Store.SourceStoreID

LEFT JOIN Dim_Reseller
    ON TO_NUMBER(PUBLIC_SALES_HEADER_NEW.RESELLER_ID) = Dim_Reseller.ResellerID

LEFT JOIN Dim_Customer
    ON PUBLIC_SALES_HEADER_NEW.CUSTOMER_ID = Dim_Customer.CustomerID

LEFT JOIN Dim_Channel
    ON TO_VARCHAR(PUBLIC_SALES_HEADER_NEW.CHANNEL_ID) = Dim_Channel.ChannelID

JOIN Dim_Date
    ON TO_DATE(PUBLIC_SALES_HEADER_NEW."DATE", 'MM/DD/YY') = Dim_Date.Date;

--SELECT * FROM FACT_SALESACTUAL;



CREATE OR REPLACE TABLE Fact_SRCSalesTarget (
    SRCSalesTargetID INT AUTOINCREMENT PRIMARY KEY,
    DimStoreID INT NOT NULL,
    DimResellerID INT NOT NULL,
    DimChannelID INT NOT NULL,
    DimDateID NUMBER(9) NOT NULL,
    TargetSalesAmount NUMBER(12,2),
    TargetName VARCHAR,
    FOREIGN KEY (DimStoreID) REFERENCES Dim_Store(DimStoreID),
    FOREIGN KEY (DimResellerID) REFERENCES Dim_Reseller(ResellerID),
    FOREIGN KEY (DimChannelID) REFERENCES Dim_Channel(DimChannelID),
    FOREIGN KEY (DimDateID) REFERENCES Dim_Date(Date_PKEY)
);

INSERT INTO Fact_SRCSalesTarget (
    DimStoreID,
    DimResellerID,
    DimChannelID,
    DimDateID,
    TargetSalesAmount,
    TargetName
)
SELECT 
    COALESCE(
        CASE 
            WHEN r.ResellerID IS NULL THEN s.DimStoreID 
            ELSE NULL 
        END, -1) AS DimStoreID,

    COALESCE(
        CASE 
            WHEN r.ResellerID IS NOT NULL THEN r.ResellerID 
            ELSE NULL 
        END, -1) AS DimResellerID,

    COALESCE(c.ChannelID, -1) AS DimChannelID,
    COALESCE(d.Date_PKEY, -1) AS DimDateID,

    t.TARGET_SALES_AMOUNT::NUMBER(12,2),
    t.TARGET_NAME
FROM PUBLIC_TARGET_DATE_CHANNEL t
LEFT JOIN Dim_Reseller r 
    ON TRIM(UPPER(t.TARGET_NAME)) = TRIM(UPPER(r.ResellerName))
LEFT JOIN Dim_Store s 
    ON r.ResellerID IS NULL  
   AND TRIM(UPPER(t.TARGET_NAME)) = TRIM(UPPER(s.StoreName))
LEFT JOIN Dim_Channel c 
    ON TRIM(UPPER(t.CHANNEL_NAME)) = TRIM(UPPER(c.ChannelName))
LEFT JOIN Dim_Date d 
    ON TO_DATE(t.YEAR || '-01-01') = d.Date;

--Select * FROM FACT_SRCSALESTARGET



--View Tables: 8.15 Data Warehouse Submission
CREATE OR REPLACE SECURE VIEW Store_5_8_Sales_Comparison AS
WITH ActualSales AS (
    SELECT
        ds.StoreNumber,
        dd.YEAR,
        SUM(fsa.SALETOTALPROFIT) AS TotalActualSales
    FROM Fact_SalesActual fsa
    JOIN Dim_Store ds ON fsa.DimStoreID = ds.DimStoreID
    JOIN Dim_Date dd ON fsa.DimSaleDateID = dd.DATE_PKEY
    WHERE ds.StoreNumber IN ('5', '8')
      AND dd.YEAR IN (2013, 2014)
    GROUP BY ds.StoreNumber, dd.YEAR
),
TargetSales AS (
    SELECT
        ds.StoreNumber,
        dd.YEAR,
        SUM(fst.TargetSalesAmount) AS TotalTargetSales
    FROM Fact_SRCSalesTarget fst
    JOIN Dim_Store ds ON fst.TargetName = 'Store Number ' || ds.StoreNumber
    JOIN Dim_Date dd ON fst.DimDateID = dd.DATE_PKEY
    WHERE ds.StoreNumber IN ('5', '8')
      AND dd.YEAR IN (2013, 2014)
      AND fst.DimResellerID = -1 
    GROUP BY ds.StoreNumber, dd.YEAR
)
SELECT
    a.StoreNumber,
    a.YEAR,
    a.TotalActualSales,
    COALESCE(t.TotalTargetSales, 0) AS TotalTargetSales,
    a.TotalActualSales - COALESCE(t.TotalTargetSales, 0) AS SalesVariance
FROM ActualSales a
LEFT JOIN TargetSales t
    ON a.StoreNumber = t.StoreNumber AND a.YEAR = t.YEAR
ORDER BY a.StoreNumber, a.YEAR;
--SELECT * FROM STORE_5_8_SALES_COMPARISON;

SELECT *
FROM Fact_SRCSalesTarget
WHERE DimResellerID = -1;

-- Q2. Recommend separate 2013 and 2014 bonus amounts for each store if the total bonus pool for 2013 is $500,000 and the total bonus pool for 2014 is $400,000. Base your recommendation on how well the stores are selling Product Types of Men’s Casual and Women’s Casual.

-- View Table
CREATE OR REPLACE SECURE VIEW Casual_Sales_By_StoreYear AS
--Bonus Recommendations 
SELECT
    s.StoreNumber,
    d.YEAR,
    pt.ProductType,
    SUM(f.SaleAmount) AS TotalSales
FROM Fact_SalesActual f
JOIN Dim_Store s ON f.DimStoreID = s.DimStoreID
JOIN Dim_Date d ON f.DimSaleDateID = d.DATE_PKEY
JOIN Dim_Product p ON f.DimProductID = p.DimProductID
JOIN (
    SELECT DISTINCT ProductType FROM Dim_Product
    WHERE LOWER(ProductType) IN ('men''s casual', 'women''s casual')
) pt ON p.ProductType = pt.ProductType
WHERE s.StoreNumber IN (5, 8)
  AND d.YEAR IN (2013, 2014)
GROUP BY s.StoreNumber, d.YEAR, pt.ProductType
ORDER BY s.StoreNumber, d.YEAR;
-- SELECT * FROM CASUAL_SALES_BY_STOREYEAR;

--Bonus allocation view and script
CREATE OR REPLACE VIEW Bonus_Allocation_Store_5_8 AS
WITH QualifiedSales AS (
    SELECT
        ds.StoreNumber,
        dd.YEAR,
        SUM(fsa.SaleAmount) AS YearlyStoreSales
    FROM Fact_SalesActual fsa
    JOIN Dim_Product dp ON fsa.DimProductID = dp.DimProductID
    JOIN Dim_Date dd ON fsa.DimSaleDateID = dd.Date_PKEY
    JOIN Dim_Store ds ON fsa.DimStoreID = ds.DimStoreID
    WHERE ds.StoreNumber IN ('5', '8')
      AND dp.ProductType IN ('Men''s Casual', 'Women''s Casual')
      AND dd.YEAR IN (2013, 2014)
    GROUP BY ds.StoreNumber, dd.YEAR
),
TotalSalesAllStores AS (
    SELECT
        YEAR,
        SUM(YearlyStoreSales) AS TotalSalesAllStores
    FROM QualifiedSales
    GROUP BY YEAR
),
BonusPool AS (
    SELECT 2013 AS YEAR, 500000.00 AS PoolAmount
    UNION ALL
    SELECT 2014, 400000.00
)
SELECT
    q.StoreNumber,
    q.YEAR,
    q.YearlyStoreSales,
    t.TotalSalesAllStores,
    b.PoolAmount,
    ROUND((q.YearlyStoreSales / t.TotalSalesAllStores) * b.PoolAmount, 2) AS BonusAmount
FROM QualifiedSales q
JOIN TotalSalesAllStores t ON q.YEAR = t.YEAR
JOIN BonusPool b ON q.YEAR = b.YEAR;
--SELECT * from bonus_allocation_store_5_8 

GROUP BY ds.StoreNumber, dd.YEAR, dp.ProductType
-- Q3.Assess product sales by day of the week at Stores 5 and 8. What can we learn about sales trends?

--View Table
Create or replace SECURE view store5_8_weeklytrends AS

-- Daily Sales Trend for Store 5 and 8
SELECT
    s.StoreNumber,
    d.YEAR,
    d.DAY_NAME,
    SUM(f.SaleAmount) AS TotalSales
FROM Fact_SalesActual f
JOIN Dim_Store s ON f.DimStoreID = s.DimStoreID
JOIN Dim_Date d ON f.DimSaleDateID = d.Date_PKEY
WHERE s.StoreNumber IN ('5', '8')
  AND d.YEAR IN (2013, 2014)
GROUP BY s.StoreNumber, d.YEAR, d.DAY_NAME
ORDER BY s.StoreNumber, d.YEAR, d.DAY_NAME;

--SELECT * FROM store5_8_weeklytrends;


-- Q4 Compare the performance of all stores located in states that have more than one store to all stores that are the only store in the state. What can we learn about having more than one store in a state?

-- View Table
Create or replace SECURE view store_State_Comparison AS 

-- Performance Comparison SELECT
WITH StoreCounts AS (
    SELECT State_Province, COUNT(*) AS StoreCount
    FROM Dim_Store
    GROUP BY State_Province
),
StoreClassification AS (
    SELECT 
        s.DimStoreID,
        s.StoreNumber,
        s.State_Province,
        CASE 
            WHEN sc.StoreCount > 1 THEN 'Multiple'
            ELSE 'Single'
        END AS StateStoreType
    FROM Dim_Store s
    JOIN StoreCounts sc ON s.State_Province = sc.State_Province
)
SELECT 
    sc.StateStoreType,
    dd.Year,
    COUNT(DISTINCT s.StoreNumber) AS NumStores,
    SUM(f.SaleAmount) AS TotalSales,
    AVG(f.SaleAmount) AS AvgSalesPerTxn
FROM Fact_SalesActual f
JOIN StoreClassification sc ON f.DimStoreID = sc.DimStoreID
JOIN Dim_Store s ON f.DimStoreID = s.DimStoreID
JOIN Dim_Date dd ON f.DimSaleDateID = dd.Date_PKEY
WHERE dd.Year IN (2013, 2014)
GROUP BY sc.StateStoreType, dd.Year
ORDER BY sc.StateStoreType, dd.Year;

--SELECT * FROM STORE_STATE_COMPARISON;
