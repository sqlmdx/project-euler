/*
this works only for specific prefix - 123
while doing brute force we may notice that the counter increases by one of 3 values - 196/289/485
so below solution performs the same number of steps as an input value - 678910
elapsed time is around 2 minutes even though the number of steps is orders of magnitede less than in brute force
this is because SQL engine has to work with a huge numbers on every step
*/

with recursive
gen(lvl, tmp, result) as
(
	select 1, power(2::numeric, 90), 90
	union all
	select
		lvl + 1,
		case when substring(tmp1::text,1,3) = '123' then tmp1 when substring(tmp2::text,1,3) = '123' then tmp2 else tmp3 end,
		case when substring(tmp1::text,1,3) = '123' then 196 when substring(tmp2::text,1,3) = '123' then 289 else 485 end + result
	from
	(
		select
			reduced * 100433627766186892221372630771322662657637687111424552206336 tmp1, -- power(2, 196)
			reduced * 994646472819573284310764496293641680200912301594695434880927953786318994025066751066112 tmp2, -- power(2, 289)
			reduced * 99895953610111751404211111353381321783955140565279076827493022708011895642232499843849795298031743077114461795885011932654335221737225129801285632 tmp3, -- power(2, 485)
			t.*
		from (select lvl, result, tmp/power(10, ceil(log(10, tmp))) reduced from gen) t
		where lvl < 678910
	) tt
)
select max(result) result
from gen;