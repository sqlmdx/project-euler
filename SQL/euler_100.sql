/*
By brute-forcing a few first solutions

select b, r, b + r total
from generate_series(1, 2000) r,
     generate_series(2*r+1, 4000) b
where b * (b-1)	* 2 = (b + r) * (b + r - 1);

We can observe that

r(i) = 2 * b(i-1) + r(i-1) - 1
b(i) = 2 * r(i) + b(i-1)
*/

with recursive
gen(b, r) as
(
	select 3::numeric, 1::numeric
	union all
	select 2 * g.r + g.b, g.r
	from (select 2 * b + r - 1 r, b from gen) g
	where b + r < power(10, 12)
)
select b result
from gen
order by b desc
limit 1;