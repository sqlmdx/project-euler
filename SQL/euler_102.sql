/*
create table triangles(id int generated always as identity, x1 int, y1 int, x2 int, y2 int, x3 int, y3 int);

copy triangles(x1, y1, x2, y2, x3, y3)
from '0102_triangles.txt'
delimiter ',';
*/

with t0 as
(
    select
        case when sign(x1) != sign(x2) then (x1*y2 - y1*x2)/(x1-x2)::real end c1,
        case when sign(x2) != sign(x3) then (x2*y3 - y2*x3)/(x2-x3)::real end c2,
        case when sign(x1) != sign(x3) then (x1*y3 - y1*x3)/(x1-x3)::real end c3,
        t.*	
    from triangles t
)
select 
    -- if one side crosses AxisY above 0 and one side crosses AxisY below 0 or one side touches origin
    sum(case when least(c1,c2,c3) < 0 and greatest(c1,c2,c3) > 0 or 0 in (c1, c2, c3) then 1 end) result
from t0;