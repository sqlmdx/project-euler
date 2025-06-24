-- The sum of the members of a finite arithmetic progression

with t0 as
(select (1000 - 1) / 3 qty3, (1000 - 1) / 5 qty5, (1000 - 1) / 15 qty15)
select
	qty3 * (1 + qty3) / 2 * 3 +
	qty5 * (1 + qty5) / 2 * 5 -
	qty15 * (1 + qty15) / 2 * 15
from t0;