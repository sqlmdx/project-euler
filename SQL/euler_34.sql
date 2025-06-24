with recursive 
fact(n, f) as
(
	select 0, 1
	union all
	select n + 1, (n + 1) * f
	from fact
	where n < 9
),
parse(n, d) as
(
	select n, substr(n::text, i, 1)::int d
	from generate_series(10, 362880 * 7) n,
		 generate_series(1, length(n::text)) i
)
select sum(n) result
from
(
	select p.n
	from parse p
	join fact f on p.d = f.n
	group by p.n
	having p.n = sum(f)
) t;

-- "optimized" version runs more than 10x faster

with recursive 
fact(n, f) as
(
	select 0, 1
	union all
	select n + 1, (n + 1) * f
	from fact
	where n < 9
),
aux as
(
	select t.n, sum(f) f
	from
	(
		select n, substr(n::text, i, 1)::int d
		from generate_series(1, 9999) n,
			 generate_series(1, length(n::text)) i
	) t
	join fact f on t.d = f.n
	group by t.n
)
select sum(p) result
from generate_series(10, 362880 * 7) p
left join aux a1 on p / 10000 = a1.n
join aux a2 on p % 10000 = a2.n
where p = case when a1.f is not null then a1.f + a2.f + 4 - length(a2.n::text) else a2.f end;
