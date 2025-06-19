-- it takes almost two minutes to run on my laptop

with recursive
gen_mask(lvl, mask) as
(
	select 1, generate_series(0, 1)::text
	union all
	select lvl + 1, generate_series(0, 1)::text || mask
	from gen_mask g
	where lvl < 5
),
mask as
(
	select *, 
			replace(replace(regexp_replace(mask, '1', '(.)'), '0', '.'), '1', '\1') pattern,
			replace(replace(mask, '0', '(.)'), '1', '.') sub
	from (select lvl + 1 lvl, mask || '0' mask from gen_mask where mask ~ '1') m
),
t as
(
	select *, regexp_replace(p.n::text, m.sub, '\1\2\3\4\5\6') reduced
	from tprime p
	join mask m on p.n::text ~ m.pattern
	where length(n::text) = lvl
)
select min(n) result
from t
group by mask, reduced
order by count(*) desc
limit 1;