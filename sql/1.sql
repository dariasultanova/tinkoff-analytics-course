--Со сколькими креативными агентствами мы работаем?

--Креативным агентством считается тот партнер, 
--у которого нет локаций для проведения квестов, 
--но при этом они пишут сценарии, которые мы используем.

select
	*
from
	cource_analytics.partner
where
	partner_rk
	not in
	(
		select
		distinct
			partner_rk
		from
			cource_analytics.location
	)
	and
	partner_rk
	in
	(
		select
		distinct
			partner_rk
		from
			cource_analytics.legend
	)




