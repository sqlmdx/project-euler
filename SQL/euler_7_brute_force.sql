with recursive
gen_prime(n, cnt) as
(
	select 3, 2
	union
	select
		n + 1,
	    cnt + (select coalesce(min(0), 1) from (select generate_series(2, sqrt(n+1)::int) i) t where (n+1) % i = 0)
	from gen_prime
	where cnt < 10001
)
select max(n) result
from gen_prime;