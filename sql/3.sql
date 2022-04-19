--В каждом городе провели награждение 3х сотрудников, 
--в чью смену среди пройденных игр оказалось самое низкое 
--среднее время прохождения. Выпишите фамилию девушки 
--серебряного призера. Если таких несколько, выведите первую 
--в алфавитном порядке

select
	e.employee_rk,
	e.first_name,
	e.last_name,
	avg(time) as avg_time,
	city_nm
from
	cource_analytics.game g
	join cource_analytics.employee e
		on e.employee_rk = g.employee_rk
	join cource_analytics.quest q
		on q.quest_rk = g.quest_rk
	join cource_analytics.location l
		on l.location_rk = q.location_rk
group by
	e.employee_rk,
	city_nm
order by
	city_nm,
	avg_time,
	last_name




