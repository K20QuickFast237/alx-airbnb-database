-- Write a query using an INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT user.user_id, role, booking_id, property_id, phone_number, start_date, end_date, total_price, number_of_guests, first_name, last_name, email
FROM user
INNER JOIN booking 
ON user.user_id = booking.user_id;


-- Write a query using a LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT property.property_id, review_id, name, description, price_per_night, rating, comment, is_approved, state_province, country
FROM property
LEFT JOIN review 
ON property.property_id = review.property_id
ORDER BY property_id;


-- Write a query using a FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT user.user_id, role, booking_id, property_id, phone_number, start_date, end_date, total_price, number_of_guests, first_name, last_name, email
FROM user
LEFT JOIN booking 
ON user.user_id = booking.user_id
UNION
SELECT user.user_id, role, booking_id, property_id, phone_number, start_date, end_date, total_price, number_of_guests, first_name, last_name, email
FROM user
RIGHT JOIN booking 
ON user.user_id = booking.user_id
ORDER BY user.user_id;