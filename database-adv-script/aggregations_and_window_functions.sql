-- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
SELECT user.user_id, first_name, email, total_numb_of_booking
FROM user
INNER JOIN (
	SELECT user_id, count(booking_id) as total_numb_of_booking
    FROM booking
    GROUP BY user_id
    order by total_numb_of_booking DESC
) as booking_count
ON user.user_id = booking_count.user_id;


-- Use a window function (ROW_NUMBER, RANK) to rank properties based on the total number of bookings they have received.
SELECT 
	user.user_id, 
    ROW_NUMBER() OVER(PARTITION BY user_id) as position,
    user.first_name, 
    user.email, 
    booking.booking_id,
    COUNT(booking_id) OVER(PARTITION BY user_id) as total_number_of_booking
FROM user
INNER JOIN booking ON user.user_id = booking.user_id
ORDER BY total_number_of_booking DESC;