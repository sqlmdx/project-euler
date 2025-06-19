/*
https://en.wikipedia.org/wiki/Triangular_number^2
-
https://en.wikipedia.org/wiki/Square_pyramidal_number
*/

with
t0(n) as (select 100 from dual)
select
    power(n*(n+1)/2, 2) - n*(n+1)*(2*n+1)/6 result
from t0;