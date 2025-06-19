-- generates 10! rows and takes more than a minute to run on my laptop
-- in order to get millionth permutation we need to generate all of them first and then order

with recursive
gen(lvl, str) as
(
	select 1, n::text
	from generate_series(0, 9) n
	union all
	select lvl + 1, str || n::text
	from gen, generate_series(0, 9) n
	where position(n::text in str) = 0
)
select str result
from
(
	select *
	from gen
	where lvl = 10
	order by str
	limit 1000000
) t
order by str desc
limit 1;