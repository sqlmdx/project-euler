-- we got lucky because result is integer hence we do not need to calculate GCD :)

select exp(sum(ln(n2_2)))::int::real/exp(sum(ln(n1_1)))::int::real result
from
(
select n1, n2, n1 / 10 n1_1, n1 % 10 n1_2, n2 / 10 n2_1, n2 % 10 n2_2
from generate_series(10, 99) n1,
	 generate_series(n1 + 1, 99) n2
) t
where (n2_1 = n1_2 and n2_2::real / n1_1 = n2::real / n1);