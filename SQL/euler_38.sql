with t as
(
	select n, i, string_agg((i*j)::text, '' order by j) txt
	from generate_series(2, 9) n,
		 generate_series(power(10, 9/n-1)::int, power(10, 9/n)::int) i,
		 generate_series(1, n) j
	group by n, i
)
select txt result
from t, generate_series(1, 9) d
where length(txt) = 9
group by txt
having sum(case when txt ~ d::text then 1 end) = 9
order by 1 desc
limit 1;