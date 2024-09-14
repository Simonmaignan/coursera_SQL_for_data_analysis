-- database: /Users/simonmaignan/workspace/coursera/SQL_for_data_analysis/db/usda.sqlite3
-- Use the ▷ button in the top right corner to run the entire file.
-- Find the total milk production for the year 2023.
-- Answer = 91812000000
SELECT
    SUM(Value)
FROM
    milk_production
WHERE
    Year = 2023;

-- Find the highest yogurt production value for the year 2022.
-- Answer = 793256000
SELECT
    max(Value)
FROM
    yogurt_production
WHERE
    Year = 2022;

-- Show coffee production data for the year 2015. What is the total value?
-- Answer = 6600000
SELECT
    Value
FROM
    coffee_production
WHERE
    Year = 2015;

-- Find the average honey production for the year 2022.
-- Answer = 3133275.0
SELECT
    avg(Value)
FROM
    honey_production
WHERE
    Year = 2022;

-- Get the state names with their corresponding ANSI codes from the state_lookup table. What number is Iowa?
-- Answer = 19
SELECT
    State,
    State_ANSI
FROM
    state_lookup
WHERE
    State = UPPER('Iowa');

-- Find the highest yogurt production value for the year 2022.
-- Answer = 793256000
SELECT
    max(Value)
FROM
    yogurt_production
WHERE
    Year = 2022;

-- Find states where both honey and milk were produced in 2022.
-- Did State_ANSI "35" produce both honey and milk in 2022?
-- Answer = No
SELECT DISTINCT
    h.State_ANSI
FROM
    honey_production h
    JOIN milk_production m ON h.State_ANSI = m.State_ANSI
WHERE
    h.Year = 2022
    AND m.Year = 2022;

-- Find the total yogurt production for states that also produced cheese in 2022.
-- Answer = 1171095000
SELECT
    sum(Value)
FROM
    yogurt_production
WHERE
    Year = 2022
    AND State_ANSI IN (
        SELECT
            State_ANSI
        FROM
            cheese_production
        WHERE
            Year = 2022
    );
