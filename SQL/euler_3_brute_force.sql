-- generate_series always generates all numbers up to sqrt(n) regardless of what the min divisor is

with recursive
prime_factor(n) as
(
	select 600851475143
	union all
	select
		n / (select coalesce(min(i), n) from (select generate_series(2, sqrt(n)::int) i) t where n % i = 0)
	from prime_factor
	where n > 1
)
select max(d) result from
(
	select n / lag(n) over (order by n) d
	from prime_factor
) t;