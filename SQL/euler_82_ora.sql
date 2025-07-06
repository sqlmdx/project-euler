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
    join t t3 on t1.j + 1 = t3.j and (t3.i < t2.i and t3.i >= t1.i or t3.i > t2.i and t3.i <= t1.i)
    group by t1.id, t2.id
),
r(id, i, j, n, rn) as
(
    select t.id, t.i, t.j, t.n, 1
    from t
    where t.j = 1 
    union all
    select t.id, t.i, t.j, r.n + t.n + nvl(c.path_sum, 0),
            row_number() over (partition by t.i, t.j order by r.n + t.n + nvl(c.path_sum, 0))
    from r
    join t on t.j = r.j + 1
    left join cost c on c.id_from = r.id and c.id_to = t.id 
    where r.rn = 1
)
select min(n) keep (dense_rank last order by j) result
from r;