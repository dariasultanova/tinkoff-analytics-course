--У какого квеста (выпишите его quest_nm) разница доли состоявшихся 
--квестов в январе и в феврале наибольшая по модулю?

--Долей считать количество состоявшихся квестов деленное на 
--количество заявленных. В случае наличия нескольких квестов, 
--подходящих под условие, требуется вывести тот, у которого значение 
--quest_rk больше.

with 
held_jan as
(
	select
		quest_nm,
		count(*)
	from
 		cource_analytics.quest q
		inner join cource_analytics.game g
		on g.quest_rk = q.quest_rk
	where
		g.game_flg = 1
		and
		extract(month from g.game_dttm) = 1
	group by
		q.quest_rk
),
announced_jan as
(
	select
		quest_nm,
		count(*)
	from
 		cource_analytics.quest q
		inner join cource_analytics.game g
		on g.quest_rk = q.quest_rk
	where
		extract(month from g.game_dttm) = 1
	group by
		q.quest_rk
),
held_feb as
(
	select
		quest_nm,
		count(*)
	from
 		cource_analytics.quest q
		inner join cource_analytics.game g
		on g.quest_rk = q.quest_rk
	where
		g.game_flg = 1
		and
		extract(month from g.game_dttm) = 2
	group by
		q.quest_rk
),
announced_feb as
(
	select
		quest_nm,
		count(*)
	from
 		cource_analytics.quest q
		inner join cource_analytics.game g
		on g.quest_rk = q.quest_rk
	where
		extract(month from g.game_dttm) = 2
	group by
		q.quest_rk
),
share_jan as
(
	select
		held_jan.quest_nm,
		cast(held_jan.count as float) / cast(announced_jan.count as float) as share_j
	from
		held_jan
		inner join announced_jan
		on announced_jan.quest_nm = held_jan.quest_nm
),
share_feb as
(
	select
		held_feb.quest_nm,
		cast(held_feb.count as float) / cast(announced_feb.count as float) as share_f
	from
		held_feb
		inner join announced_feb
		on announced_feb.quest_nm = held_feb.quest_nm
)

select
	share_feb.quest_nm,
	abs(share_j - share_f) as res
from
	share_jan
	inner join share_feb
	on share_feb.quest_nm = share_jan.quest_nm
order by
	res
	desc





