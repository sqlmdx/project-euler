with recursive 
fib(lvl, tmp, result) as
(
	select 1, 0::numeric, 1::numeric
	union all
	select lvl + 1, result, tmp + result
	from fib
	where log(result) + 1 < 1000
)
select max(lvl) result 
from fib;