-- iterative model

with base(n, fib, luc) as
(
    select 1, 1, 1 from dual
    union all
    select 2, 1, 3 from dual
    union all
    select level + 2, 0, 0 from dual connect by level < 1e6/2 - 1    
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
    fib[iteration_number + 3] = mod(fib[cv()-1] + fib[cv()-2], 1234567891),
    luc[iteration_number + 3] = mod(luc[cv()-1] + luc[cv()-2], 1234567891),
    a005013[iteration_number + 3] = decode(mod(cv(n), 2), 0, fib[cv()], luc[cv()]),
    result[iteration_number + 3] = mod(result[cv()-1] * a005013[cv()], 1234567891)    
)
order by n desc
fetch first 1 rows only;

-- non-iterative model

with base(n, fib, luc) as
(
    select 1, 1, 1 from dual
    union all
    select 2, 1, 3 from dual
    union all
    select level + 2, 0, 0 from dual connect by level < 1e6/2 - 1
)
select result
from base
model
dimension by (n)
measures (fib, luc, 0 a005013, 2 result)
rules
(
    fib[n > 2] order by n = mod(fib[cv()-1] + fib[cv()-2], 1234567891),
    luc[n > 2] order by n = mod(luc[cv()-1] + luc[cv()-2], 1234567891),
    a005013[n > 2] order by n = decode(mod(cv(n), 2), 0, fib[cv()], luc[cv()]),
    result[n > 2] order by n = mod(result[cv()-1] * a005013[cv()], 1234567891)    
)
order by n desc
fetch first 1 rows only;