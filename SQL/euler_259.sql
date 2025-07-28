/*
    Some runtime stats on my laptop
    123456789   ~15min
    12345678    ~1min 27sec
    1234567     ~8sec
    123456      <1sec
*/

with recursive
split(lvl, txt) as
(
	select 1, '#' || 123456789 || '#'
	union all
	select
		lvl + 1,
		regexp_substr(txt, '(#[^#]+){'||lvl-1||'}') || '#'||
		substring(regexp_substr(txt, '[^#]+', 1, lvl), 1, i) || '#' ||
		substring(regexp_substr(txt, '[^#]+', 1, lvl), i+1) || '#'
	from split, generate_series(1, length(regexp_substr(txt, '[^#]+', 1, lvl))-1) i
),
gen(lvl, txt) as
(
	select lvl - 1, txt
	from split
	union all
	select
		distinct
		lvl - 1,
		substring(txt, 1, regexp_instr(txt, '#', 1, i)) ||
		case op
			when '+'
			then (regexp_substr(txt, '[^#]+', 1, i)::numeric + regexp_substr(txt, '[^#]+', 1, i+1)::numeric)::text
			when '*'
			then (regexp_substr(txt, '[^#]+', 1, i)::numeric * regexp_substr(txt, '[^#]+', 1, i+1)::numeric)::text
			when '-'
			then (regexp_substr(txt, '[^#]+', 1, i)::numeric - regexp_substr(txt, '[^#]+', 1, i+1)::numeric)::text
			when '/'
			then
				case
					when abs(regexp_substr(txt, '[^#]+', 1, i+1)::numeric) < 1e-9
					then '!'				
					else (regexp_substr(txt, '[^#]+', 1, i)::numeric / regexp_substr(txt, '[^#]+', 1, i+1)::numeric)::text					
				end
		end ||
		substring(txt, regexp_instr(txt, '#', 1, i+2))
	from gen, generate_series(1, lvl) i, unnest('{+, *, -, /}'::text[]) op
	where position('!' in txt) = 0 and lvl > 0
),
t as
(
	select substring(txt, 2, length(txt)-2)::numeric x
	from gen
	where position('!' in txt) = 0 and lvl = 0
)
select sum(distinct round(x)) result
from t
where x > 0 and abs(x - round(x)) < 1e-9;