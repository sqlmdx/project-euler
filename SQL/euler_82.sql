with recursive
t as
(
	select id i, j, n
	from matrix, unnest(('{'||str||'}')::int[]) with ordinality as row(n, j)
),
r as 
(
	select 1 lvl, t.i, t.j, t.n::bigint
	from t
	where j = 1
	union all
	select distinct lvl, t.i, t.j, min(tmp) over (partition by t.i, t.j) n
	from
	(
		select lvl + 1 lvl, t.i, t.j, r.n + sum(ts.n) over (partition by r.i, t.i) tmp
		from r
		join t on r.j + 1 = t.j
		join t ts on r.j + 1 = ts.j and (ts.i <= t.i and ts.i >= r.i or ts.i >= t.i and ts.i <= r.i)
	) t
)
select n result
from r
order by j desc, n
limit 1;