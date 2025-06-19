with recursive
t as
(
	select type, p
	from	
	(
		select
			i type,
			case i
				when 3 then n*(n+1)/2
				when 4 then n*n
				when 5 then n*(3*n-1)/2
				when 6 then n*(2*n-1)
				when 7 then n*(5*n-3)/2
				when 8 then n*(3*n-2)
			end p
		from generate_series(1, 200) n,
			 generate_series(3, 8) i
	) gen
	where p between 1000 and 9999
),
r(lvl, type, p, str, type_str) as
(
	select 1, type, p, p::text, type::text
	from t
	where type = 3
	union all 
	select lvl + 1, t.type, t.p,
			r.str || '#' || t.p,
			r.type_str || '#' || t.type
	from r
	join t on left(t.p::text, 2) = right(r.p::text, 2)
	where position('#'||t.p||'#' in '#'||r.str||'#') = 0
	  and position('#'||t.type||'#' in '#'||r.type_str||'#') = 0
)
select sum(regexp_substr(str, '[^#]+', 1, i)::int) result
from r, generate_series(1, 6) i
where lvl = 6
and left(str, 2) = right(str, 2);