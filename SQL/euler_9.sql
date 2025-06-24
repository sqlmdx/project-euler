select a * b * (1000 - a - b) result
from generate_series(1, 333) a,
	 generate_series(a, 500) b
where a * a + b * b = power(1000 - a - b, 2);