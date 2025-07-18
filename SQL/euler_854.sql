-- https://oeis.org/A005013

with recursive
gen(n, result, fib1, fib2, luc1, luc2, m, a005013) as
(
    select 2,
            2::numeric,
            0::numeric,
            1::numeric,
            2::numeric,
            1::numeric,
            1234567891,
            0::numeric
    union all
    select n + 2,
            result * (case when n % 4 = 0 then fib2 else luc2 end) % m,
            fib2,
            (fib1 + fib2) % m,
            luc2,
            (luc1 + luc2) % m,
            m,
            (case when n % 4 = 0 then fib2 else luc2 end) % m
    from gen
    where n <= 1e6
)
select result
from gen
order by n desc
limit 1;