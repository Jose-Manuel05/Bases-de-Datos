--8º
WITH PassedSubjects AS (
    SELECT DNIStudent, COUNT(NumSubject) AS TotalSubjects, SUM(CASE WHEN Mark >= 5 THEN 1 ELSE 0 END) AS PassedSubjectsCount
    FROM STUDENT_SUBJECT
    WHERE YearCourse = '2023'
    GROUP BY DNIStudent
    HAVING COUNT(NumSubject) = SUM(CASE WHEN Mark >= 5 THEN 1 ELSE 0 END)
),
StudentGPA AS (
    SELECT ss.DNIStudent, s.NameStudent, s.Surname1, s.Surname2, AVG(ss.Mark * 1.0) AS GPA
    FROM STUDENT_SUBJECT ss
    JOIN STUDENT s ON ss.DNIStudent = s.DNI
    WHERE ss.YearCourse = '2023' AND ss.DNIStudent IN (SELECT DNIStudent FROM PassedSubjects)
    GROUP BY ss.DNIStudent, s.NameStudent, s.Surname1, s.Surname2
)
SELECT TOP 3 NameStudent + ' ' + Surname1 + COALESCE(' ' + Surname2, '') AS FullName, GPA
FROM StudentGPA
ORDER BY GPA DESC;

--9º
SELECT ss.NumSubject, su.NameSubject, ss.YearCourse, COUNT(DISTINCT ss.DNIStudent) AS TotalStudents, CAST(AVG(ss.Mark * 1.0) AS DECIMAL(5, 1)) AS AverageMark
FROM STUDENT_SUBJECT ss
JOIN SUBJECT su ON ss.NumSubject = su.NumSubject
GROUP BY ss.NumSubject, su.NameSubject, ss.YearCourse
ORDER BY ss.NumSubject, ss.YearCourse;
