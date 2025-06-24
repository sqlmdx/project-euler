with gen(n, value) as
(
	select n, sum(power(substr(n::text, i, 1)::int, 5)) value
	from generate_series(1, 1e6) n,
		 generate_series(1, length(n::text)) i
	group by n
)
select sum(n) - 1 result
from gen
where n = value;