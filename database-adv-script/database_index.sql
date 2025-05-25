-- Query performance before adding indexes
EXPLAIN ANALYZE SELECT user.user_id, role, booking_id, property_id, phone_number, start_date, end_date, total_price, number_of_guests, first_name, last_name, email
FROM user
INNER JOIN booking 
ON user.user_id = booking.user_id;


-- Adding indexes
CREATE INDEX name_index ON user (first_name, last_name);
CREATE INDEX email_index ON user (email);
CREATE INDEX phone_number_index ON user (phone_number);
CREATE INDEX role_index ON user (role);

CREATE INDEX host_id_index ON property (host_id);
CREATE INDEX price_index ON property (price_per_night);
CREATE INDEX location_index ON property (city, country);


CREATE INDEX property_id_index ON booking (booking_id);
CREATE INDEX user_id_index ON booking (user_id);
CREATE INDEX date_index ON booking (start_date, end_date);
CREATE INDEX status_index ON booking (status);


-- Query performance after adding indexes
EXPLAIN ANALYZE SELECT user.user_id, role, booking_id, property_id, phone_number, start_date, end_date, total_price, number_of_guests, first_name, last_name, email
FROM user
INNER JOIN booking 
ON user.user_id = booking.user_id
WHERE user_id = 1 OR user_id = 2 OR user_id = 3;