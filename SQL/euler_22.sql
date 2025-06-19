/*
create table names(name text[]);

insert into names
values ('{<copy from file 0022_names.txt>}');
*/

with
t(str) as
(
	select u name
	from names, unnest(name) u
),
values as
(
	select str, sum(ascii(substr(str, i, 1))-ascii('A')+1) value
	from t, generate_series(1, length(str)) i
	group by str
)
select sum(x) result
from (select row_number() over (order by str) * value x from values) t;