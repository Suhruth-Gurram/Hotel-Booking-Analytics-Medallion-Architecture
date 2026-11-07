CREATE OR REFRESH MATERIALIZED VIEW
silver_bookings_clean
(
    CONSTRAINT valid_stay_dates
    EXPECT (check_out_date > check_in_date)
    ON VIOLATION DROP ROW,

    CONSTRAINT valid_room_rate
    EXPECT (room_rate >= 0)
    ON VIOLATION DROP ROW
)
AS

SELECT DISTINCT

    booking_id,

    guest_id,

    booking_date,

    check_in_date,

    check_out_date,

    COALESCE(
        nights,
        DATEDIFF(check_out_date, check_in_date)
    ) AS nights,

    INITCAP(TRIM(hotel_name)) AS hotel_name,

    COALESCE(
        INITCAP(NULLIF(TRIM(city), '')),
        'Unknown'
    ) AS city,

    INITCAP(TRIM(region)) AS region,

    INITCAP(TRIM(room_type)) AS room_type,

    COALESCE(
        INITCAP(NULLIF(TRIM(booking_channel), '')),
        'Unknown'
    ) AS booking_channel,

    guests,

    room_rate,

    COALESCE(
        total_amount,
        DATEDIFF(check_out_date, check_in_date)
        * room_rate
    ) AS total_amount,

    COALESCE(discount_amount, 0) AS discount_amount,

    INITCAP(TRIM(meal_plan)) AS meal_plan,

    INITCAP(TRIM(payment_method)) AS payment_method,

    INITCAP(TRIM(payment_status)) AS payment_status,

    INITCAP(TRIM(booking_status)) AS booking_status,

    guest_rating,

    source_file,

    loaded_at

FROM hospitality_catalog.bookings.bronze_hotel_bookings

WHERE
    check_out_date > check_in_date
    AND room_rate >= 0;