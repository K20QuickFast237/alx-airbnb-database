-- Initial query that retrieves all bookings along with the user details, property details, and payment details
SELECT *
FROM booking
INNER JOIN user ON booking.user_id = user.user_id
INNER JOIN property ON booking.property_id = property.property_id
INNER JOIN payment ON booking.booking_id = payment.booking_id;

-- Query Performance Analysis
EXPLAIN ANALYZE SELECT *
FROM booking
INNER JOIN user ON booking.user_id = user.user_id
INNER JOIN property ON booking.property_id = property.property_id
INNER JOIN payment ON booking.booking_id = payment.booking_id;

-- Refactor the query to reduce execution time,
