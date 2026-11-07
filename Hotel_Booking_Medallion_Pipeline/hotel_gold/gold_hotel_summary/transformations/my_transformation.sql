CREATE OR REFRESH MATERIALIZED VIEW
gold_hotel_summary AS

SELECT

    region,

    city,

    hotel_name,

    COUNT(*) AS bookings,

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
    ) AS net_revenue,

    ROUND(

        SUM(
            CASE
                WHEN booking_status = 'Completed'
                THEN total_amount - discount_amount
                ELSE 0
            END
        )

        /

        NULLIF(
            SUM(
                CASE
                    WHEN booking_status = 'Completed'
                    THEN nights
                    ELSE 0
                END
            ),
            0
        ),

        2

    ) AS avg_daily_rate

FROM silver_bookings_clean

GROUP BY

    region,
    city,
    hotel_name;