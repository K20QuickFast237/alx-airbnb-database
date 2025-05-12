-- Seeding data for the 'user' table
-- Passwords are simple bcrypt hashes for 'password123'
INSERT INTO `user` (`first_name`, `last_name`, `email`, `password_hash`, `phone_number`, `role`) VALUES
('Alice', 'Smith', 'alice.smith@example.com', '$2y$10$abcde12345abcde12345.f.somehashforalice123', '123-456-7890', 'host'), -- User 1: Host
('Bob', 'Johnson', 'bob.johnson@example.com', '$2y$10$fghij67890fghij67890.j.somehashforbob456', NULL, 'guest'), -- User 2: Guest
('Charlie', 'Williams', 'charlie.w@example.com', '$2y$10$klmno12345klmno12345.k.somehashforcharlie789', '987-654-3210', 'guest'), -- User 3: Guest
('Diana', 'Brown', 'diana.b@example.com', '$2y$10$pqrst67890pqrst67890.l.somehashfordiana012', '555-123-4567', 'host'), -- User 4: Host
('Ethan', 'Davis', 'ethan.d@example.com', '$2y$10$uvwxy12345uvwxy12345.m.somehashforethan345', NULL, 'guest'), -- User 5: Guest
('Fiona', 'Miller', 'fiona.m@example.com', '$2y$10$zabcd67890zabcd67890.n.somehashforfiona678', '111-222-3333', 'admin'); -- User 6: Admin


-- Seeding data for the 'property' table
-- Ensure host_id corresponds to users with role 'host' (user_id 1 and 4)
INSERT INTO `property` (`host_id`, `name`, `description`, `price_per_night`, `address_line1`, `city`, `state_province`, `postal_code`, `country`, `latitude`, `longitude`, `max_guests`, `bedrooms`, `bathrooms`, `is_active`) VALUES
(1, 'Cozy Downtown Apartment', 'A comfortable apartment in the heart of the city. Perfect for exploring!', 120.50, '123 Main St', 'Metropolis', 'NY', '10001', 'USA', 40.7128, -74.0060, 4, 2, 1.0, TRUE), -- Property 1 by Host 1
(1, 'Sunny Beach House', 'Escape to this beautiful house just steps from the beach.', 250.00, '456 Ocean Ave', 'Coastal City', 'CA', '90210', 'USA', 34.0522, -118.2437, 8, 4, 2.5, TRUE), -- Property 2 by Host 1
(4, 'Mountain Cabin Retreat', 'Get away from it all in this secluded cabin with stunning views.', 180.00, '789 Forest Rd', 'Hill Valley', 'CO', '80301', 'USA', 40.0150, -105.2705, 6, 3, 2.0, TRUE), -- Property 3 by Host 4
(4, 'Urban Studio Loft', 'Stylish studio in the trendy arts district.', 90.00, '101 Gallery Way', 'Metropolis', 'NY', '10005', 'USA', 40.7000, -74.0100, 2, 1, 1.0, FALSE); -- Property 4 by Host 4 (Inactive)


-- Seeding data for the 'booking' table
-- Ensure user_id corresponds to users with role 'guest' (user_id 2, 3, 5)
-- Ensure property_id corresponds to existing properties
-- Calculate total_price (nights * price_per_night)
INSERT INTO `booking` (`property_id`, `user_id`, `start_date`, `end_date`, `total_price`, `status`, `number_of_guests`) VALUES
(1, 2, '2025-06-10', '2025-06-15', 723.00, 'confirmed', 2), -- Booking 1: User 2 at Property 1 (6 nights * 120.50)
(2, 3, '2025-07-01', '2025-07-07', 1750.00, 'completed', 4), -- Booking 2: User 3 at Property 2 (7 nights * 250.00)
(3, 5, '2025-08-20', '2025-08-25', 1080.00, 'pending_confirmation', 3), -- Booking 3: User 5 at Property 3 (6 nights * 180.00)
(1, 3, '2025-05-01', '2025-05-05', 602.50, 'completed', 1), -- Booking 4: User 3 at Property 1 (5 nights * 120.50) - Past booking
(2, 2, '2024-12-18', '2024-12-20', 750.00, 'completed', 5), -- Booking 5: User 2 at Property 2 (3 nights * 250.00) - Past booking
(3, 5, '2025-09-10', '2025-09-10', 180.00, 'confirmed', 1), -- Booking 6: User 5 at Property 3 (1 night)
(1, 2, '2025-06-20', '2025-06-22', 361.50, 'cancelled_by_user', 2); -- Booking 7: User 2 at Property 1 (cancelled)


