


#The Report
##Hackerrank_challenge

--Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students 
--who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is
--more than one student with the same grade (8-10) assigned to them,order those particular students by their name alphabetically. Finally, 
--if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student 
--with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

SELECT
    CASE WHEN Grades.Grade < 8 THEN NULL ELSE stu.Name END AS Name,
    Grades.Grade,
    stu.Marks
FROM
    Students stu INNER JOIN Grades ON stu.Marks BETWEEN Grades.Min_Mark and Grades.Max_Mark
ORDER BY
    Grades.Grade DESC,
    Name,
    stu.Marks
