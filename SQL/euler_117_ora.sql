with m as
(
    select *
    from dual
    model
    dimension by (0 id)
    measures (1 result)
    rules
    iterate(50)
    (
        result[iteration_number+1] = sum(result)[id between iteration_number - 3 and iteration_number]
    )
)
select result
from m
where id = 50;