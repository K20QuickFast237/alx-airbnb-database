-- --------------------------------------------
-- Tables Creation Script --
-- --------------------------------------------
CREATE TABLE `user` (
    `user_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL UNIQUE,
    `password_hash` VARCHAR(255) NOT NULL COMMENT 'Store a strong hash, not plain text',
    `phone_number` VARCHAR(20) NULL COMMENT 'Phone number can be optional',
    `role` ENUM('guest', 'host', 'admin') NOT NULL DEFAULT 'guest',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX `idx_user_role` (`role`) COMMENT 'Index role if frequently queried'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores user information';

CREATE TABLE `property` (
    `property_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `host_id` INT NOT NULL COMMENT 'Foreign key to the user who is the host',
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT NULL,
    `price_per_night` DECIMAL(10, 2) NOT NULL CHECK (`price_per_night` >= 0),
    `address_line1` VARCHAR(255) NULL,
    `city` VARCHAR(100) NULL,
    `state_province` VARCHAR(100) NULL,
    `postal_code` VARCHAR(20) NULL,
    `country` VARCHAR(50) NULL,
    `latitude` DECIMAL(10, 8) NULL COMMENT 'For geo-location',
    `longitude` DECIMAL(11, 8) NULL COMMENT 'For geo-location',
    `max_guests` TINYINT UNSIGNED NOT NULL DEFAULT 1 CHECK (`max_guests` > 0),
    `bedrooms` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `bathrooms` DECIMAL(3,1) NOT NULL DEFAULT 1.0 COMMENT 'e.g., 1.0, 1.5, 2.0 bathrooms',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_active` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'To soft delete or deactivate listings',
    CONSTRAINT `fk_property_host` FOREIGN KEY (`host_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_property_host_id` (`host_id`),
    INDEX `idx_property_price_per_night` (`price_per_night`),
    INDEX `idx_property_location` (`city`, `country`) COMMENT 'Example for location-based searches'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores property listings';


CREATE TABLE `booking` (
    `booking_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `property_id` INT NOT NULL,
    `user_id` INT NOT NULL COMMENT 'The user who made the booking (guest)',
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL,
    `total_price` DECIMAL(12, 2) NOT NULL CHECK (`total_price` >= 0),
    `status` ENUM('pending_confirmation', 'confirmed', 'cancelled_by_user', 'cancelled_by_host', 'completed', 'no_show') NOT NULL DEFAULT 'pending_confirmation',
    `number_of_guests` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_booking_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT `fk_booking_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_booking_property_id` (`property_id`),
    INDEX `idx_booking_user_id` (`user_id`),
    INDEX `idx_booking_dates` (`start_date`, `end_date`),
    CONSTRAINT `chk_booking_dates` CHECK (`end_date` >= `start_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores booking information';


CREATE TABLE `payment` (
    `payment_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `booking_id` INT NOT NULL,
    `amount` DECIMAL(12, 2) NOT NULL CHECK (`amount` > 0),
    `payment_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `payment_method` ENUM('credit_card', 'paypal', 'stripe', 'bank_transfer', 'cash') NOT NULL,
    `transaction_id` VARCHAR(255) NULL COMMENT 'ID from payment gateway, if applicable',
    `status` ENUM('pending', 'succeeded', 'failed', 'refunded') NOT NULL DEFAULT 'pending',
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    -- UNIQUE KEY `uk_payment_booking_id` (`booking_id`) COMMENT 'Assuming one primary payment per booking; if multiple partial payments, remove this unique key or adjust logic.',
    CONSTRAINT `fk_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `idx_payment_status` (`status`),
    INDEX `idx_payment_method` (`payment_method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores payment details for bookings';


CREATE TABLE `review` (
    `review_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `property_id` INT NOT NULL,
    `user_id` INT NOT NULL COMMENT 'The user who wrote the review',
    -- `booking_id` INT NULL COMMENT 'Optional: Link review to a specific booking for verification',
    `rating` TINYINT UNSIGNED NOT NULL CHECK (`rating` >= 1 AND `rating` <= 5),
    `comment` TEXT NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `is_approved` BOOLEAN NOT NULL DEFAULT TRUE COMMENT 'For moderation purposes',
    CONSTRAINT `fk_review_property` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_review_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    -- CONSTRAINT `fk_review_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`) ON DELETE SET NULL ON UPDATE CASCADE,
    UNIQUE KEY `uk_review_property_user_booking` (`property_id`, `user_id`) COMMENT 'Prevent duplicate reviews for the same property by user.',
    INDEX `idx_review_property_id` (`property_id`),
    INDEX `idx_review_user_id` (`user_id`),
    -- INDEX `idx_review_booking_id` (`booking_id`),
    INDEX `idx_review_rating` (`rating`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores user reviews for properties';


CREATE TABLE `message` (
    `message_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `conversation_id` INT NULL COMMENT 'Optional: To group messages into conversations.',
    `sender_id` INT NOT NULL,
    `recipient_id` INT NOT NULL,
    `message_body` TEXT NOT NULL,
    `sent_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `read_at` TIMESTAMP NULL COMMENT 'Timestamp when the message was read by the recipient',
    CONSTRAINT `fk_message_sender` FOREIGN KEY (`sender_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_message_recipient` FOREIGN KEY (`recipient_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX `idx_message_sender_id` (`sender_id`),
    INDEX `idx_message_recipient_id` (`recipient_id`),
    INDEX `idx_message_conversation_id` (`conversation_id`),
    INDEX `idx_message_sent_at` (`sent_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Stores messages between users';


