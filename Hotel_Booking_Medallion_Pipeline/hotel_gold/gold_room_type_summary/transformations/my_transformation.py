from pyspark import pipelines as dp


@dp.materialized_view(name="gold_room_type_summary")
def gold_room_type_summary():
    return spark.sql("""
        SELECT
            room_type,
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
                AVG(
                    CASE
                        WHEN booking_status = 'Completed'
                        THEN guest_rating
                    END
                ),
                2
            ) AS avg_rating
        FROM silver_bookings_clean
        GROUP BY room_type
    """)