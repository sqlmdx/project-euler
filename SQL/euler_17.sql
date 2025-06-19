select
	sum(length(regexp_replace(cash_words(i::money), 'doll.+| ', '', 'g'))) +
	sum(case when i > 100 and mod(i, 100) > 19 then 1 end) * length('and') result
from generate_series(1, 1000) i;