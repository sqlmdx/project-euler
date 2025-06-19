/*
create table words(word text[]);

insert into words
values ('{<copy from file 0042_words.txt>}');
*/

with
t(str) as
(
	select u word
	from words, unnest(word) u
),
values as
(
	select str, sum(ascii(substr(str, i, 1))-ascii('A')+1) value
	from t, generate_series(1, length(str)) i
	group by str
)
select sum(1) result
from values, generate_series(1, (select sqrt(max(value)*2)::int+1 from values)) i
where i*(i+1)/2 = value;