WITH CTE AS (

    SELECT
        STARTED_AT AS STARTED_AT_RAW,
        TRY_TO_TIMESTAMP(STARTED_AT) AS STARTED_AT_TS
    FROM {{ source('demo', 'BIKE') }}

),

FINAL AS (

    SELECT
        STARTED_AT_RAW,
        STARTED_AT_TS,
        DATE(STARTED_AT_TS) AS DATE_STARTED_AT,
        HOUR(STARTED_AT_TS) AS HOUR_STARTED_AT,

        CASE
            WHEN DAYNAME(STARTED_AT_TS) IN ('Sat', 'Sun')
                THEN 'WEEKEND'
            ELSE 'BUSINESSDAY'
        END AS DAY_TYPE,

        CASE
            WHEN MONTH(STARTED_AT_TS) IN (12, 1, 2)
                THEN 'WINTER'
            WHEN MONTH(STARTED_AT_TS) IN (3, 4, 5)
                THEN 'SUMMER'
            WHEN MONTH(STARTED_AT_TS) IN (6, 7, 8)
                THEN 'RAINY'
            ELSE 'AUTUMN'
        END AS SEASON

    FROM CTE

)

SELECT *
FROM FINAL