select count(distinct power(t1.n, 2) + power(t2.n, 3) + power(t3.n, 4)) result
from tprime t1, tprime t2, tprime t3
where t1.n < power(50000000, 0.5) 
	and t2.n < power(50000000, 1.0/3)
	and t3.n < power(50000000, 0.25)
	and power(t1.n, 2) + power(t2.n, 3) + power(t3.n, 4) < 50000000;