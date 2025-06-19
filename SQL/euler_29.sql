select count(distinct power(a, b)) result
from generate_series(2, 100) a,
	 generate_series(2, 100) b;