with recursive 
gen(i, o, total) as
(
    select 1, 1+2, (1+2)*2 + 1*2 
    union all
    select
		case when total <= 1000000 then i else i+1 end,
		case when total <= 1000000 then o+2 else i+3 end,
		case when total <= 1000000 then total + (o+2)*2 + o*2 else (i+3)*2 + (i+1)*2 end
    from gen
    where i < 1000000/4-1
)
select sum(1)
from gen
where total <= 1000000;