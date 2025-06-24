with recursive 
build_dict(i, k, v) as
(
	select 1, power(generate_series(0, 9), 2), 1::numeric
	union all
	select distinct i+1 i, k+x*x k, sum(v) over (partition by k+x*x) v
	from build_dict, generate_series(0, 9) x
	where i < 7
),
r(lvl, k, v, x) as
(
	select 1, k, v, k
	from build_dict
	where i = 7 and k > 0
	union all
	select
		r.lvl + 1,
		r.k,
		r.v,
		(select sum(power(substr(r.x::text, i, 1)::int, 2))
		from generate_series(1, length(r.x::text)) i)
    from r
	where r.x not in (1, 89)
)
select sum(v) result
from
(
	select r.*, row_number() over (partition by r.k order by r.lvl desc) rn
	from r	
) t
where rn = 1 and x = 89;