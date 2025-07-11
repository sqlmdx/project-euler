-- it takes almost a minute to run on my laptop

with
t as
(
    -- cross apply + regexp here to avoid ORA-00600 bug with xmltable - see euler_81_ora.sql
    select row_number() over (order by id, j) id, id i, j, to_number(regexp_substr(str, '[^,]+', 1, j)) n
    from matrix m
    cross apply (select rownum j from dual connect by level <= regexp_count(m.str, ',') + 1)
),
cost as
(
    select t1.id id_from, t2.id id_to, sum(t3.n) path_sum
    from t t1
    join t t2 on t1.j + 1 = t2.j
    join t t3 on t1.j + 1 = t3.j and (t3.i <= t2.i and t3.i >= t1.i or t3.i >= t2.i and t3.i <= t1.i)
    group by t1.id, t2.id
),
r(id, j, n, rn) as
(
    select t.id, t.j, t.n, 1
    from t
    where t.j = 1 
    union all
    select t.id, t.j, r.n + c.path_sum,
            row_number() over (partition by t.id order by r.n + c.path_sum)
    from r
    join t on t.j = r.j + 1
    join cost c on c.id_from = r.id and c.id_to = t.id 
    where r.rn = 1
)
select min(n) keep (dense_rank last order by j) result
from r;

/*
    model solution has even worse performance than recursive CTE for this one
    execution time is around 10 minutes
    effectively we build two-dimensional matrix x[j, 0, i] where
    value for each cell is the min cost to get to that cell
    (even though there are 3 dimensions, technically matrix is 2D because 0 is the constant)
    as the final step we take min value from the last column

    this can be solved without iterations and with a single rule
    but such approach is even slower because we calculate an aggregate for every single row
*/

with
t as
(
    -- cross apply + regexp here to avoid ORA-00600 bug with xmltable - see euler_81_ora.sql
    select row_number() over (order by id, j) id, id i, j, to_number(regexp_substr(str, '[^,]+', 1, j)) n
    from matrix m
    cross apply (select rownum j from dual connect by level <= regexp_count(m.str, ',') + 1)
),
cost as
(
    select t2.j, t1.i i_from, t2.i i_to, t2.n, sum(t3.n) path_sum
    from t t1
    join t t2 on t1.j + 1 = t2.j
    join t t3 on t1.j + 1 = t3.j and (t3.i <= t2.i and t3.i >= t1.i or t3.i >= t2.i and t3.i <= t1.i)
    group by t2.j, t1.i, t2.i, t2.n
),
base as
(
    select j, 0 i_from, i i_to, n path_sum
    from t
    where j = 1
    union all
    select j, i_from, i_to, path_sum
    from cost
)
select x result
from base
model
dimension by (j, i_from, i_to)
measures (path_sum x)
rules upsert all
-- loop over j from 2 to N
iterate(1e9) until x[iteration_number + 3, 1, 1] is null
(
    x[iteration_number + 2, any, any] order by j, i_from, i_to =
    x[cv(), cv(), cv()] + x[cv(j)-1, 0, cv(i_from)],
    x[iteration_number + 2, 0, any] order by j, i_from, i_to = min(x)[cv(), any, cv()]
)
order by j desc, x
fetch first 1 rows only;