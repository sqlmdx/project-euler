/*
create table base_exp(id int generated always as identity, b int, e int);

copy base_exp(b, e)
from '0099_base_exp.txt'
delimiter ',';
*/

select id result
from base_exp
order by ln(b) * e desc
limit 1;