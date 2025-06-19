with recursive gen(mi, ma) as
(
	select 1504170715041707, 1504170715041707
	union all
	select
		least(mi, (mi + ma) % 4503599627370517),
		greatest(ma, (mi + ma) % 4503599627370517)
	from gen
	where mi > 0
)
select sum(distinct mi) result from gen;