with recursive
gen(lvl, n, flag) as
(
	select 1, 0, 0
	union all
	select lvl+1, lvl, 
	(
		select count(*)::int
		from generate_series(2, 6) m
		where translate(lvl::text, '123456789', '1')
			||translate(lvl::text, '234567891', '2')
			||translate(lvl::text, '345678912', '3')
			||translate(lvl::text, '456789123', '4')
			||translate(lvl::text, '567891234', '5')
			||translate(lvl::text, '678912345', '6')
			||translate(lvl::text, '789123456', '7')
			||translate(lvl::text, '891234567', '8')
			||translate(lvl::text, '912345678', '9')
			= translate((lvl*m)::text, '123456789', '1')
			||translate((lvl*m)::text, '234567891', '2')
			||translate((lvl*m)::text, '345678912', '3')
			||translate((lvl*m)::text, '456789123', '4')
			||translate((lvl*m)::text, '567891234', '5')
			||translate((lvl*m)::text, '678912345', '6')
			||translate((lvl*m)::text, '789123456', '7')
			||translate((lvl*m)::text, '891234567', '8')
			||translate((lvl*m)::text, '912345678', '9')
	)
	from gen
	where flag < 5
)
select n result
from gen
where flag = 5;