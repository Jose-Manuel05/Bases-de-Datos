--144º
insert into STUDENT_SUBJECT (DNIStudent, NumSubject, Mark, YearCourse)
values(
	(select DNI
	 from STUDENT
	 where NameStudent = 'Rosa' and Surname1 = 'Blanco' and Surname2 = 'Montero'),(
		 select NumSubject
		 from SUBJECT
		 where NameSubject = 'Lenguaje de marcas'),6, 2020)

select mark, YearCourse
from STUDENT_SUBJECT

--147º
select NameSubject as Subject, HoursSubject as Hours
from SUBJECT
where HoursSubject > (
	select HoursSubject
	from SUBJECT
	where NameSubject = 'Lenguaje de marcas')

--148º
select CONCAT(NameStudent,' ',Surname1,' ',Surname2) as STUDENT, Mark
from STUDENT s
join STUDENT_SUBJECT ss on s.DNI = ss.DNIStudent
join SUBJECT su on ss.NumSubject = su.NumSubject
where su.NameSubject = 'Acceso a datos' and YearCourse = '2018' and Mark = (
	select MAX(ss2.Mark)
	from STUDENT_SUBJECT ss2
	join SUBJECT su2 on ss2.NumSubject = su2.NumSubject
	where NameSubject = 'Acceso a datos' and ss2.YearCourse = 2018)

--149º
select NameStudent, Surname1, NameSubject, Mark
from STUDENT st
join STUDENT_SUBJECT ss on st.DNI = ss.DNIStudent
join SUBJECT su on ss.NumSubject = su.NumSubject
where YearCourse = 2019 and Mark > (
	select AVG(ss2.Mark)
	from STUDENT_SUBJECT ss2
	where YearCourse = '2019')

--150º
select Name, Surname1, YearCourse
from TEACHER t
join TEACHER_SUBJECT ts on t.DNI = ts.DNITeacher
where NumSubject = (
	select ts2.NumSubject
	from TEACHER_SUBJECT ts2
	join TEACHER t2 on ts2.DNITeacher = t2.DNI
	where Name = 'Antonio' and Surname1 = 'Martínez' and YearCourse = '2017')

--151º
select NameStudent, Surname1, count(DayAbsence) as DayAbsence
from STUDENT s
join STUDENT_ABSENCE sa on s.DNI = sa.DNIStudent
join SUBJECT su on sa.numsubject = su.NumSubject
where NameSubject = 'Despliegue de aplicaciones web'
group by NameStudent, Surname1
having count(DayAbsence) > (
	select count(sa2.DayAbsence)
	from STUDENT_ABSENCE sa2
	join STUDENT s2 on sa2.DNIStudent = s2.DNI
	where s2.NameStudent = 'Pilar' and s2.Surname1 = 'Cea')

--152º
select NameStudent, Surname1, Mark, NameSubject
from STUDENT st
join STUDENT_SUBJECT ss on st.DNI = ss.DNIStudent
join SUBJECT su on ss.NumSubject = su.NumSubject
where YearCourse = 2019 and Mark = (
	select MAX(Mark)
	from STUDENT_SUBJECT
	where YearCourse = '2019')