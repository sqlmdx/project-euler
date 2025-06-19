with t as
(
	select generate_series(2, 2000000) n
	except
	select i*j
	from generate_series(2, 2000000/2) i,
		 generate_series(i, 2000000/i) j
)
select sum(n) result
from t;