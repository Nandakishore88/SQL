#VARCHAR(SIZE) - VARIABLE LENGTH STRING (Letter,number,special characters)
#INT - INTEGER
#FLOAT(size,d) - Floating Point Number
#DOUBLE(Size.d) - Floatin Point Number(Large Number)
#BOOLEAN - TRUE(NONZERO) or FALSE(ZERO)
#DATE - Date(YYYY-MM-DD)

CREATE DATABASE db1;
CREATE DATABASE db2;
DROP DATABASE db2;
USE db1;
CREATE TABLE student(
student_id VARCHAR(10) NOT NULL,
student_name VARCHAR(100) NOT NULL,
age INT NOT NULL,
place VARCHAR(100) NOT NULL,
PRIMARY KEY (student_id)
);

CREATE TABLE test(
student_id VARCHAR(10) NOT NULL,
student_name VARCHAR(100) NOT NULL,
age INT NOT NULL,
place VARCHAR(100) NOT NULL,
PRIMARY KEY (student_id)
);

DROP TABLE test;
SELECT * FROM student;
INSERT INTO student VALUE
('S1','AKHIL',29,'TVM');
INSERT INTO student VALUE
('S2','nandan',22,'ERM'),
('S3','ROHAN',23,'TSR'),
('S4','SUSHI',27,'KZD'),
('S5','KISHORE',25,'KNR');
SELECT * FROM STUDENT;

UPDATE student
SET place = 'kottayam'
WHERE student_id = 's4';
SELECT * FROM student;

CREATE TABLE student1 LIKE student;
INSERT student1 SELECT * FROM student;
SELECT * FROM student1;

DELETE FROM student1
WHERE student_id = 's2';
SELECT * FROM student1;

SELECT student_id,student_name FROM student;

SELECT * FROM student
WHERE place = 'knr';
SELECT * FROM student
WHERE age < 25;

INSERT INTO student VALUES
('S6','ROOPESH',26,'ERM'),
('S37','GEETHA',20,'TSR');

SELECT DISTINCT place
FROM student;

SELECT * FROM student
ORDER BY student_name ASC;
SELECT * FROM student
ORDER BY age DESC;

ALTER TABLE student
ADD contact INT(10) NOT NULL;
SELECT* FROM student;
ALTER TABLE student
MODIFY contact VARCHAR(10) NOT NULL;
ALTER TABLE student
RENAME COLUMN contact TO student_contact;
ALTER TABLE student
DROP COLUMN student_contact;
SELECT * FROM student;

TRUNCATE student1;# TRUNCATE TABLE student1;TO EMPTY THE TABLE.
SELECT * FROM student1;
DROP TABLE STUDENT1;#TO DELETE ENTIRE TABLE
#When you use DROP, the table and all its data permanently deleted.It's a DDL.
#When you use DELETE, the rows specified by the WHERE clause are deleted from the table, but the table itself and its structure remain intact.

USE db1;
SELECT * FROM student
ORDER BY student_id ASC
LIMIT 2;
SELECT * FROM student
ORDER BY student_name DESC
LIMIT 1;

SELECT * FROM student
ORDER BY rand()
LIMIT 3;#ANY RANDOM RAWS

SELECT STUDENT_NAME AS 'first name',
age AS student_age,place
FROM student;

 #OPERATORS#
 SELECT 10 * 20 AS result;
 SELECT 52 % 5 AS output;
 
 #COMPARISON OPERATORS#
 SELECT 10 = 10 AS RESULT;
 SELECT 51 = 55 AS result;
 SELECT 55 >= 54 AS result;
 SELECT 88 <= 82 AS result;
 SELECT 77 <> 76 AS result;#NOT EQUAL TO
 
 USE db1;
 SELECT * FROM student
 WHERE age = 22;
 SELECT * FROM student
 WHERE student_id <> 's1';
 
 #LOGICAL OPERATORS#
 SELECT * FROM student
 WHERE age = 23 AND place = 'tsr';
 SELECT * FROM STUDENT
 WHERE place = 'knr' OR age = 23;
 SELECT * FROM student
 WHERE age BETWEEN 22 AND 30;
 SELECT * FROM student
 WHERE EXISTS (SELECT age FROM student WHERE age > 25);
 SELECT * FROM student
 WHERE place IN ('KNR','TVM');
 SELECT * FROM student
 WHERE student_name LIKE 'geetha';
 SELECT * FROM student
 WHERE student_name LIKE '%a%';#SIMILLARLY "%D","S%", NOT LIKE "HAP%" ETC.
 # "WHERE age NOT LIKE 29 OR 20;" WILL NOT WORK,FOR NUMBERS ARITHMATIC OPERATORS NEEDED.

#CHARACTER LENTH
SELECT * FROM student;
SELECT student_name,char_length(student_name) AS length 
FROM student;
SELECT * FROM student;
SELECT concat(student_name, '  ' ,place) AS stud_place
FROM student; 

#FORMAT# 
SELECT format(2565.45865, 2) AS rounded;

#INSERT#
SELECT insert('google',1,1,'t');
SELECT insert('windows',1,3,'ddd');
SELECT upper('helllo world') AS new_str;
SELECT reverse('SQL') ;
SELECT repeat('hai',5) AS p;
SELECT left('good vibe',6) ;
SELECT length('fu');

