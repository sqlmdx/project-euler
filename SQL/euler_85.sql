select i*j result
from generate_series(1, 100) i,
	 generate_series(i, 100) j
order by abs(i*(i+1)/2*j*(j+1)/2-2000000)
limit 1;