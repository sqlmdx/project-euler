with t as
(
	select i::text||j::text||(i*j)::text txt, i*j n
	from generate_series(1, 99) i,
	     generate_series(i+1, 9999/i) j
	where length(i::text||j::text||(i*j)::text) = 9
),
tt as
(
	select n
	from t, generate_series(1, 9) d
	group by txt, n
	having sum(case when txt ~ d::text then 1 end) = 9
)
select sum(distinct n) result from tt;