with t(n, dn) as
(
	select j, sum(i)
	from generate_series(1, 10000 / 2) i,
		 generate_series(i * 2, 10000, i) j
	group by j
)
select sum(t1.n) result
from t t1
join t t2 on t1.dn = t2.n and t1.n = t2.dn and t1.n <> t2.n;