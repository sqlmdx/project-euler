with recursive 
fib(i, tmp1, rr, tmp2, rl) as
(
	select 1, 0::numeric, 1::numeric, 0::numeric, 1::numeric
	union all
	select i, tmp1, rr, tmp2, rl
	from
	(
		select i + 1 i,
				rr tmp1,
				(tmp1 + rr) % 1000000000 rr,
				case when rl > 1000000000 then rl / 10 else rl end tmp2,
				case when rl > 1000000000 then (tmp2 + rl) / 10 else tmp2 + rl end rl,
				rr::text rrr,
				left(rl::text, 9) rrl
		from fib
	) f
	where not
	(
		rrr ~ '1' and rrr ~ '2' and rrr ~ '3' and rrr ~ '4' and rrr ~ '5' and rrr ~ '6' and rrr ~ '7' and rrr ~ '8' and rrr ~ '9'
		and
		rrl ~ '1' and rrl ~ '2' and rrl ~ '3' and rrl ~ '4' and rrl ~ '5' and rrl ~ '6' and rrl ~ '7' and rrl ~ '8' and rrl ~ '9'
	)
)
select i result
from fib
order by i desc
limit 1;