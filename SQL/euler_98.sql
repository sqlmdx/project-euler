-- it takes almost 4 minutes to run on my laptop

/*
create table words(word text[]);

insert into words
values ('{<copy from file 0098_words.txt>}');
*/

with recursive
gen(lvl, txt) as
(
	select 1, generate_series(0, 9)::text
	union all
	select lvl+1, txt||x::text
	from gen, generate_series(0, 9) x
	where position(x::text in txt) = 0
	-- uncomment this to get the right answer in 3 seconds :)
	-- and lvl < 5
),
w as
(
	select u, string_agg(substring(u, n, 1), '' order by substring(u, n, 1)) o
	from words w, unnest(word) u, generate_series(1, length(u)) n
	group by u
),
ww as
(
	select o, regexp_replace(o, '(.)\1+', '\1') mask, u, count(*) over (partition by o) cnt
	from w
),
www as
(
	select o, txt, translate(u, mask, txt)::int num
	from ww
	join gen g on length(mask) = g.lvl
	where ww.cnt > 1
	and left(translate(u, mask, txt), 1) != '0'
)
select max(num) result
from www
where power(round(sqrt(num)), 2) = num
group by o, txt
having count(*) > 1
order by length(o) desc
limit 1;