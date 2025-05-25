## Master SQL joins by writing complex queries using different types of joins

**Instructions:**

- Write a query using an _INNER JOIN_ to retrieve all bookings and the respective users who made those bookings.

- Write a query using a _LEFT JOIN_ to retrieve all properties and their reviews, including properties that have no reviews.

- Write a query using a _FULL OUTER JOIN_ to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.

## Write both correlated and non-correlated subqueries.

**Instructions:**

- Write a query to find all properties where the average rating is greater than 4.0 using a subquery.
- Write a correlated subquery to find users who have made more than 3 bookings.

## Use SQL aggregation and window functions to analyze data.

**Instructions:**

- Write a query to find the total number of bookings made by each user, using the COUNT function and GROUP BY clause.
- Use a window function (_ROW_NUMBER_, _RANK_) to rank properties based on the total number of bookings they have received.

## Identify and create indexes to improve query performance.

**Instructions:**

- Identify high-usage columns in your _User_, _Booking_, and _Property_ tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).
- Write SQL CREATE INDEX commands to create appropriate indexes for those columns and save them on database_index.sql
- Measure the query performance before and after adding indexes using _EXPLAIN_ or _ANALYZE_.
