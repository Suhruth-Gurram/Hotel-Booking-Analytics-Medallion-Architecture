CREATE OR REFRESH MATERIALIZED VIEW
gold_data_quality AS

WITH bronze_quality AS (

    SELECT

        COUNT(*) AS bronze_rows,

        COUNT(*) -
        COUNT(DISTINCT booking_id)
        AS duplicate_rows,

        SUM(
            CASE
                WHEN check_out_date <= check_in_date
                THEN 1 ELSE 0
            END
        ) AS invalid_date_rows,

        SUM(
            CASE
                WHEN room_rate < 0
                THEN 1 ELSE 0
            END
        ) AS negative_rate_rows,

        SUM(
            CASE
                WHEN city IS NULL OR TRIM(city) = ''
                THEN 1 ELSE 0
            END
        ) AS missing_city_rows,

        SUM(
            CASE
                WHEN booking_channel IS NULL
                  OR TRIM(booking_channel) = ''
                THEN 1 ELSE 0
            END
        ) AS missing_channel_rows,

        SUM(
            CASE
                WHEN nights IS NULL
                THEN 1 ELSE 0
            END
        ) AS missing_nights_rows,

        SUM(
            CASE
                WHEN total_amount IS NULL
                THEN 1 ELSE 0
            END
        ) AS missing_amount_rows

    FROM bronze_hotel_bookings

),

clean_quality AS (

    SELECT COUNT(*) AS clean_rows
    FROM silver_bookings_clean

),

rejected_quality AS (

    SELECT COUNT(*) AS rejected_rows
    FROM silver_bookings_rejected

)

SELECT

    b.bronze_rows,

    b.duplicate_rows,

    b.invalid_date_rows,

    b.negative_rate_rows,

    b.missing_city_rows,

    b.missing_channel_rows,

    b.missing_nights_rows,

    b.missing_amount_rows,

    c.clean_rows,

    r.rejected_rows,

    (
        b.bronze_rows =
        c.clean_rows + r.rejected_rows + b.duplicate_rows
    ) AS reconciliation_passed

FROM bronze_quality b

CROSS JOIN clean_quality c

CROSS JOIN rejected_quality r;