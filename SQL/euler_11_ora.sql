-- this can be solved in PG usign the same trick with exp(sum(ln(x))) like in Problem 8
-- also numbers can be multiplied using recursive CTE
-- A couple of alternaties using Oracle features are below

with t(str) as
(
select 
'08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48'
from dual
)
, t0(i, x) as
(
    select level, regexp_substr(str, '\d+', 1, level) x
    from t
    connect by regexp_substr(str, '\d+', 1, level) is not null
)
, t1(i, x, hor, ver, diag1, diag2) as
(
select
    t0.*, 
    (
        select 
        nvl(listagg(x, '*') within group (order by i), 1)
        from t0 t
        where mod(t.i, 20) between mod(t0.i, 20) and mod(t0.i, 20) + 3
        and trunc(t.i/20) = trunc(t0.i/20)
    ) hor,
    (
        select 
        nvl(listagg(x, '*') within group (order by i), 1)
        from t0 t
        where mod(t.i, 20) = mod(t0.i, 20)
        and trunc(t.i/20) between trunc(t0.i/20) and trunc(t0.i/20) + 3
    ) ver    
    ,
    (
        select 
        nvl(listagg(x, '*') within group (order by i), 1)
        from t0 t
        where mod(t.i, 20) between mod(t0.i, 20) and mod(t0.i, 20) + 3 
        and trunc(t.i/20) between trunc(t0.i/20) and trunc(t0.i/20) + 3
        and trunc(t.i/20) - trunc(t0.i/20) = mod(t.i, 20) - mod(t0.i, 20)
    ) diag1
    ,
    (
        select 
        nvl(listagg(x, '*') within group (order by i), 1)
        from t0 t
        where mod(t.i, 20) between mod(t0.i, 20) - 3 and mod(t0.i, 20) 
        and trunc(t.i/20) between trunc(t0.i/20) and trunc(t0.i/20) + 3
        and trunc(t.i/20) - trunc(t0.i/20) = - mod(t.i, 20) + mod(t0.i, 20)
    ) diag1
from t0
)
select greatest(hor, ver, diag1, diag2) result
from
(
    select 
        max(xmlcast(xmlquery(hor returning content) as int)) hor,
        max(xmlcast(xmlquery(ver returning content) as int)) ver,
        max(xmlcast(xmlquery(diag1 returning content) as int)) diag1,
        max(xmlcast(xmlquery(diag2 returning content) as int)) diag2
    from t1
);

----------------------------------------------------------------------------------------------------

with t(str) as
(
select 
'08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48'
from dual
)
, t0(lvl, x, i, j) as
(
    select
        level,
        regexp_substr(str, '\d+', 1, level) x,
        mod(level-1, 20) i,
        trunc((level-1)/20) j
    from t
    connect by regexp_substr(str, '\d+', 1, level) is not null
)
, t1 as
(
    select
        t0.*, k,
        case when i <= 20 - 4 then i + (j + 0) * 20 + k end i1,
        case when j <= 20 - 4 then i + (j + k) * 20 + 0 end i2,
        case when i <= 20 - 4 and j <= 20 - 4 then i + (j + k) * 20 + k end i3,
        case when i >= 4 - 1 and j <= 20 - 4 then i + (j + k) * 20 - k end i4
    from t0, (select level-1 k from dual connect by level <= 4)
), m as
(
    select *
    from t1
    model
        reference t0 on (select * from t0)
        dimension by (lvl)
        measures (x)
    partition by (lvl)
    dimension by (k)
    measures (i1, i2, i3, i4, 1 p1, 1 p2, 1 p3, 1 p4)
    (
        p1[any] order by k = t0.x[i1[cv()]+1] * nvl(p1[cv()-1], 1), 
        p2[any] order by k = t0.x[i2[cv()]+1] * nvl(p2[cv()-1], 1),
        p3[any] order by k = t0.x[i3[cv()]+1] * nvl(p3[cv()-1], 1),
        p4[any] order by k = t0.x[i4[cv()]+1] * nvl(p4[cv()-1], 1)
    )
)
select greatest(max(p1), max(p2), max(p3), max(p4)) result
from m;