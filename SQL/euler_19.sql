select sum(case when to_char(date '1901-01-01' + (i || ' months')::interval, 'fmday') = 'sunday' then 1 end) result
from generate_series(1, 1200) i;