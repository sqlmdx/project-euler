-- column result format 999999999999999999

select 4 - (a + 2 * b) result
from (select 1e12 / 2 n, 1 a, 0 b from dual)
model
dimension by (0 dummy)
measures (n, a, b)
rules
iterate(1e9) until (n[0] = 1)
(
    a[0] = case when mod(n[0], 2) = 0 then 2 * a[0] + b[0] else a[0] end,
    b[0] = case when mod(n[0], 2) = 0 then -3 * b[0] else -3 * a[0] + 2 * b[0] end,
    n[0] = trunc(n[0] / 2)
);