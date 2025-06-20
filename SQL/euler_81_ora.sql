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