-- generates 10! rows and takes more than a minute to run on my laptop

with recursive
gen(lvl, str) as
(
	select 1, to_char(n, '00')
	from generate_series(1, 10) n
	union all
	select lvl + 1, str || to_char(n, '00')
	from gen, generate_series(1, 10) n
	where position(to_char(n, '00') || ' ' in str || ' ') = 0
	and lvl < 10
),
parse as
(
	select 
	str,
	substr(str, 2, 2)::int o1,
	substr(str, 5, 2)::int o2,
	substr(str, 8, 2)::int o3,
	substr(str, 11, 2)::int o4,
	substr(str, 14, 2)::int o5,
	substr(str, 17, 2)::int i1,
	substr(str, 20, 2)::int i2,
	substr(str, 23, 2)::int i3,
	substr(str, 26, 2)::int i4,
	substr(str, 29, 2)::int i5
	from gen
	where lvl = 10
),
t as
(
	select 
	str,
	o1::text || i1::text || i2::text ||
	o2::text || i2::text || i3::text ||
	o3::text || i3::text || i4::text ||
	o4::text || i4::text || i5::text ||
	o5::text || i5::text || i1::text solution
	from parse
	where o1 + i1 + i2 = o2 + i2 + i3
	and o1 + i1 + i2 = o3 + i3 + i4
	and o1 + i1 + i2 = o4 + i4 + i5
	and o1 + i1 + i2 = o5 + i5 + i1
	and o1 = least(o1, o2, o3, o4, o5)
)
select max(solution) result
from t
where length(solution) = 16;