with t0 as
(select generate_series(1, 1000 - 1) i)
select
	sum(case
			when mod(i, 3) = 0 then i
			when mod(i, 5) = 0 then i
		end) result
from t0;