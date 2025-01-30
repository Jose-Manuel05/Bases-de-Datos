--153º
select CONCAT(name,' ',surname1,' ',surname2) as Teacher, name_subject
from MEMBER m
join TEACHER_DEPARTMENT td on m.id_member = td.id_teacher
join SUBJECT s on td.id_teacher = s.id_teacher
where td.id_depart = (
	select td2.id_depart
	from MEMBER m2
	join TEACHER_DEPARTMENT td2 on m2.id_member = td2.id_teacher
	where name = 'Esther' and surname1 = 'Spencer') 

--154º
select name, surname1, surname2, name_subject
from MEMBER m
join STUDENT_SUBJECT ss on m.id_member = ss.id_student
join SUBJECT s on ss.id_subject = s.id_subject
join COURSE c on ss.id_course = c.id_course
where name_subject = (
	select name_subject 
	from MEMBER
	where name = 'Salvador' and surname1 = 'Sánchez') and year_start = '2014' and year_end = '2015';

--155º
select name, surname1, surname2
from MEMBER m
where m.type = 'profesor' and m.id_member not in (
	select id_teacher 
	from SUBJECT 
	where id_teacher is not null
)
order by surname1 asc, surname2 asc

--156º
select concat(name,' ',surname1,' ',surname2) as Student, date_birth
from MEMBER m
where type = 'alumno' and id_member not in (
	select ss2.id_student
	from STUDENT_SUBJECT ss2)

--157º
select concat(name,' ',surname1,' ',surname2) as Teacher, name_depart
from MEMBER m
join TEACHER_DEPARTMENT td on m.id_member = td.id_teacher
join DEPARTMENT d on td.id_depart = d.id_depart
where td.id_depart = (
	select td2.id_depart
	from MEMBER m2
	join TEACHER_DEPARTMENT td2 on m2.id_member = td2.id_teacher
	where m2.name = 'Aitor' and m2.surname1 = 'Menta')
	