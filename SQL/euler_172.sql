-- it takes almost a minute to run on my laptop

with recursive
gen(n, str, cnt) as
(
	select
		18,
		left(str, i-1) || (substr(str, i, 1)::int + 1)::text || right(str, 10-i),
		1::numeric
	from (select lpad('0', 10, '0') str) t, generate_series(1, 10) i
	union all
	select
		distinct
		n-1,
		left(str, i-1) || (substr(str, i, 1)::int + 1)::text || right(str, 10-i),
		sum(cnt) over (partition by left(str, i-1) || (substr(str, i, 1)::int + 1)::text || right(str, 10-i))
	from gen g
	join generate_series(1, 10) i on substr(str, i, 1)::int < 3
	where n > 1
)
select (sum(cnt)*9/10)::bigint result
from gen
where n = 1;