with m as
(
    select *
    from dual
    model
    dimension by (0 id)
    measures (1 result)
    rules
    (
        result[for id from 1 to 50 increment 1] = sum(result)[id between cv() - 4 and cv()]
    )
)
select result
from m
where id = 50;