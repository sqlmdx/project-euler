-- Approach is very similar to Problem 92
-- in this case we build a dictionary for the same keys - each key is a sum of squares for all digits
-- the difference is - we store not just a count of numbers but also a total for each key

with recursive 
build_dict(i, k, cnt, total) as
(
	select 1, n*n, 1::numeric, n::numeric
	from generate_series(0, 9) n
	union all
	select distinct
		i+1,
		k+n*n,
		sum(cnt) over (partition by k+n*n),
		sum(cnt*n*power(10, i)::numeric + total) over (partition by k+n*n)
	from build_dict, generate_series(0, 9) n
	where i < 20
)
select sum(total) % 1000000000 result
from build_dict
where i = 20
and power(sqrt(k)::int, 2) = k;