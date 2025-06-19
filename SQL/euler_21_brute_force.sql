with t(n, dn) as
(
	select n, 1 + (select coalesce(sum(i + n / i), 0) from (select generate_series(2, sqrt(n)::int) i) t where n % i = 0)
	from generate_series(1, 10000) n
)
select sum(t1.n) result
from t t1
join t t2 on t1.dn = t2.n and t1.n = t2.dn and t1.n <> t2.n;