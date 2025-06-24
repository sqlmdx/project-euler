with recursive
coins(i) as
(
	select i from unnest(array[1, 2, 5, 10, 20, 50, 100, 200]) i
),
gen(lvl, i, n) as
(
	select 1, i, i
	from coins
	union all
	select lvl + 1, c.i, n + c.i
	from gen, coins c
	where c.i >= gen.i
	and n + c.i <= 200
)
select count(*) result
from gen
where n = 200;