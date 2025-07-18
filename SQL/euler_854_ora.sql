/*
    Unfortunately, performance to below queries degrades quite significantly for bigger N.
    For N = 10^5 first query takes less than a second and the second one completes in a couple of seconds.
    But for 10^6 they take 100+ times longer.
*/

-- it takes about 1.5 minutes to complete

with base(n, fib, luc) as
(
    select 1, 1, 1 from dual
    union all
    select 2, 1, 3 from dual
)
select result
from base
model
dimension by (n)
measures (fib, luc, 0 a005013, 2 result)
rules
-- Oracle does not support expressions after "iterate" so used "until" condition to address that
iterate(1e9) until (iteration_number + 3 = 1e6/2)
(
    fib[iteration_number + 3] order by n = mod(fib[cv()-1] + fib[cv()-2], 1234567891),
    luc[iteration_number + 3] order by n = mod(luc[cv()-1] + luc[cv()-2], 1234567891),
    a005013[iteration_number + 3] order by n = decode(mod(cv(n), 2), 0, fib[cv()], luc[cv()]),
    result[iteration_number + 3] order by n = mod(result[cv()-1] * a005013[cv()], 1234567891)    
)
order by n desc
fetch first 1 rows only;

-- non-iterative model is even worse and takes more than 7 minutes to run

with base(n, fib, luc) as
(
    select 1, 1, 1 from dual
    union all
    select 2, 1, 3 from dual
)
select result
from base
model
dimension by (n)
measures (fib, luc, 0 a005013, 2 result)
rules
(
    fib[for n from 3 to 1e6/2 increment 1] order by n = mod(fib[cv()-1] + fib[cv()-2], 1234567891),
    luc[n > 2] order by n = mod(luc[cv()-1] + luc[cv()-2], 1234567891),
    a005013[n > 1] order by n = decode(mod(cv(n), 2), 0, fib[cv()], luc[cv()]),
    result[n > 2] order by n = mod(result[cv()-1] * a005013[cv()], 1234567891)    
)
order by n desc
fetch first 1 rows only;