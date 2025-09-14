SELECT * FROM corona_dataset.`corona virus dataset`;

-- Columns: Province, Country/Region, Latitude, Longitude, Date, Confirmed, Deaths, Recovered
-- Q1. Write a code to check NULL values
SELECT 
    COUNT(*) - COUNT(Province) AS Province_nulls,
    COUNT(*) - COUNT(`Country/Region`) AS Country_Region_nulls,
    COUNT(*) - COUNT(Latitude) AS Latitude_nulls,
    COUNT(*) - COUNT(Longitude) AS Longitude_nulls,
    COUNT(*) - COUNT(Date) AS Date_nulls,
    COUNT(*) - COUNT(Confirmed) AS Confirmed_nulls,
    COUNT(*) - COUNT(Deaths) AS Deaths_nulls,
    COUNT(*) - COUNT(Recovered) AS Recovered_nulls
FROM `corona virus dataset`;


-- Q3. Check total number of rows
SELECT COUNT(*) AS total_rows 
FROM `corona virus dataset`;

-- Q4. Check what is start_date and end_date
SELECT 
    MIN(Date) AS start_date,
    MAX(Date) AS end_date
FROM `corona virus dataset`;

-- Q5. Number of months present in dataset
SELECT COUNT(DISTINCT DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m')) AS total_months
FROM `corona virus dataset`;

-- Q7. Find most frequent value for confirmed, deaths, recovered each month
SELECT 
    month_year,
    confirmed_mode,
    deaths_mode,
    recovered_mode
FROM (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m') AS month_year,
        Confirmed AS confirmed_mode,
        Deaths AS deaths_mode,
        Recovered AS recovered_mode,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'), Confirmed 
            ORDER BY COUNT(*) DESC
        ) AS conf_rank,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'), Deaths 
            ORDER BY COUNT(*) DESC
        ) AS death_rank,
        ROW_NUMBER() OVER (
            PARTITION BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'), Recovered 
            ORDER BY COUNT(*) DESC
        ) AS rec_rank
    FROM corona_dataset
    GROUP BY DATE_FORMAT(STR_TO_DATE(Date, '%m/%d/%Y'), '%Y-%m'), Confirmed, Deaths, Recovered
) ranked
WHERE conf_rank = 1 AND death_rank = 1 AND rec_rank = 1
ORDER BY month_year;



















