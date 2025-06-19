-- it takes more than a minute to run on my laptop

with recursive
collatz(lvl, n, orig) as
(
	select 1, i::bigint, i from generate_series(2, 1000000) i
	union all
	select
		-- if we ended up in the same n coming from different orig
		-- then we take only min orig to reduce recordset on next iteration
		-- this makes elapsed time about twice faster
		distinct
		lvl + 1,
	    case when n % 2 > 0 then 3 * n + 1 else n / 2 end,
	    min(orig) over (partition by n)
	from collatz
	where n != 1
)
select orig result
from collatz c
order by lvl desc
limit 1;