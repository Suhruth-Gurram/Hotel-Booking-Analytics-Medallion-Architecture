CREATE OR REFRESH MATERIALIZED VIEW
gold_channel_summary AS

SELECT

    booking_channel,

    COUNT(*) AS bookings,

    SUM(
        CASE
            WHEN booking_status = 'Cancelled'
            THEN 1
            ELSE 0
        END
    ) AS cancelled_bookings,

    ROUND(

        SUM(
            CASE
                WHEN booking_status = 'Cancelled'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),

        2

    ) AS cancellation_rate_pct,

    SUM(
        CASE
            WHEN booking_status = 'Completed'
            THEN total_amount - discount_amount
            ELSE 0
        END
    ) AS net_revenue

FROM silver_bookings_clean

GROUP BY booking_channel;