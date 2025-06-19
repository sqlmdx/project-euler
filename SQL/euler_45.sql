with recursive
gen(n, match, ip, ih) as
(
	select 1, 1, 1::bigint, 1::bigint
	union all
	select n+1,
			match + case when ip*(3*ip-1)/2 = ih*(2*ih-1) then 1 else 0 end,
			ip + case when ip*(3*ip-1)/2 <= ih*(2*ih-1) then 1 else 0 end,
			ih + case when ip*(3*ip-1)/2 >= ih*(2*ih-1) then 1 else 0 end	
	from gen
	where match <= 3
)
select ih*(2*ih-1) result
from gen
where ip*(3*ip-1)/2 = ih*(2*ih-1)
order by 1 desc
limit 1;