## Query analysis result from performance.sql

'-> Nested loop inner join  (cost=7.15 rows=6) (actual time=0.118..0.209 rows=6 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;
-> Nested loop inner join  (cost=5.05 rows=6) (actual time=0.104..0.17 rows=6 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        -> Nested loop inner join  (cost=2.95 rows=6) (actual time=0.0809..0.124 rows=6 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            -> Table scan on payment  (cost=0.85 rows=6) (actual time=0.0535..0.0655 rows=6 loops=1) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            -> Single-row index lookup on booking using PRIMARY (booking_id=payment.booking_id)  (cost=0.267 rows=1) (actual time=0.00923..0.00928 rows=1 loops=6) <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        -> Single-row index lookup on property using PRIMARY (property_id=booking.property_id)  (cost=0.267 rows=1) (actual time=0.00722..0.00723 rows=1 loops=6) <br>
&nbsp;&nbsp;&nbsp;&nbsp;
    -> Single-row index lookup on user using PRIMARY (user_id=booking.user_id)  (cost=0.267 rows=1) (actual time=0.00592..0.00603 rows=1 loops=6)
'