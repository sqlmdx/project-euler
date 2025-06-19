/*
create table cipher(code int[]);

insert into cipher
values ('{<copy from file 0059_cipher.txt>}');
*/

with gen as
(
	select row_number() over (order by i, j, k) rn, *
	from generate_series(ascii('a'), ascii('a')+26-1) i,
		 generate_series(ascii('a'), ascii('a')+26-1) j,
		 generate_series(ascii('a'), ascii('a')+26-1) k
),
t as
(
	select
		rn,
		n,
		case (n-1) % 3 when 0 then v # i when 1 then v # j when 2 then v # k end x		
	from cipher c, unnest(c.code) with ordinality as arr(v, n), gen g
),
tt as
(
	select
		count(case when x between ascii('a') and ascii('a')+26 then 1 end) score,
		string_agg(chr(x), '' order by n) str
	from t
	group by rn
	order by 1 desc
	limit 1
)
select sum(ascii(substr(str, i, 1))) result
from tt, generate_series(1, length(str)) i;