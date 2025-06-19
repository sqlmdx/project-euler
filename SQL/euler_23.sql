with t(n, dn) as
(
	select j, sum(i)
	from generate_series(1, 28124 / 2) i,
		 generate_series(i * 2, 28124, i) j
	group by j
	having sum(i) > j
)
select sum(i) result
from
(
	select generate_series(1, 28124) i
	except
	select distinct t1.n + t2.n
	from t t1
	join t t2 on t1.n <= t2.n and t1.n + t2.n <= 28124
) t;