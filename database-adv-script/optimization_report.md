## Query analysis result from performance.sql

'-> Nested loop inner join (cost=6.55 rows=5.14) (actual time=0.0733..0.154 rows=4 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;
-> Nested loop inner join (cost=4.75 rows=5.14) (actual time=0.0593..0.125 rows=4 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-> Nested loop inner join (cost=2.95 rows=5.14) (actual time=0.0485..0.0876 rows=4 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-> Table scan on payment (cost=0.85 rows=6) (actual time=0.031..0.0389 rows=6 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-> Filter: (((booking.user_id = 1) or (booking.user_id = 2) or (booking.user_id = 3)) and (booking.property_id >= 1)) (cost=0.264 rows=0.857) (actual time=0.00753..0.00765 rows=0.667 loops=6) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-> Single-row index lookup on booking using PRIMARY (booking_id=payment.booking_id) (cost=0.264 rows=1) (actual time=0.0065..0.00658 rows=1 loops=6) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
-> Single-row index lookup on user using PRIMARY (user_id=booking.user_id) (cost=0.269 rows=1) (actual time=0.0088..0.00888 rows=1 loops=4) <br>
&nbsp;&nbsp;&nbsp;&nbsp;
-> Single-row index lookup on property using PRIMARY (property_id=booking.property_id) (cost=0.269 rows=1) (actual time=0.00667..0.00675 rows=1 loops=4)
'
