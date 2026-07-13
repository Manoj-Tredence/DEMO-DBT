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

    {{ get_season('STARTED_AT_TS') }} AS SEASON

    from CTE

)

select * from FINAL

