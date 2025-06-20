/*
create table matrix(id int generated always as identity, str text);

copy matrix(str)
from '0081_matrix.txt';
*/

with recursive
t as
(
	select id i, j, n
	from matrix, unnest(('{'||str||'}')::int[]) with ordinality as row(n, j)
),
r as
(
	select i, j, n
	from t
	where (i, j) = (1, 1)
	union all
	select distinct t.i, t.j, t.n + min(r.n) over (partition by t.i, t.j)
	from r
	join t on (t.i, t.j) = (r.i + 1, r.j) or (t.i, t.j) = (r.i, r.j + 1)
)
select n result
from r
order by i+j desc
limit 1;