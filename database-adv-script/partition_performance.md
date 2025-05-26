## A brief report on the partitioning result

### First Try:
When I tried partitioning on the booking table with the query in *patitioning.sql* file, I got the result: <br>
**Error Code: 1506**. Foreign keys are not yet supported in conjunction with partitioning. <br>
I'm using a MySQL database.

### Second Try:
At the second try I God the expected response: <br>
**Error Code: 1050.** Table 'booking' already exists
