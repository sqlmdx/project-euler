with recursive
t66(i, x) as
(
	select 1, generate_series(1, 6) x
	union all
	select i+1, t66.x + xx
	from t66, generate_series(1, 6) xx
	where i < 6
),
t49(i, x) as
(
	select 1, generate_series(1, 4) x
	union all
	select i+1, t49.x + xx
	from t49, generate_series(1, 4) xx
	where i < 9
)
select round(sum(t49.cnt * t66.cnt) / (power(4, 9) * power(6, 6))::numeric, 7)
from
(select x, count(*) cnt from t66 where i = 6 group by x) t66,
(select x, count(*) cnt from t49 where i = 9 group by x) t49
where t49.x > t66.x;