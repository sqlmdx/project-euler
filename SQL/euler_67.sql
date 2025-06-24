/*
create table triangle(id int generated always as identity, str text);

copy triangle(str)
from '0067_triangle.txt';
*/

with recursive
t as
(
	select id level, i, value
	from triangle, unnest(('{'||replace(str,' ',',')||'}')::int[]) with ordinality as tree(value, i)
),
r(level, i, x) as
(
	select level, i, greatest(value, lead(value) over (order by i)) x
	from t
	where level = (select max(level) from t)
	union all
	select t.level, t.i, rr.x + t.value
	from (select level, i, greatest(x, lead(x) over (order by i)) x from r) rr
	join t on rr.level - 1 = t.level and rr.i = t.i
)
select x result
from r
where level = 1;