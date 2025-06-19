with recursive
gen(lvl, n, prod, txt) as
(
	select 1, 1, 2*1+1, '1'
	union all
	select lvl + 1, i, prod * (i*2+1), txt || ',' || i::text
	from gen g
	join generate_series(1, 6) i on g.n <= i
	where (prod + 1)/2 < 4000000
),
t as
(
	select lvl, txt, row_number() over (partition by lvl order by prod) rn
	from gen
	where (prod + 1)/2 > 4000000
),
tt as
(
	select txt, j, regexp_substr(txt, '[^,]+', 1, lvl - j + 1)::int e, tp.n
	from t, generate_series(1, lvl) j, tprime tp
	where rn = 1
	and j = tp.i
)
select round(power(2,(sum(log(2, power(n::numeric, e)))))) result
from tt
group by txt
order by result
limit 1;