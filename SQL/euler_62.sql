with t as
(
	select n, string_agg(substring((n*n*n)::text, i, 1), '' order by substring((n*n*n)::text, i, 1)) o
	from generate_series(1, 10000::numeric) n,
		 generate_series(1, length((n*n*n)::text)) i
	group by n
)
select min(n) result
from t
group by o
having sum(1) = 5
order by 1
limit 1;