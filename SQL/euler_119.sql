with t as
(
	select i, e, power(i::numeric, e)::numeric(100) n
	from generate_series(2, 99) i,
		 generate_series(2, 50) e
	order by 3 desc
),
tt as
(
	select n, row_number() over (order by n) rn
	from t
	where i = (select sum(substr((n::text), j, 1)::int) from generate_series(1, length(n::text)) j)
)
-- 2^50 > answer hence we considered all combinations i^e below the answer
select n result from tt where rn = 30;