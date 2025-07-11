-- create table matrix(id int generated always as identity, str varchar2(4000));

select n result
from
(
    select id i, j, n
    from matrix, xmltable(str columns j for ordinality, n int path '.')
)
model
dimension by (i+j d, i)
measures(n)
rules
(
    n[d > 2, any] order by d, i = n[cv(d), cv(i)] 
    + least(nvl(n[cv(d)-1, cv(i)-1], 1e9), nvl(n[cv(d)-1, cv(i)], 1e9))
)
order by d desc
fetch first 1 rows only;

/*
    below is an adaptation of PG solution
    Oracle does not support `distinct` in recursive member hence additional column for row_number
    `cycle` clause has been added to avoid false cycle detection
*/

with
t as
(
   select id i, j, n
   from matrix, xmltable(str columns j for ordinality, n int path '.')
   -- to avoid ORA-00600: internal error code, arguments: [qmxqrsProcessRsltSeq:itemTyp]
   where rownum >= 1 
),
r(i, j, n, rn) as
(
   select i, j, n, 1
   from t
   where (i, j) = ((1, 1))
   union all
   select t.i, t.j, t.n + r.n, row_number() over (partition by t.i, t.j order by r.n)
   from r, (select 1 di, 0 dj from dual union all select 0, 1 from dual) x, t 
   where (t.i, t.j) = ((r.i + x.di, r.j + x.dj)) and r.rn = 1
)  
select min(n) keep (dense_rank last order by i+j) result
from r;