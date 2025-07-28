with recursive
gen(lvl, tmp, result) as
(
    select 0, 1::bigint, 1::bigint
    union all
    select lvl + 1, result, tmp + result +
        case
            when (lvl + 1) % 3 > 0
            then
                case
                    when ((lvl + 1) / 3) % 2 = 1
                    then 1
                    else -1
                end
            else 0
        end
    from gen
    where lvl < 50
)
select result
from gen
where lvl = 50;