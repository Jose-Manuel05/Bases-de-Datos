--1º
select name, surname1, surname2
from students
where phone_number is null and type = 'alumno'

--2º
select name
from member mem
join teacher_deparment td on mem.id_member = td.id_teacher
join deparment dep on td.id_depart = dep.id_dpeart
where name_depart = 'Informática'

--3º
select name
from students st
join student_subject ss on st.id_member = ss.id_student
join course co on ss.id_course = co.id_course
where year_start = '2014' and year_end = '2015'

--4º
select name 
from stundets s
join student_subject ss on s.idmember = ss.id_student
join subject su on ss.id_subject = su.id_subject
join course co on ss.id_course = co.id_course
where sub.name = 'Física para informática' and year_start = '2014' and year_end = '2015'

--5º
select name_subject
from subject su
join degree de on su.id_degree = de.id_degree
join student_subject ss on su.id_subject = ss.id_subject
where name_degree = 'Grado en Biotecnología (Plan 2005)' 

--6
select name
from subject su
join degree de on su.id_degree = de.id_degree
join student_subject ss on su.id_subject = ss.id_subject
where name_subject = 'Grado en Ingeniería informática (Plan 2015)' and type = 'obligatoria'

--7
select name_subject
from subject su
join teacher_department td on  su.id_teacher = td.id_teacher
join member me on td.id_teacher = me.id_member
where name = 'Zoe Ramirez'

--8
select count(id_member) as Total_Member
from member me
join student_subject ss on me.id_member = ss.id_student
join course co on ss.id_course = co.id_course
where year_start = '2014' and year_end = '2015'

--9
select count(id_member) as total_member
from member me
join teahcer_deparment dp on me.id_member = dp.id_teacher
join deparment de on dp.id_depart = de.id_depart
where name_depart = 'Biología' or name_depart = 'Geologia'

--10
select name_degree
from degree de
join subject su on de.id_degree = su.id_degree
join teahcer_deparment dp on su.id_teacher = dp.id_teacher
join member me on dp.id_teacher = me.id_member
where name = 'Armando' and surname1 = 'Bronca' and surname2 = 'Segura'

--11
select count(id_student) as total_students
from member me
join student_subject ss on me.id_member = ss.id_student
where name = 'Manolo' and surname1 = 'Hamill' and surname2 = 'Kozey'

--12
select year_end
from member me
join student_subject ss on me.id_member = ss.id_student
join course co on ss.id_course = co.id_course
where concat(name,' ',surname1,' ',surname2) = 'Pedro Heller Pagac'

--13
select concat(id_student) as total_students
from studetn_subject ss
join subject su on ss.id_subject = su.id_subject
join teacher_depart td on su.id_teacher = td.id_teahcer
join member me on td.id_teacher = me.id_member
where phone_no = '618223876'