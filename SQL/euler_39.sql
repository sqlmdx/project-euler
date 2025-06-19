/*

https://en.wikipedia.org/wiki/Pythagorean_triple

"
The following will generate all Pythagorean triples uniquely:
a = k*(m*m-n*n)
b = k*(2*m*n)
c = k*(m*m+n*n)
where m, n, and k are positive integers with m > n, and with m and n coprime and not both odd.
"

Let's find some limits
b < 1000 => k*(2*m*n) < 1000 => m < sqrt(1000/2)
b < 1000 => k*(2*m*n) < 1000 => k < 1000 / (2*m*n)

*/

with gen as
(
	-- distinct here because we do not check that gcd(m, n) = 1
	select distinct k*(m*m-n*n) a, k*(2*m*n) b, k*(m*m+n*n) c
	from generate_series(1, sqrt(1000 / 2)::int) m,
		 generate_series(1, m - 1) n,
		 generate_series(1, (1000 / (2*m*n))::int) k
	where mod(m + n, 2) = 1
)
select a+b+c abc
from gen
where a+b+c <= 1000
group by a+b+c
order by sum(1) desc
limit 1;