with t0 as
(select generate_series(100, 999) i)
select
	max(t1.i * t2.i) result
from t0 t1, t0 t2
where t2.i >= t1.i
and (t1.i * t2.i)::text = reverse((t1.i * t2.i)::text);