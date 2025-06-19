select 10*i result
from generate_series(sqrt(replace('1_2_3_4_5_6_7_8_9', '_', '0')::bigint)::bigint,
					 sqrt(replace('1_2_3_4_5_6_7_8_9', '_', '9')::bigint)::bigint) i
where (i*i)::text like '1_2_3_4_5_6_7_8_9';