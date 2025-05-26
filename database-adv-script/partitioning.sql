-- Implement partitioning on the Booking table based on the start_date column
-- First Try
 PARTITION BY RANGE COLUMNS (start_date) (
    PARTITION p0 VALUES LESS THAN ('2023-01-01'),
    PARTITION p1 VALUES LESS THAN ('2024-01-01'),
    PARTITION p2 VALUES GREATER THAN ('2024-12-31')
);

-- Second Try
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
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
PARTITION BY RANGE COLUMNS (start_date) (
    PARTITION p0 VALUES LESS THAN ('2023-01-01'),
    PARTITION p1 VALUES LESS THAN ('2024-01-01')
);
