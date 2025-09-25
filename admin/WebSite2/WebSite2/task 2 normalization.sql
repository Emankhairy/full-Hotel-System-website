create database training_center;
use training_center;
Go

-- NORMALIZATION --

-- no repetition (multivalued attribute) in any cell so 1NF is complete and the same table no changes --

create table T_C (
student_ID varchar (30),
course_ID varchar(50),
first_name varchar(20),
last_name varchar(20),
course_name varchar(35),
marks INT,
teacher_name varchar(20),
teacher_email varchar(20),
course_numhour INT,
price_onehour decimal
);




-- student_ID and course_ID are the primary key --

-- student_name dependency of student_ID --
-- course_name + teacher_name + teacher_email dependency of course_ID --
-- grade dependency of course_ID + student_ID --

-- in 2NF , should have no Partial dependency --
-- So we will make 3 TABLES ( student table + course table + grade table ) --


-- student table --

create table student (
student_ID varchar (30),
first_name varchar(20),
last_name varchar(20)
);


-- course table --

create table course (
course_ID varchar (30),
course_name varchar(20),
teacher_name varchar(20),
teacher_email varchar(20),
course_numhour varchar(20),
price_onehour decimal
);


-- grade table --

create table grade (
student_ID varchar (30),
course_ID varchar (30),
marks INT
);




-- in 3NF , shoud have no transitive dependency --
-- NO non prime attributes depend on non prime attributes on the table --
-- teacher_email depend on teacher_name --
-- so we will break ( course table ) for 2 tables ( teacher table + course table )

-- course table --
-- we will add teacher_id and break teacher_name + teacher_email in the other table with teacher_ID --

create table S_course (
course_ID varchar (30),
course_name varchar(20),
teacher_ID varchar(20),
course_numhour varchar(20),
price_onehour decimal
);


-- Teacher table --

create table teacher (
teacher_ID varchar (30),
teacher_name varchar(20),
teacher_email varchar(20)
);



-- 1NF --

insert into T_C(student_ID,course_ID,first_name,last_name,course_name,marks,teacher_name,teacher_email,course_numhour,price_onehour)
values
('10','103','osman','tarek','ML','20','esmail','esmail12@gmail','60','60'),
('10','100','osama', 'waled','security','12','mai','mai57@gmail','70','70'),
('36','103','sara ','ali','ML','16','esmail','esmail12@gmail','60','60'),
('36','200','sara', 'Morte','network','16','ahmed','ahmed33@gmail','80','80'),
('21','103','fathia','ahmed','ML','20','esmail','esmail12@gmail','60','60'),
('21','100','fathia','waled','security','23','mai','mai57@gmail','70','70'),
('21','200','fathia','mohammed','network','23','ahmed','ahmed33@gmail','80','80'),
('11','100','noran ','omar','security','12','mai','mai57@gmail','70','80'),
('11','103','noran','ahmed','ML','10','esmail','esmail12@gmail','60','60');


-- 2NF --

-- student table --

insert into student(student_ID,first_name,last_name)
values
('10','osman','tarek'),
('10','osama', 'waled'),
('36','sara ','ali'),
('36','sara', 'Morte'),
('21','fathia','ahmed'),
('21','fathia','waled'),
('21','fathia','mohammed'),
('11','noran ','omar'),
('11','noran','ahmed');

-- course table --

insert into course(course_ID,course_name,teacher_name,teacher_email,course_numhour,price_onehour)
values
('103','ML','esmail','esmail12@gmail','60','60'),
('100','security','mai','mai57@gmail','70','70'),
('103','ML ','esmail','esmail12@gmail','60','60'),
('200','network','ahmed','ahmed33@gmail','80','80'),
('103','ML','esmail','esmail12@gmail','60','60'),
('100','security','mai','mai57@gmail','70','70'),
('200','network','ahmed','ahmed33@gmail','80','80'),
('100','security','mai','mai57@gmail','70','70'),
('103','ML','esmail','esmail12@gmail','60','60');


-- grade table --

insert into grade(student_ID,course_ID,marks)
values
('10','103','20'),
('10','100','12'),
('36','103','16'),
('36','200','16'),
('21','103','20'),
('21','100','23'),
('21','200','23'),
('11','100','12'),
('11','103','10');



-- 3NF -- 

-- course table --

insert into S_course(course_ID,course_name,teacher_ID,course_numhour,price_onehour)
values
('103','ML','55','60','50'),
('100','security','43','70','70'),
('103','ML','55','60','60'),
('200','network','38','80','80'),
('103','ML','55','60','60'),
('100','security','43','70','70'),
('200','network','38','80','80'),
('100','security','43','70','70'),
('103','ML','55','60','60');



-- Teacher table --

insert into teacher(teacher_ID,teacher_name,teacher_email)
values
('55','esmail','esmail12@gmail'),
('43','mai','mai57@gmail'),
('55','esmail','esmail12@gmail'),
('38','ahmed','ahmed33@gmail'),
('55','esmail','esmail12@gmail'),
('43','mai','mai57@gmail'),
('38','ahmed','ahmed33@gmail'),
('43','mai','mai57@gmail'),
('55','esmail','esmail12@gmail');



select * from T_C
select * from student
select * from course
select * from grade
select * from S_course
select * from teacher

--======================================================================================================================================*

-- insert and delete values --

INSERT INTO T_C(student_ID,course_ID) VALUES ('ali', 'python');
select * from T_C

DELETE FROM course WHERE course_ID = 100;
select * from course


--=======================================================================================================================================*

-- FUNCTION --

CREATE FUNCTION CalculatePrice(@price_onehour decimal(10,2),@course_numhour int)
RETURNS decimal(10,2)
AS
BEGIN
   RETURN @price_onehour * @course_numhour
END

SELECT course_name,price_onehour,course_numhour,
dbo.CalculatePrice(price_onehour,course_numhour) 
AS Total
FROM course


--=======================================================================================================================================*

-- RANSACTION --

BEGIN TRANSACTION  
 
 INSERT INTO teacher VALUES('45','hossam','hossam12@gmail') 
 UPDATE teacher SET teacher_email = 'ahmed122@gmail'  WHERE teacher_ID = 38
  
COMMIT TRANSACTION  
IF(@@ERROR > 0)  
BEGIN  
    ROLLBACK TRANSACTION  
END  
ELSE  
BEGIN  
   COMMIT TRANSACTION  
END  


select * from teacher

--=======================================================================================================================================*

-- PROCEDURE --

CREATE PROCEDURE SelectAllStudents @course_name varchar(35),@student_ID varchar (30)
AS
SELECT * FROM T_C WHERE  course_name = @course_name AND student_ID = @student_ID
GO
EXEC
SelectAllStudents @course_name = 'ML' , @student_ID ='21';

DROP PROCEDURE SelectAllStudents;
--=======================================================================================================================================*



drop table T_C
drop table student
drop table course
drop table grade
drop table S_course
drop table teacher






