select
	1 * (l - l1) + 2 * (l - l2) + 3 * (l - l3) +
	4 * (l - l4) + 5 * (l - l5) + 6 * (l - l6) +
	7 * (l - l7) + 8 * (l - l8) + 9 * (l - l9) result
from
(	 
	select
		length(replace(str, '1', '')) l1,
		length(replace(str, '2', '')) l2,
		length(replace(str, '3', '')) l3,
		length(replace(str, '4', '')) l4,
		length(replace(str, '5', '')) l5,
		length(replace(str, '6', '')) l6,
		length(replace(str, '7', '')) l7,
		length(replace(str, '8', '')) l8,
		length(replace(str, '9', '')) l9,
		length(str) l
	from
	(select power(2::numeric, 1000)::text str) t
) t;

----------------------------------------------------------------------------------------------------

select length(regexp_replace(regexp_replace(str,'0|\.', '', 'g'),
							 '(2)|(3)|(4)|(5)|(6)|(7)|(8)|(9)',
							 '\1\1\2\2\2\3\3\3\3\4\4\4\4\4\5\5\5\5\5\5\6\6\6\6\6\6\6\7\7\7\7\7\7\7\7\8\8\8\8\8\8\8\8\8',
							 'g')) result
from (select power(2::numeric, 1000)::text str) t