/* MATHEMATICAL FUNCTIONS*/
SELECT abs(-566);
SELECT avg(age) AS AGE_AVG FROM student;
SELECT ceiling(23.1);#SAME FOR 26.9
SELECT floor(28.8);
SELECT round(46.3);
SELECT round(23.489,2);  
SELECT count(student_id) FROM student;
SELECT MAX(age) FROM student;
SELECT MIN(age) from student;
SELECT pi();
SELECT rand() ;
SELECT rand()*11;#GIVES NO. BETWEEN 1 TO 10
SELECT floor(rand()*5);# gives decimal no. 
SELECT sqrt(6);
SELECT SUM(age) FROM student;

/*DATE FUNCTION*/
SELECT current_timestamp();
SELECT day('2008/6/5');
SELECT month('2008/4/6');
SELECT dayname('2008/6/15');
SELECT sysdate();
SELECT curdate();
SELECT now();


USE db1;
CREATE TABLE courses(
course_id VARCHAR(5) NOT NULL,
course_name VARCHAR(50) NOT NULL,
PRIMARY KEY (course_id)
);

INSERT INTO courses
VALUES
('c1','COMP HARDWARE'),
('C2','NETWORKING'),
('C3','WEB DESIGNING'),
('C4','GRAPHIC DESIGN'),
('C5','C'),
('C6','PYTHON'),
('C7','MS OFFICE');
SELECT *  FROM COURSES;

CREATE TABLE enrolment(
enrolment_id VARCHAR(100) NOT NULL,
student_id VARCHAR(10),
course_id VARCHAR(10),
PRIMARY KEY (enrolment_id),
FOREIGN KEY (student_id) REFERENCES student(student_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

USE db1;
UPDATE student
SET student_id = 's7'
WHERE student_id = 's37';
SELECT * FROM student;

INSERT INTO enrolment
VALUES
('e1','s1','c1'),
('e2','s7','c4'),
('e3','s6','c2'),
('e4','s5','c1'),
('e5','s4','c5'),
('e6','s1','c4'),
('e7','s2','c6');

#SQL JOINS
#SQL JOIN statement is used for combine rows/datas from two or more tables, based on a common field between them.

#INNER JOIN: Returns records that have matching values in both tables.

#LEFT [OUTER] JOIN: Returns all records from the left table and matched records from the right table.

#RIGHT [OUTER] JOIN: Returns all records from the right table and matched records from the left table.

#FULL [OUTER] JOIN: Returns all the records from all tables.

CREATE DATABASE db2;
USE db2;
CREATE TABLE country(
country_code VARCHAR(10) NOT NULL,
country_name VARCHAR(100),
PRIMARY KEY(country_code)
);

SELECT * FROM country;
INSERT INTO country
VALUES
('IN','INDIA'),
('SL','SRILANKA'),
('PK','PAKI'),
('BN','BANGLADESH'),
('NP','NEPAL');

CREATE TABLE capital(
capital_id VARCHAR(10) NOT NULL,
country_code VARCHAR(10),
capital_name VARCHAR(100),
PRIMARY KEY (capital_id),
FOREIGN KEY (country_code) REFERENCES country(country_code)
);

INSERT INTO capital
VALUES
('c1','IN','NEW DELHI'),
('c2','PK','ISLAMABADH'),
('c3','NP','KADMANDU');
SELECT * FROM capital;

#INNER JOIN
SELECT * FROM country INNER JOIN capital
ON country.country_code = capital.country_code;  

SELECT country.country_name, capital.capital_name
FROM country INNER JOIN capital
ON country.country_code = capital.country_code; 

#LEFT JOIN
SELECT *  FROM country LEFT JOIN capital #LEFT JOIN OR LEFT OUTER JOIN
ON country.country_code = capital.country_code;

#RIGHT JOIN
SELECT * FROM country RIGHT JOIN capital
ON country.country_code = capital.country_code;

#FULL JOIN IS NOT SUPPORTED BY MYSQL.SO USE UNION OPERATOR AND COMBINE LEFT AND RIGHT JOIN
SELECT *  FROM country LEFT JOIN capital #LEFT JOIN OR LEFT OUTER JOIN
ON country.country_code = capital.country_code
UNION
SELECT * FROM country RIGHT JOIN capital
ON country.country_code = capital.country_code;

# IF FUNCTION
SELECT if(10 > 20 , 'value1','value2') AS result;
USE db1;
SELECT student_name,age,
if(age>=18,'adult','minor') AS student_type
FROM student;

SELECT ifnull(null,'hello') AS result; #result is hello
SELECT ifnull(2,'hello') AS result; #result will be 2

USE db2;
SELECT *  FROM country LEFT JOIN capital #LEFT JOIN OR LEFT OUTER JOIN
ON country.country_code = capital.country_code;

/*CASE FUNCTION*/
USE db2;
SELECT country_name,
CASE
	WHEN country_name = 'India' THEN 'Hindi'
    WHEN country_name = 'Paki' THEN 'Urdu'
    WHEN country_name = 'Nepal' THEN 'Nepali'
    WHEN country_name = 'SRILANKA' THEN 'Simhala'
    ELSE 'Bengali'
END AS Official_lang
FROM country;
SELECT