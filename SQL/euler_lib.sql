-- table with prime numbers less than 2M
-- it takes almost a minute to run on my laptop
-- for more efficient way to generate this see Problem 10

create table tprime(i, n) as
with recursive 
gen_primes(i, n, flag) as
(
    select 1, 6*i + a n, 1
	from generate_series(1, 2000000 / 6) i,
		 unnest(array[-1, 1]) a
    union all
    select i + 1, n, (sign(n % (6*i - 1)) * sign(n % (6*i + 1)))::int
    from gen_primes
    where (6*i-1)*(6*i-1) <= n and flag > 0
)
select row_number() over (order by n) i, n
from
(
	select n
	from gen_primes
	group by n
	having min(flag) = 1
	union all
	select generate_series(2, 3)
) t
order by n;