select sum(1) result
from generate_series(1, 9) i,
	 generate_series(1, 50) e
where length(power(i::numeric, e)::numeric(50,0)::text) = e;