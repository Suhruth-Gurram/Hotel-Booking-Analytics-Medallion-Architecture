CREATE OR REFRESH MATERIALIZED VIEW
gold_monthly_bookings AS

SELECT

    DATE_TRUNC('MONTH', check_in_date)
        AS stay_month,

    COUNT(*) AS bookings,

    SUM(
        CASE
            WHEN booking_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    SUM(
        CASE
            WHEN booking_status = 'Completed'
            THEN nights
            ELSE 0
        END
    ) AS room_nights,

    SUM(
        CASE
            WHEN booking_status = 'Completed'
            THEN total_amount - discount_amount
            ELSE 0
        END
    ) AS net_revenue

FROM silver_bookings_clean

GROUP BY
    DATE_TRUNC('MONTH', check_in_date);