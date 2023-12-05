#ORDER OF EXECUTION IN SQL
# SELECT > FROM > WHERE > GROUP BY > HAVING > ORDER BY > LIMIT----ORDER OF QUERY
#SELECT catagory,AVG(sales) AS avg_sales
#FROM salesData
#where year > 2020
#GROUP BY category,place
#HAVING count(*) > 10
#ORDER BY avg_sales
#LIMIT 3
CREATE DATABASE db3;
USE db3;
CREATE TABLE products(
order_date DATE,
sales INT
);
INSERT INTO products VALUE
('2021-01-01',20),('2021-01-02',32),('2021-02-08',45),('2021-02-04',31),
('2021-03-21',33),('2021-03-06',19),('2021-04-07',21),('2021-04-22',10);
SELECT * FROM products;

#FIND MONTHLY SALES SORT BY DESCENTING ORDER
SELECT YEAR(order_date) AS years,MONTH(order_date) AS months, SUM(sales) AS totalsales
FROM products
GROUP BY YEARS,MONTHS
ORDER BY totalsales DESC;

 
create table applications(
candidate_id int,
skills varchar(100)
);
insert into applications value
(101,'POWER BI'),(101,'PYTHON'),(101,'SQL'),(102,'TABLEAU'),(102,'SQL'),
(108,'PYTHON'),(108,'SQL'),(108,'POWER BI'),(104,'PYTHON'),(104,'EXCEL');

#FIND CANDIDATES WHO R PROFICIENT IN  PYTHON,SQL & POWER BI
#Ans: will solve in 3 steps
#1. Filter data for 3 skills (Python, SQL, and Tableau) using IN operator
#2. Find count of skills for each group using the COUNT function and group students using GROUP BY clause
#3. Finally filter the data having count = 3 and sort the output by student id

select candidate_id,count(skills) as skill_count
from applications
where skills in ('python','sql','power bi') # ACTUALLY WHERE IS NOT NEEDED
group by candidate_id
having count(skills) = 3
order by candidate_id;

/*1. If we divide 0 with a NULL, what will be the error/output
A) 0 B) NULL C) Division Error D) Query will not execute  
NOTE: Perform any operation (sum, subtract, div, multiply) with NULL value, output will be NULL

22. What are clustered and non-clustered index in SQL?
	Index is used to fetch table in a faster way which creates an extra column in the table.
	Both clustered and non-clustered indexes are used to improve the performance of database queries by providing a way to 
    quickly locate rows within a table. However, they differ in their structure and how they organize the data.
	Clustered Index: It determines the physical order of data in a table.There can be only one clustered index per table because
    it defines the actual order in which the data is stored on disk.Because of this physical ordering, the clustered index is 
    particularly efficient for range queries and for retrieving all rows
    Non-Clustered Index:
	A non-clustered index is a separate structure that stores a copy of some of the table's columns along with a reference to the 
    corresponding rows in the table.Unlike the clustered index, you can have multiple non-clustered indexes on a single table.
	Non-clustered indexes don't dictate the physical order of data; they are separate data structures that provide a way to look up rows 
	efficiently based on the indexed columns.Non-clustered indexes are typically used for improving the performance of search and filtering operations.
*/
create table employee(
empid int not null,
empname varchar(100),
gender char,
salary int,
city char(20)
);
insert into employee values
(1,'arjun','m','A75000','pune'),
(2,'ekadanta','m',125000,'bangalore'),
(3,'lalita','f',150000,'mathura'),
(4,'madhav','m',250000,'delhi'),
(5,'visakha','f',120000,'mathura');

create table EmployeeDetail(
empid int not null,
project varchar(100),
empposition char(20),
doj date
);

insert into EmployeeDetail values
(1,'p1','executive','2019-01-26'),
(2,'p2','executive','2020-05-04'),
(3,'p1','lead','2021-10-21'),
(4,'p3','manager','2019-11-29'),
(5,'p2','manager','2020-08-01');
select * from EmployeeDetail;

use db3;
show tables;

select * from employee
where salary between 200000 and 300000;
select * from employee
where salary > 200000 and salary < 300000;

#FIND THE CUMULATIVE SUM OF EMP SALARY
select empid,empname,salary,sum(salary) over (order by empid) as cumulativesal
from employee;

