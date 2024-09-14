-- database:  /Users/simonmaignan/workspace/coursera/SQL_for_data_analysis/db/usda.sqlite3
-- 1. Can you find out the total milk production for 2023? Your manager wants this information for the yearly report.
-- What is the total milk production for 2023?
-- Answer = 91812000000
SELECT
    SUM(Value)
FROM
    milk_production
WHERE
    Year = 2023;

-- 2. Which states had cheese production greater than 100 million in April 2023? The Cheese Department wants to focus their marketing efforts there. 
-- How many states are there?
-- Answer = 2 (55 and 6) or 3 (empty state)
SELECT
    Value,
    Year,
    Period,
    State_ANSI
    -- count(State_ANSI)
FROM
    cheese_production
WHERE
    Value > 100000000
    and Year = 2023
    and Period = 'APR';

-- 3. Your manager wants to know how coffee production has changed over the years. 
-- What is the total value of coffee production for 2011?
-- Answer = 7600000
SELECT
    sum(Value),
    Year
FROM
    coffee_production
WHERE
    Year = 2011
GROUP BY
    Year;

-- 4. There's a meeting with the Honey Council next week. Find the average honey production for 2022 so you're prepared.
-- Answer = 3133275.0
SELECT
    avg(Value)
FROM
    honey_production
WHERE
    Year = 2022;

-- 5. The State Relations team wants a list of all states names with their corresponding ANSI codes. Can you generate that list?
-- What is the State_ANSI code for Florida?
-- Answer = 12
SELECT
    *
FROM
    state_lookup;

-- 6. For a cross-commodity report, can you list all states with their cheese production values, even if they didn't produce any cheese in April of 2023?
-- What is the total for NEW JERSEY?
-- Answer = 4889000
SELECT
    Value,
    Year,
    Period,
    c.State_ANSI,
    sl.State
FROM
    state_lookup sl
    LEFT JOIN cheese_production c ON c.State_ANSI = sl.State_ANSI
WHERE
    Year = 2023
    and Period = 'APR';

-- 7. Can you find the total yogurt production for states in the year 2022 which also have cheese production data from 2023? This will help the Dairy Division in their planning.
-- Answer = 1171095000
SELECT
    sum(y.Value)
    -- y.Value,
    -- y.Year as yogurt_year,
    -- y.State_ANSI
FROM
    yogurt_production y
WHERE
    y.Year = 2022
    and y.State_ANSI IN (
        SELECT
            c.State_ANSI
        from
            cheese_production c
        WHERE
            c.Year = 2023
    )
    -- SELECT
    --     c.State_ANSI
    -- from
    --     cheese_production c
    -- WHERE
    --     c.Year = 2023
;

-- 8. List all states from state_lookup that are missing from milk_production in 2023.
-- How many states are there?
-- Answer = 26
SELECT
    -- Value,
    -- Year,
    -- m.State_ANSI,
    -- sl.State
    count(sl.State)
FROM
    state_lookup sl
    LEFT OUTER JOIN milk_production m ON m.State_ANSI = sl.State_ANSI
    AND m.Year = 2023
WHERE
    Value is NULL
    -- SELECT DISTINCT
    --     State_ANSI
    -- from
    --     milk_production
    -- WHERE
    --     Year = 2023
;

-- 9. List all states with their cheese production values, including states that didn't produce any cheese in April 2023.
-- Did Delaware produce any cheese in April 2023?
-- Answer = No
SELECT
    Value,
    Year,
    Period,
    -- c.State_ANSI,
    sl.State
FROM
    state_lookup sl
    LEFT OUTER JOIN cheese_production c ON c.State_ANSI = sl.State_ANSI
    AND c.Year = 2023
    AND c.Period = 'APR'
    -- WHERE
    -- Year = 2023
    --     -- Value is NULL
    -- sl.State = UPPER('Delaware')
    -- GROUP BY sl.State
;

-- 10. Find the average coffee production for all years where the honey production exceeded 1 million.
-- Answer = 6426666.666666667
SELECT
    avg(Value)
    -- Year
FROM
    coffee_production
WHERE
    Year IN (
        SELECT
            Year
        FROM
            honey_production
        WHERE
            Value > 1000000
    )
    -- SELECT
    --     Value,
    --     -- State_ANSI,
    --     Year
    -- FROM
    --     honey_production
    -- WHERE
    --     Value > 1000000
;
