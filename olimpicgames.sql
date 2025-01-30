--1º
select full_name, gender
from PERSON p 
join GAMES_COMPETITOR gc on p.person_id = gc.person_id
group by full_name, gender
having COUNT(gc.games_id) > 5

union

select full_name, gender
from PERSON p 
join GAMES_COMPETITOR gc on p.person_id = gc.person_id
join COMPETITOR_EVENT ce on gc.competitor_id = ce.competitor_id
join MEDAL m on ce.medal_id = m.medal_id
and (medal_name = 'Gold' or medal_name = 'Silver')
group by full_name, gender
having  COUNT (event_id) > 3
;
--2º
select games_year, games_name, season, COUNT(person_id) as total_participants
from GAMES g
join GAMES_COMPETITOR gc on g.games_id = gc.games_id
where age > 30 
group by games_year, games_name, season
having count(gc.person_id) > 50 
order by games_year desc
;
--3º
select full_name, sport_name, event_name
from PERSON p
join GAMES_COMPETITOR gc on p.person_id = gc.person_id
join GAMES g on gc.games_id = g.games_id and (games_name = 'Games of the VII Olympiad')
join COMPETITOR_EVENT ce on gc.competitor_id = ce.competitor_id
join EVENT e on ce.event_id = e.event_id 
join SPORT s on e.sport_id = s.sport_id
join MEDAL m on ce.medal_id = m.medal_id
where medal_name = 'Gold' and (sport_name = 'Gymnastics' or sport_name = 'Archery')
;
--4º

--5º
select full_name, sport_name, event_name, CASE
 WHEN medal.medal_name is null THEN 'No medal'
 ELSE medal.medal_name
END AS 'Medal'
from PERSON
left join GAMES_COMPETITOR on PERSON.person_id=GAMES_COMPETITOR.person_id
left join GAMES on GAMES.games_id=GAMES_COMPETITOR.games_id and games_name='Games of the VII
Olympiad'
join COMPETITOR_EVENT on GAMES_COMPETITOR.competitor_id=COMPETITOR_EVENT.competitor_id
join EVENT on COMPETITOR_EVENT.event_id=EVENT.event_id
join SPORT on SPORT.sport_id=EVENT.sport_id and (sport_name='Archery' or sport_name='Gymnastics')
LEFT join MEDAL on MEDAL.medal_id=COMPETITOR_EVENT.medal_id
order by games_name