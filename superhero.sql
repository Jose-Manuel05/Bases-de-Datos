--1º
select Superhero_Name, Full_Name, concat(count(Id_Attribute), ' atributes') as Total
from SUPERHERO s
right join HERO_ATTRIBUTE ha on s.Id_Superhero = ha.Id_Hero
group by Superhero_Name, Full_Name
having COUNT(Id_Attribute) > 10 
union
select Superhero_Name, Full_Name, concat(count(Id_Power), ' powers') as Total
from SUPERHERO s
right join HERO_POWER hp on s.Id_Superhero = hp.Id_Hero
group by Superhero_Name, Full_Name
having COUNT(Id_Power) > 40
;
--2º
select Superhero_Name, Gender_Name as Gender, Race_Name as Race, concat(Height_cm, ' cm') as Height
from SUPERHERO s
join GENDER g on s.Gender_Id = g.IdGender
left join RACE r on s.Race_Id = r.Id_Race
join COLOUR ch on s.Hair_colour_Id = ch.IdColour
join COLOUR ce on s.Eye_colour_Id = ce.IdColour
where (Gender_Name = 'Female' and ch.Colour_Name = 'blond'and Weight_kg < 50) or (Gender_Name = 'Male' and ce.Colour_Name = 'Blue' and Height_cm > 220)
;
--3º
select Attribute_Name, COUNT(Id_Hero) as TOTAL_HERO
from ATTRIBUTE a
join HERO_ATTRIBUTE ha on a.IdAttribute = ha.Id_Attribute
where Attribute_Value > 95
group by Attribute_Name
;
--4º
select Superhero_Name as SUPERHERO, ce.Colour_Name as EYE_COLOR, ch.Colour_Name as HAIR_COLOR, cs.Colour_Name as SKIN_COLOR
from SUPERHERO s
join HERO_POWER hp on s.Id_Superhero = hp.Id_Hero
join COLOUR ce on s.Eye_colour_Id = ce.IdColour
join COLOUR ch on s.Hair_colour_Id = ch.IdColour
join COLOUR cs on s.Skin_colour_Id = cs.IdColour
group by Superhero_Name, ce.Colour_Name, ch.Colour_Name, cs.Colour_Name
order by EYE_COLOR, HAIR_COLOR,SKIN_COLOR asc
;
--5º
select Power_Name, COUNT(Id_Hero) as Total_heroes
from SUPERPOWER sp
join HERO_POWER hp on sp.Id_Power = hp.Id_Power
join SUPERHERO s on hp.Id_Hero = s.Id_Superhero
join ALIGNMENT a on s.Alignment_Id = a.IdAlignment
join RACE r on s.Race_Id = r.Id_Race
join GENDER g on s.Gender_Id = g.IdGender
where Alignment_Name = 'good' and Race_Name = 'human' and Gender_Name = 'male'
group by Power_Name
;
--6º
select Superhero_Name, Full_Name, Race_Name, Height_cm, Alignment_Name, ce.Colour_Name
from SUPERHERO s
left join RACE r on s.Race_Id = r.Id_Race
join ALIGNMENT a on s.Alignment_Id = a.IdAlignment 
join COLOUR ce on s.Eye_colour_Id = ce.IdColour
where Height_cm < 150 and ce.Colour_Name = 'blue'
;
--7º ??
select Superhero_Name, ce.Colour_Name as EYE_COLOR, ch.Colour_Name as HAIR_COLOR, cs.Colour_Name as SKIN_COLOR
from SUPERHERO s
join COLOUR ce on s.Eye_colour_Id = ce.IdColour
left join COLOUR ch on s.Hair_colour_Id = ch.IdColour
join COLOUR cs on s.Skin_colour_Id = cs.IdColour
join HERO_POWER hp on s.Id_Superhero = hp.Id_Hero
group by Superhero_Name, ce.Colour_Name, ch.Colour_Name, cs.Colour_Name
order by EYE_COLOR, HAIR_COLOR,SKIN_COLOR asc
;
--8º
select Superhero_Name, Full_Name, Gender_Name, Publisher_Name, Race_Name
from SUPERHERO s
join GENDER g on s.Gender_Id = g.IdGender
left join PUBLISHER p on s.Publisher_Id = p.Id_Publisher
join RACE r on s.Race_Id = r.Id_Race
where Gender_Name = 'Female' and Race_Name = 'Cyborg'
order by Publisher_Name asc
;
--9º
select Superhero_Name, Gender_Name, cs.Colour_Name as Skin_Color, Height_cm
from SUPERHERO s
join GENDER g on s.Gender_Id = g.IdGender
left join COLOUR cs on s.Skin_colour_Id = cs.IdColour
join HERO_ATTRIBUTE ha on s.Id_Superhero = ha.Id_Hero
where Height_cm > 300 
group by Superhero_Name, Gender_Name,cs.Colour_Name ,Height_cm
having count(ha.Id_Attribute) > 5
;
--10º 
select Superhero_Name, Attribute_Name
from SUPERHERO s
left join HERO_ATTRIBUTE ha on s.Id_Superhero = ha.Id_Hero
left join ATTRIBUTE a on ha.Id_Attribute = a.IdAttribute
join GENDER g on s.Gender_Id = g.IdGender
join PUBLISHER p on s.Publisher_Id = p.Id_Publisher
join ALIGNMENT al on s.Alignment_Id = al.IdAlignment and Alignment_Name = 'Neutral'
where Gender_Name = 'Male' and Publisher_Name = 'Marvel Comics'
;