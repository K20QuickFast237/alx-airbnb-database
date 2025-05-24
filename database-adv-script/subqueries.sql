-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
SELECT property.property_id, name, avg_rating
FROM property
INNER JOIN (
	SELECT property_id, avg(rating) as avg_rating FROM review 
    GROUP BY property_id
) as rating
ON property.property_id = rating.property_id
WHERE avg_rating >= 4;


-- Write a correlated subquery to find users who have made more than 3 bookings.
SELECT 
	user_id, 
    first_name, 
    email,
    ( 	SELECT count(booking_id)
		From booking
        Where user.user_id = booking.user_id
    ) as booking_qtity
FROM user
HAVING booking_qtity >= 3
ORDER BY booking_qtity DESC;