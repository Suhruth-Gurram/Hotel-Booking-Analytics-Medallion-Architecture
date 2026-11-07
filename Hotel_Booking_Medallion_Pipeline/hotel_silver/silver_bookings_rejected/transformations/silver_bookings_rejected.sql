CREATE OR REFRESH MATERIALIZED VIEW
silver_bookings_rejected
AS

SELECT

    *,

    CASE

        WHEN check_out_date <= check_in_date
             AND room_rate < 0
        THEN 'Invalid dates and negative room rate'

        WHEN check_out_date <= check_in_date
        THEN 'Check-out is not after check-in'

        WHEN room_rate < 0
        THEN 'Negative room rate'

    END AS reject_reason

FROM hospitality_catalog.bookings.bronze_hotel_bookings

WHERE

    check_out_date <= check_in_date

    OR room_rate < 0;