-- Implement partitioning on the Booking table based on the start_date column
ALTER TABLE `booking` PARTITION BY RANGE COLUMNS (start_date) (
    PARTITION p0 VALUES LESS THAN ('2023-01-01'),
    PARTITION p1 VALUES LESS THAN ('2024-01-01'),
    PARTITION p2 VALUES GREATER THAN ('2024-12-31')
);

