-- A/B TESTING & CONVERSION OPTIMIZATION

/* DATABASE SETUP
Tables loaded from Python/Pandas into SQLite:
- users
- experiment
- behavior
- events

SQLite connection created in Python notebook:
conn = sqlite3.connect("ab_test.db")                */

-- 1. OVERALL CONVERSION RATE

SELECT 
    variant,
    COUNT(*) AS users,
    SUM(converted) AS conversions,
    ROUND(SUM(converted) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM experiment
GROUP BY variant;

-- 2. CONVERSION BY DEVICE

SELECT 
    u.device,
    e.variant,
    COUNT(*) AS users,
    ROUND(SUM(e.converted) * 1.0 / COUNT(*), 4) AS conversion_rate
FROM experiment e
JOIN users u 
    ON e.user_id = u.user_id
GROUP BY u.device, e.variant;

-- 3. CREATE CONSOLIDATED ANALYTICAL VIEW

DROP VIEW IF EXISTS full_data;

CREATE VIEW full_data AS
SELECT 
    u.user_id,
    u.device,
    u.previous_customer,
    e.variant,
    e.converted,
    b.session_time,
    b.pages_viewed
FROM users u
JOIN experiment e
    ON u.user_id = e.user_id
JOIN behavior b
    ON u.user_id = b.user_id;

-- 4. FUNNEL SUMMARY

SELECT 
    event AS step,
    COUNT(DISTINCT user_id) AS users,
    ROUND(
        COUNT(DISTINCT user_id) * 1.0 /
        (
            SELECT COUNT(DISTINCT user_id)
            FROM events
            WHERE event = 'landing'
        ),
        4
    ) AS conversion_rate
FROM events
GROUP BY event
ORDER BY 
    CASE event
        WHEN 'landing' THEN 1
        WHEN 'start' THEN 2
        WHEN 'form' THEN 3
        WHEN 'submit' THEN 4
    END;

-- 5. FUNNEL ANALYSIS BY VARIANT

WITH base AS (
    SELECT 
        variant,
        COUNT(DISTINCT user_id) AS total_users
    FROM experiment
    GROUP BY variant
)
SELECT 
    e.variant,
    ev.event AS step,
    COUNT(DISTINCT ev.user_id) AS users,
    ROUND(
        COUNT(DISTINCT ev.user_id) * 1.0 / b.total_users,
        4
    ) AS conversion_rate
FROM events ev
JOIN experiment e
    ON ev.user_id = e.user_id
JOIN base b
    ON e.variant = b.variant
GROUP BY e.variant, ev.event
ORDER BY 
    e.variant,
    CASE ev.event
        WHEN 'landing' THEN 1
        WHEN 'start' THEN 2
        WHEN 'form' THEN 3
        WHEN 'submit' THEN 4
    END;

-- 6. GROUP SIZE VALIDATION

SELECT 
    variant AS Variant,
    COUNT(*) AS Users
FROM experiment
GROUP BY variant;

-- 7. DEVICE DISTRIBUTION VALIDATION

SELECT 
    variant,
    device,
    COUNT(*) AS users
FROM full_data
GROUP BY variant, device;