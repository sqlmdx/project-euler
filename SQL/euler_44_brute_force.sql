/*

n*(3*n-1)/2 = p =>
3*n^2 - n - 2p = 0 =>
(1 + sqrt(1 + 24p))/6 must be integer

*/

with
pentagon(n, p) as
(
	select n, n*(3*n-1)/2 p from generate_series(1, 5000) n
)
select *, p2.p - p1.p result
from pentagon p1
join pentagon p2 on p2.n > p1.n
where (1 + sqrt(1+24*(p2.p + p1.p))) / 6 = floor((1 + sqrt(1+24*(p2.p + p1.p))) / 6)
  and (1 + sqrt(1+24*(p2.p - p1.p))) / 6 = floor((1 + sqrt(1+24*(p2.p - p1.p))) / 6);