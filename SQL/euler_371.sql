with recursive
gen(lvl, cnt_500, cnt_no500) as
(
	select 499, 0::numeric, 0::numeric
	union all
	select lvl - 1,
			cnt_500,
			(1000 + (998 - 2 * lvl) * cnt_no500 + cnt_500) / (999 - lvl) cnt_no500
	from
	(select lvl, (1000 + (998 - 2 * lvl) * cnt_500) / (999 - lvl) cnt_500, cnt_no500 from gen) g
	where lvl >= 0
)
select cnt_no500::numeric(10,8)
from gen
order by lvl
limit 1;