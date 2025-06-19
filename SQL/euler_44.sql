with recursive
gen(lvl, n, flag) as
(
	select 1, 1, null::int
	union all
	select lvl, n, 
	(
		select n - n0
		from
		(select i*(3*i-1)/2 n0 from generate_series(1, lvl - 1) i) t
		where (1 + sqrt(1+24*(n + n0))) / 6 = floor((1 + sqrt(1+24*(n + n0))) / 6)
		  and (1 + sqrt(1+24*(n - n0))) / 6 = floor((1 + sqrt(1+24*(n - n0))) / 6)
	)	
	from (select lvl + 1 lvl , (lvl + 1)*(3*lvl + 2)/2 n, flag from gen) g
	where flag is null
)
select flag result
from gen
where flag is not null;