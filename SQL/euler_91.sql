with t as
(
select (x1*x1 + y1*y1) a, (x2*x2 + y2*y2) b, (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1) c, x1*y2 < x2*y1 flag
from generate_series(0, 50) x1,
 	 generate_series(0, 50) y1,
	 generate_series(x1, 50) x2,
 	 generate_series(0, y1) y2
)
select sum(1) result
from t
where (c = a + b or a = b + c or b = a + c) and flag;