with recursive
prime_factor(i, n, d) as
(
	select 2, 600851475143, 0::bigint
	union all
	select
		case
			when n % i = 0 or i * i > n then 2 else i + 1
		end,
		case
			when n % i = 0 then n / i
			when i * i > n then 1
			else n
		end,
		case
			when n % i = 0 then i
			when i * i > n then n
			else 0
		end
	from prime_factor
	where n > 1
)
select max(d) result
from prime_factor;