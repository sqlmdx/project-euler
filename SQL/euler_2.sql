/*
Pisano period for 2 is 3
https://en.wikipedia.org/wiki/Pisano_period

If there N Fibonacci numbers lower than X then N // 3 of them are even-valued
we can gen N from Binet formula
https://en.wikipedia.org/wiki/Fibonacci_sequence#Binet's_formula
N = round(log(X * sqrt(5))/log((1+sqrt(5))/2))
*/

with t0 as
(select 3 * generate_series(1, (log(4e6 * sqrt(5))/log((1+sqrt(5))/2)/3)::int) i)
select sum((power(phi, i) - power(-phi, -i))/sqrt(5))::int
from t0, (select (1 + sqrt(5))/2 phi) t;