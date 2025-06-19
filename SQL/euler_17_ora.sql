select
    sum(length(translate(to_char(to_date(level, 'j'), 'jsp'), '# -', '#'))) + 
    sum(case when level > 100 and mod(level, 100) > 0 then 1 end) * length('and') result
from dual
connect by level <= 1000;