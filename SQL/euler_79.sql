/*
create table keylog(id int generated always as identity, digits text);

copy keylog(digits)
from '0079_keylog.txt';
*/

-- two step solution

-- Step 1: generate rules

with t as
(
	select distinct digits from keylog
),
tt as
(
	select digits, i, substr(digits, i, 1) d
	from t, generate_series(1, length(digits)) i
),
ttt as
(
	select distinct t1.d curr, t2.d nxt
	from tt t1
	join tt t2 on t1.digits = t2.digits and t1.i < t2.i
)
select 'or prev = '''||curr||''' and d in (' || string_agg(''''||nxt||'''', ', ' order by nxt) || ')' rule
from ttt
group by curr;

-- Step 2: get solution which contains all digits from input file

with recursive 
gen(lvl, str, prev) as
(
	select 1, d::text, d prev from generate_series(0, 9) d
	union all
	select lvl + 1, str||d::text, d
	from gen g
	join generate_series(0, 9) d on 1 = 0
	or prev = '1' and d in ('0', '2', '6', '8', '9')
	or prev = '2' and d in ('0', '8', '9')
	or prev = '3' and d in ('0', '1', '2', '6', '8', '9')
	or prev = '6' and d in ('0', '2', '8', '9')
	or prev = '7' and d in ('0', '1', '2', '3', '6', '8', '9')
	or prev = '8' and d in ('0', '9')
	or prev = '9' and d in ('0')
)
select str result
from gen
where lvl >= 8;