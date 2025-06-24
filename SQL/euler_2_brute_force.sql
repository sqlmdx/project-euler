with recursive
fib(i, tmp, result) as
(
	select 1, 0, 1
	union all
	select i + 1, result, tmp + result
	from fib
	where tmp + result < 4e6
)
select 
	sum(case
		when mod(result, 2) = 0 then result
	    end) result
from fib;