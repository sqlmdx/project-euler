with recursive
gen(lvl, i, str) as
(
	select 1, n, n::text
	from generate_series(0, 9) n
	union all
	select lvl + 1, n, str || '#' || n::text
	from gen, generate_series(i + 1, 9) n
	where lvl <= 6
),
t as
(
	select row_number() over (order by str) i, str
	from gen
	where lvl = 6
),
tt as
(
	select i, str, replace(substr(str, p*2 + 1, 1)::text, '9', '6') d
	from t, generate_series(0, 5) p
	order by i, d
),
ttt as
(
	select i1, i2, count(distinct case when x in ('01','04','06','16','25','36','46','46','18') then x end) c
	from
	(
		select t1.i i1, t2.i i2, least(t1.d, t2.d)||greatest(t1.d, t2.d) x
		from tt t1
		join tt t2 on t2.i > t1.i
	) t
	group by i1, i2
)
select count(*) result from ttt where c = 8;