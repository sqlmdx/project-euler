-- it takes 2 hours to complete and uses 130GB of temp files

with t(n, k)  as
(
	select distinct i*i+j*j*k, k
	from generate_series(1, sqrt(2000000000)::bigint+1) i,
	generate_series(1, sqrt(2000000000/2)::bigint+1) j,
	unnest('{1, 2, 3, 7}'::int[]) k
	where (i > j or k > 1) and i*i+j*j*k < 2000000000
),
tt as
(
	select n
	from t
	group by n
	having count(k) = 4
)
select sum(1) result
from tt;

/*

with DOP = 4 execution time drops to 52 minutes and overall size of temp files goes down to 70GB
PG cannot parallelize generate_series hence aditional table t100k

set max_parallel_workers_per_gather = 4
set min_parallel_table_scan_size = 0

drop table t100k;
create table t100k(i) as select generate_series(1, 100000)::bigint;

with t(n, k) as
(
	select distinct i*i+j*j*k n, k
	from (select i from t100k where i < sqrt(2000000000)) t0,
	(select i j from t100k where i < sqrt(2000000000/2)) t1,
	unnest('{1, 2, 3, 7}'::int[]) k
	where (i > j or k > 1) and i*i+j*j*k < 2000000000
)
select sum(1) result
from
(
	select n
	from t
	group by n
	having count(k) = 4
) tt;

*/