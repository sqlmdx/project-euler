-- see Problem 39 regarding Pythagorean triples

with gen as
(
	-- distinct here because we do not check that gcd(m, n) = 1
	select distinct k*(m*m-n*n) a, k*(2*m*n) b, k*(m*m+n*n) c
	from generate_series(1, sqrt(1500000 / 2)::int) m,
		 generate_series(1, m - 1) n,
		 generate_series(1, (1500000 / (2*m*n))::int) k
	where mod(m + n, 2) = 1
),
t as
(
	select a+b+c abc
	from gen
	where a+b+c <= 1500000
	group by a+b+c
	having sum(1) = 1
)
select sum(1) result
from t;