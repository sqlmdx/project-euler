with t as
(
	select i, power(i*power(100, 100)::numeric, 0.5) / 1 n
	from generate_series(2, 100) i
)
select sum(substr(n::text, j, 1)::int) result
from t, generate_series(1, 100) j
where sqrt(i) != floor(sqrt(i));