#WHATS THE MALE AND FEMALE EMP RATIO ?
# WE USE * IN , COUNT(*) SINCE WE HAVE NO NULL VALUES & WE CAN COUNT ANY OF THE COLUMN.OTHERWISE WE HAVE TO GIVE COLUMN NAME.
SELECT
    COUNT(*) AS total_count,
    (SUM(CASE WHEN gender = 'M' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS male_ratio,
    (SUM(CASE WHEN gender = 'F' THEN 1 ELSE 0 END) * 100.0) / COUNT(*) AS female_ratio
FROM employee;

# WRITE A QUERY TO FETCH 50% RECORDS FROM THE EMPLOYEE TABLE.
select count(empid)/2 from employee; 

select * from employee
where empid <= (select count(empid)/2 from employee);
 
select * from employee
where empid >= (select count(empid)/2 from employee);
 
#IF empid is like 001,002 etc then use below method.
SELECT * FROM (
    SELECT *, ROW_NUMBER() OVER (ORDER BY empid) AS rownumber
    FROM employee
) AS emp
WHERE emp.rownumber <= (SELECT COUNT(empid) / 2 FROM employee)
 ORDER BY emp.empid; -- Optional: If you want the result ordered by empid

#WRITE A QUERY TO RETRIEVE THE LIST OF EMPLOYEES IN THE SAME CITY
select E1.empid, E1.empname, E1.city
from employee E1, employee E2
where E1.city = E2.city and E1.empid != E2.empid;

#QUERY TO FETCH THE EMPLOYEES SALARY REPLACING LAST 2 DIGITS WITH XX
SELECT salary,
    CONCAT(LEFT(CONVERT(salary, CHAR), LENGTH(salary) - 2), 'XX') AS masked_sal
FROM employee;
/*--CONVERT(salary, CHAR): This part converts the "salary" column to a character data type. 
It's necessary because the LEFT function and CONCAT function work with character strings, and "salary" might be stored as a numeric type.
--LENGTH(salary) - 2: This calculates the length of the "salary" as a string and subtracts 2 from it. 
--LEFT(CONVERT(salary, CHAR), LENGTH(salary) - 2): This extracts the leftmost characters of the "salary" string, excluding the last two digits.
--CONCAT(LEFT(CONVERT(salary, CHAR), LENGTH(salary) - 2), 'XX'): Finally, this part concatenates the modified "salary" string */

#WRITE A QUERY TO FETCH EVEN AND ODD ROWS FROM THE EMPLOYEE TABLE.
#IF WE HAVE A NUMERIC FIELD OF AUTO INCREMENT VALUES THEN WE CAN DIRECTLY USE MOD() FUNCTION
select * from employee
where mod(empid,2) = 0; #to fetch even rows
select * from employee
where mod(empid,2) = 1; #to fetch odd rows

select * from 
(select *, row_number() over(order by empid) as rownumber
from employee) as emp
where emp.rownumber % 2 = 0;  # for even rows
select * from
(select *, row_number() over(order by empid) as rownumber
from employee) as emp
where emp.rownumber % 2 = 1; # for odd rows

select distinct empname
from employee
where lower(empname) regexp '^[aeiou]'; #NAMES STARTS WITH AEIOU( ^ is called caret symbol(character) ).

select distinct empname
from employee
where lower(empname) regexp '[aeiou]$';#NAMS ENDS WITH AEIOU.

select distinct empname
from employee
where lower(empname) regexp '^[aeiou]*[aeiou]$';

#FIND HIGHEST SALARY FROM EMPLOYEE TABLE WITH & WITHOUT USING TOP/LIMIT KEYWORDS
select salary from employee #with limit
order by salary desc
limit 1 offset 2; #THIS SKIPS FIRST 2 VALUES AND WILL GIVE NEXT 1 VALUE.
#LIMIT 1,2;IT SKIPS FIRST ROW AND GIVE 2ND & 3RD VALUES.
#LIMIT 2 OFFSET 3 : IT SKIPS FIRST 3 VALUES AND GIVE NEXT 2 VALUES.

#FIND DUPLICATE VALUES
select empid,empname,gender,salary,city,count(*) as duplicate_count
from employee
group by empid,empname,gender,salary,city
having count(*) > 1;

/*CTE=COMMON TABLE XPRESSION.The common table expression (CTE) creates a virtual table using 'WITH' clause that helps simplify a query.
Its a query that keeps referring back to its own result in a loop until it returns an empty result. CTEs work as virtual tables 
created during the execution of a query, used by the query, and eliminated after query execution.*/
#DELETE DUPLICATES
use db3;
WITH Duplicates AS (
    SELECT empid
    FROM employee
    GROUP BY empid
    HAVING COUNT(*) > 1
)
DELETE FROM employee
WHERE empid IN (SELECT empid FROM Duplicates);

#QUERY TO RETRIEVE THE LIST OF EMPLOYEES WORKING IN THE SAME PROJECT.
with CTE AS
(select e.empid, e.empname, ed.project
from employee as e
join employeedetail as ed
on e.empid = ed.empid) 
select c1.empname, c2.empname, c1.project
from CTE c1, CTE c2
where c1.project = c2.project and c1.empid < c2.empid; #IF WE USE "and c1.empid != c2.empid" THEN REPEATATION HAPPENS. 

#SHOW THE EMPLOYEE WITH HIGHEST SALARY FOR EACH PROJECT
select ed.project, max(e.salary) as projectmaxsalary, sum(e.salary) as projecttotalsalary , count(*)
from employee as e
inner join employeedetail as ed 
on e.empid = ed.empid
group by project
order by projectmaxsalary desc;

#SALAY AT ANY RANK.
with CTE as
(select project, empname, salary,
row_number() over (partition by project order by salary desc) as row_rank
from employee as e
inner join employeedetail as ed
on e.empid = ed. empid)
select project, empname, salary from CTE 
where row_rank = 1;

#FIND THE TOTAL COUNT OF EMPLOYEE JOINED EACH YEAR
SELECT YEAR(doj) AS joinyear, COUNT(*) AS empcount  #"EXTRACT(YEAR FROM doj)" also can be used instad of "YEAR(doj)"
FROM employee AS e
INNER JOIN employeedetail AS ed ON e.empid = ed.empid
GROUP BY joinyear
ORDER BY empcount ASC;

#CREATE 3 GROUPS BASED ON SALARY COLUMN,SALARY LESS THAN 1LAKH IS LOW, BETWEEN 1 TO 2 LAKH IS MEDIAM AND ABOVE 2 IS HIGH.
select empname, salary,
	case
		when salary > 200000 then 'high'
        when salary >= 100000 and salary <= 200000 then 'medium'
        else 'low'
	end as salaryStatus
from employee;

#Query to pivot the data in the employee table and retrieve the total salary
#THE RESULT SHOULD DISPLAY THE EMPID, EMPNAME AND SEPERATE COLUMN FOR EACH CITY,CONTAINING THE CURRESPONDING TOTAL SALARY.
select empid,empname,
sum(case when city = 'mathura' then salary end) as 'mathura',
sum(case when city = 'pune' then salary end) as 'pune',
sum(case when city = 'delhi' then salary end) as 'delhi'
from employee
group by empid,empname;  