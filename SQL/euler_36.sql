with t(d, b) as
(
	select i::text, ltrim(i::bit(20)::text, '0')
	from generate_series(1, 1000000) i
)
select sum(d::int) result
from t
where d = reverse(d) and b = reverse(b);