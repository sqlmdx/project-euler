select a+b+c abc, sum(1) cnt
from generate_series(1, 1000) a,
	 generate_series(a + 1, 1000) b,
	 generate_series(b + 1, 1000 - a - b) c
where a * a + b * b = c * c
group by 1
order by 2 desc
limit 1;