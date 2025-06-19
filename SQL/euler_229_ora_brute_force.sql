/*
    On my laptop it takes 2 hours to run in serial mode and 32 minutes to complete with DOP = 4
    In both cases peak temp tablespace usage is 90GB+ (but definitely less than 110GB)

    extracts from SQL monitor reports for both runs are below

    # DOP = 4

    Duration            :  1917s               
    =========================================================================================================
    | Elapsed |   Cpu   |    IO    | Concurrency |  Other   | Fetch | Buffer | Read | Read  | Write | Write |
    | Time(s) | Time(s) | Waits(s) |  Waits(s)   | Waits(s) | Calls |  Gets  | Reqs | Bytes | Reqs  | Bytes |
    =========================================================================================================
    |    8167 |    7365 |      792 |        0.03 |     9.43 |     1 |      8 |   1M | 130GB |    1M | 130GB |
    =========================================================================================================

    # SERIAL MODE

    Duration            :  7066s        
    ===========================================================================================
    | Elapsed |   Cpu   |    IO    |  Other   | Fetch | Buffer | Read | Read  | Write | Write |
    | Time(s) | Time(s) | Waits(s) | Waits(s) | Calls |  Gets  | Reqs | Bytes | Reqs  | Bytes |
    ===========================================================================================
    |    7065 |    6811 |      178 |       76 |     1 |  24290 |   2M | 224GB |    2M | 224GB |
    ===========================================================================================
*/

with t(n, k)  as
(
    select distinct i*i+j*j*k, k
    from 
    (select level i from dual connect by level <= sqrt(2000000000) + 1),
    (select level j from dual connect by level <= sqrt(2000000000/2) + 1),
    (select 1 k from dual
    union all select 2 from dual
    union all select 3 from dual
    union all select 7 from dual)
    where (i > j or k > 1) and i*i+j*j*k < 2000000000
)
select sum(1) result
from
(
    select --+ parallel(4) 
    n
    from t
    group by n
    having count(k) = 4
);