with t0 as
(select generate_series(1, 100) i)
select sum(i)*sum(i) - sum(i*i) 
from t0;