-- Seeding data for the 'payment' table
-- Ensure booking_id corresponds to existing bookings. Link to confirmed/completed bookings.
INSERT INTO `payment` (`booking_id`, `amount`, `payment_method`, `transaction_id`, `status`) VALUES
(1, 723.00, 'credit_card', 'txn_abc123', 'succeeded'), -- Payment for Booking 1
(2, 1750.00, 'paypal', 'ppl_xyz456', 'succeeded'), -- Payment for Booking 2
(4, 602.50, 'stripe', 'str_def789', 'succeeded'), -- Payment for Booking 4
(5, 750.00, 'bank_transfer', NULL, 'succeeded'), -- Payment for Booking 5
(6, 180.00, 'credit_card', 'txn_ghi012', 'succeeded'), -- Payment for Booking 6
(3, 1080.00, 'paypal', 'ppl_mno345', 'pending'); -- Payment for Booking 3 (pending confirmation)


-- Seeding data for the 'review' table
-- Ensure property_id and user_id correspond to existing entries.
-- Users writing reviews should ideally be guests who booked, but the schema doesn't strictly enforce this without booking_id link.
-- Ratings between 1 and 5.
INSERT INTO `review` (`property_id`, `user_id`, `rating`, `comment`) VALUES
(1, 2, 5, 'Great location and very clean apartment! Highly recommended.'), -- Review 1: User 2 for Property 1
(2, 3, 4, 'Lovely beach house, perfect for a family getaway. Minor issue with WiFi.'), -- Review 2: User 3 for Property 2
(3, 5, 5, 'Amazing views and a truly relaxing cabin experience.'), -- Review 3: User 5 for Property 3
(1, 3, 4, 'Good value for money, host was responsive.'), -- Review 4: User 3 for Property 1
(2, 2, 5, 'Fantastic stay, the kids loved being so close to the beach!'), -- Review 5: User 2 for Property 2
(1, 5, 3, 'Apartment was okay, but a bit noisy at night.'); -- Review 6: User 5 for Property 1


-- Seeding data for the 'message' table
-- Ensure sender_id and recipient_id correspond to existing users.
-- conversation_id is optional, use null or group some messages.
INSERT INTO `message` (`conversation_id`, `sender_id`, `recipient_id`, `message_body`, `read_at`) VALUES
(1, 2, 1, 'Hi Alice, is the apartment available in June?', NOW()), -- Message 1 (Conv 1): User 2 to User 1
(1, 1, 2, 'Hi Bob, yes, it is available for most of June. What dates are you thinking?', NOW()), -- Message 2 (Conv 1): User 1 to User 2
(1, 2, 1, 'Great! I was looking at June 10th to 15th.', NOW()), -- Message 3 (Conv 1): User 2 to User 1
(2, 3, 4, 'Hello Diana, is the cabin pet-friendly?', NULL), -- Message 4 (Conv 2): User 3 to User 4
(3, 5, 1, 'Hi Alice, I just booked your apartment for August.', NOW()), -- Message 5 (Conv 3): User 5 to User 1
(3, 1, 5, 'Thanks Ethan! Looking forward to hosting you.', NULL), -- Message 6 (Conv 3): User 1 to User 5
(4, 6, 1, 'Checking in on recent host activity.', NOW()), -- Message 7 (Conv 4): User 6 (Admin) to User 1
(4, 6, 4, 'Checking in on recent host activity.', NOW()); -- Message 8 (Conv 4): User 6 (Admin) to User 4
