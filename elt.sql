-- Set role to SYSADMIN to allow creation of database and schemas
USE ROLE SYSADMIN;

-- Create a database and schema for the marketing campaign performance analysis
CREATE DATABASE CAMPAIGN;

CREATE OR REPLACE SCHEMA CAMPAIGN.PERF;

-- Drop default PUBLIC schema
DROP SCHEMA PUBLIC;

-- Check files staged in the campaign data location
LIST @MARKETING.PERFORMANCE.CAMPAIGNSTAGE;

-- Define file format for reading the staged CSV
CREATE OR REPLACE FILE FORMAT stage_to_table
TYPE = CSV
FIELD_DELIMITER = ','
SKIP_HEADER = 1
TRIM_SPACE = TRUE
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
;

-- Create a view to transform raw staged data into structured format
CREATE OR REPLACE VIEW VIEW_T1 AS (
SELECT 
    $1::INT AS CAMPAIGN_NO,
    $2::VARCHAR(50) AS COMPANY,
    $3::VARCHAR(20) AS CAMPAIGN_TYPE,
     -- Split combined gender-age field
    SPLIT_PART($4, ' ', 1)::VARCHAR(10) AS TARGET_GENDER,
    SPLIT_PART($4, ' ', 2)::VARCHAR(10) AS TARGET_AGE,
    -- Remove 'days' text from duration and cast to INT
    RTRIM($5, 'days')::INT AS DURATION,
    $6::VARCHAR(20) AS CHANNEL,
    $7::DECIMAL(10,2) AS CONVERSION_RATE,
    -- Remove '$' and ',' from acquisition cost and cast to decimal
    REPLACE(LTRIM($8, '$'), ',')::DECIMAL(10,2) AS ACQ,
    $9::DECIMAL(10,2) AS ROI,
    $10::VARCHAR(20) AS LOCATION,
    $11::VARCHAR(20) AS LANGUAGE,
    $12::INT AS CLICKS,
    $13::INT AS IMPRESSIONS,
    $14::INT AS ENGSCORE,
    $15::VARCHAR(30) AS CUSTOMER,
    $16::DATE AS CAMPAIGNDATE,
    -- Extract year and month from date
    DATE_PART(YEAR, CAMPAIGNDATE) AS CAMPYEAR,
    monthname(TO_DATE($16::DATE)) AS CAMPMONTH,
FROM @MARKETING.PERFORMANCE.CAMPAIGNSTAGE/marketing_campaign_dataset.csv
(FILE_FORMAT => 'stage_to_table'));

-- Preview the transformed data
SELECT * FROM VIEW_T1;

-- Create final table to store transformed campaign performance data
CREATE OR REPLACE TABLE MARKPERF(
campaign_id INT,
company VARCHAR(100),
campaign_type VARCHAR(50),
target_gender VARCHAR(20),
target_age VARCHAR(20),
duration INT,
channel_used VARCHAR(50),
conversion_rate NUMBER(10,2),
acquisition_cost NUMBER(10,2),
ROI NUMBER(10,2),
location VARCHAR(50),
language VARCHAR(50),
clicks INT,
impressions INT,
engagement_score INT,
customer_segmentation VARCHAR(50),
campaign_date DATE,
campaign_year INT,
campaign_month VARCHAR(10)
)


-- Insert transformed data from the view into final table
INSERT INTO MARKPERF (
SELECT * FROM VIEW_T1
);

-- -- Confirm data insertion
SELECT * FROM MARKPERF;
