-- create table poker(id int generated always as identity, str varchar2(4000));

-- This can be solved in PG with a lot of subqueries and window functions instead of single match_recognize

with
parse as
(
    select id, trunc((n-1)/5)+1 p, regexp_substr(str, '[^ ]+', 1, n) x
    from poker p
    cross join (select level n from dual connect by level <= 10) t
    order by id, n
),
encode as
(
    select id, p, decode(substr(x, 1, 1), 'T', 10, 'J', 11, 'Q', 12, 'K', 13, 'A', 14, substr(x, 1, 1)) c, substr(x, 2) s
    from parse
),
priority(ord, verdict) as
(
    select 1, 'HIGH CARD' from dual
    union all select 2, 'PAIR' from dual
    union all select 3, 'PAIRPAIR'from dual
    union all select 4, 'THREE' from dual
    union all select 5, 'STRAIGHT' from dual
    union all select 6, 'FLUSH' from dual
    union all select 7, 'THREEPAIR' from dual
    union all select 8, 'FOUR' from dual
    union all select 9, 'STRAIGHT FLUSH' from dual
    union all select 10, 'ROYAL FLUSH' from dual
),
mr as
(
    select *
    from (select t.*, row_number() over (partition by id, p order by c desc) rn from encode t)
    match_recognize
    (
        partition by id, p
        order by rn
        measures
            case when classifier() = 'FLUSH' then sum(power(16, 5-rn) * c) else c end as high_card,
            final count(*) as cnt,
            case
                when classifier() = 'SAME' and final count(*) = 4 then 'FOUR'
                when classifier() = 'SAME' and final count(*) = 3 then 'THREE'
                when classifier() = 'SAME' and final count(*) = 2 then 'PAIR'
                when classifier() = 'STRAIGHT' and min(s) = max(s) and c = 10 then 'ROYAL FLUSH'
                when classifier() = 'STRAIGHT' and min(s) = max(s) then 'STRAIGHT FLUSH'            
                when classifier() = 'X' then ''
                else classifier()
            end type        
        pattern (
                    straight{5}|
                    flush{5}|
                    (same{2,})|
                    x
                )
        define
            same as same.c = first(same.c),
            flush as flush.s = first(flush.s),
            straight as straight.c = prev(straight.c) - 1 or prev(straight.c) is null
    )
),
t1 as
(
    select id, p, listagg(type||'['||to_char(high_card, 'fmXXXXX')||']', ', ') within group (order by cnt desc, high_card desc) verdict
    from mr
    group by id, p
),
t2 as
(
    select t1.*, p.ord
    from t1
    left join priority p on nvl(replace(regexp_replace(t1.verdict, '\[[^]]+\]'), ', '), 'HIGH CARD') = p.verdict  
),
t3 as
(
    select *
    from t2
    pivot (max(verdict) as verdict, max(ord) as ord for p in (1 as p1, 2 as p2))
)
select sum(case when p1_ord > p2_ord or p1_ord = p2_ord and p1_verdict > p2_verdict then 1 end) result 
from t3;