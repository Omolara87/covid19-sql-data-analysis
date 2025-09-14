-- COVID-19 SQL Analysis (single file)
-- Table: `corona virus dataset`
-- Columns: Province, Country/Region, Latitude, Longitude, Date, Confirmed, Deaths, Recovered

-- Q1) Check NULLs for each column
SELECT 
    COUNT(*) - COUNT(Province)           AS Province_nulls,
    COUNT(*) - COUNT(`Country/Region`)   AS Country_Region_nulls,
    COUNT(*) - COUNT(Latitude)           AS Latitude_nulls,
    COUNT(*) - COUNT(Longitude)          AS Longitude_nulls,
    COUNT(*) - COUNT(Date)               AS Date_nulls,
    COUNT(*) - COUNT(Confirmed)          AS Confirmed_nulls,
    COUNT(*) - COUNT(Deaths)             AS Deaths_nulls,
    COUNT(*) - COUNT(Recovered)          AS Recovered_nulls
FROM `corona virus dataset`;

-- Q2) (Optional) Replace NULLs with defaults
-- Run only if you want to modify the table values
-- UPDATE `corona virus dataset`
-- SET 
--   Province         = COALESCE(Province, 'Unknown'),
--   `Country/Region` = COALESCE(`Country/Region`, 'Unknown'),
--   Latitude         = COALESCE(Latitude, 0),
--   Longitude        = COALESCE(Longitude, 0),
--   Confirmed        = COALESCE(Confirmed, 0),
--   Deaths           = COALESCE(Deaths, 0),
--   Recovered        = COALESCE(Recovered, 0);

-- Q3) Total number of rows
SELECT COUNT(*) AS total_rows
FROM `corona virus dataset`;

-- Q4) Dataset start and end dates (if Date is text like mm/dd/yyyy)
SELECT 
    MIN(STR_TO_DATE(Date, '%m/%d/%Y')) AS start_date,
    MAX(STR_TO_DATE(Date, '%m/%d/%Y')) AS end_date
FROM `corona virus dataset`;

-- Q5) Number of distinct months in the dataset
SELECT COUNT(DISTINCT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) AS total_months
FROM `corona virus dataset`;

-- Q6) Monthly averages (confirmed, deaths, recovered)
SELECT 
    DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS month_year,
    AVG(Confirmed) AS avg_confirmed,
    AVG(Deaths)    AS avg_deaths,
    AVG(Recovered) AS avg_recovered
FROM `corona virus dataset`
GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')
ORDER BY month_year;

-- (Bonus) Top regions by total confirmed
SELECT 
    `Country/Region` AS region,
    SUM(Confirmed)   AS total_confirmed
FROM `corona virus dataset`
GROUP BY `Country/Region`
ORDER BY total_confirmed DESC
LIMIT 10;
