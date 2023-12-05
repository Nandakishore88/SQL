#VIDEO 1
#select greatest(100,50,56) OUTPUT WILL BE 100
#select least(44,56,22) OUTPUT WILL BE 22
#SELECT least('akash','vayu','darthi') OUTPUT WILL BE 'akash' and greatest is vayu.

/*SELECT * FROM student WHERE EXISTS (SELECT age FROM student WHERE age > 25);
select * from customer where excists
(select * from customer where customer_id = '001929').IT RETURN ALL FROM CUSTOMER IF THERE IS AN ID='001929'
select * from customer where not exists
(select * from orders where customer.cust_id = order.cust_id).IT RETURNS ONLY THOSE RECORDS NOT IN THE SUBQUERY
*/

/*CASE,VIEW,WINDOW,CTE
VIEW FUNCTION : VIEW IS A VIRTUAL TABLE.USING THIS WE CAN RESTRICT THE sensitive info FROM NORMAL USERS AND CAN GIVE VIEW 
TABLE WHICH CONTAIN ONLY NECESSARY COLUMNS.MAIN THING IS UPDATION OF ANY OF THE TABLE WILLL AFFECT BOTH.
create VIEW empview as
select ename,job,depno from emp where sal>=20000;

MORE THAN 1 TABLE USING JOIN:
create view empview2 as 
select e.ename,e.job,d.depno,d.depname, from emp e join dept d on e.deptno = d.deptno where salary>20000;

DROP VIEW TABLE : drop view empview;
*/


/*
WINDOW FUNCTIONS
AGGREGATE:SUM,AVG,MIN,MAX,COUNT.These functions can be used as window functions when combined with the OVER() clause.
RANKING: ROW_NUMBER , RANK 1 2 2 4 4 4 7 8 , DENSE_RANK 1 2 2 3 3 3 4 , PERCENT_RANK
VALUE/ANALYTIC: LEAD,LAG,FIRST_VALUE,LAST_VALUE
EG FOR LEAD AND LAG : select emp_sal,
LEAD(emp_sal,2) OVER (ORDER BY emp_sal) AS 'lead_by 2'
LAG(emp_sal,2) OVER (ORDER BY emp_sal) AS 'lag_by 2'
from test_data

A window function/analytic or OLAP (Online Analytical Processing) function, is a type of SQL function 
that performs a calculation across a set of rows related to the current row . Window functions operate in a "window" or a
"frame" of rows & OVER() clause is used to define the window.They are especially valuable when you need to perform calculations
that involve aggregations or comparisons within a specific subset of rows, without collapsing the result set.
Eg:
1.ROW_NUMBER(): Assigns a unique integer value to each row within a result set based on a specified ordering.
2.RANK() and DENSE_RANK(): Assigns a rank to each row based on a specified ordering, with the option to handle tied values differently.
3.NTILE(n): Divides the result set into 'n' approximately equal parts and assigns a group number to each row indicating its percentile group.
4.FIRST_VALUE() and LAST_VALUE(): Retrieve the first or last value in a window.*/

create database db4;
use db4;
create table travel (
source char(50),
destination char(50),
distance int not null
);
insert into travel value
('MUMBAI','BANGALORE',500),
('BANGALORE','MUMBAI',500),
('DELHI','MATHURA',150),
('MATHURA','DELHI',150),
('NAGPUR','PUNE',500),
('PUNE','NAGPUR',500);
select * from travel;
#method 1:using greatest and least function.
select greatest(source,destination),least(source,destination),max(distance)
from travel
group by greatest(source,destination),least(source,destination);

#USING INNER JOIN
WITH CTE as
(
select *, row_number() over() as sno
from travel
)
select t1.*
from CTE as t1 
join CTE as t2
on t1.source = t2.destination and t1.sno < t2.sno; 


#SQL USED TO FETCH DATA FROM THE DATABASE.

/*MIXED QUERIES :
FETCH RECORDS FROM TABLE A NOT IN TABLE B WITHOUT USING 'NOT IN ' OPERATOR.
select * from table A
MINUS
select * from table B;

FIND EMPLOYEES HAVING SAME EMAIL AND NAME
select name,email,count(*)
from employee
group by name,email
having count(*) >1;

FIND 10 EMPLOYEES WITH EMP ID as ODD NO.
select * from employee where ID % 2 = 1 AND ROWNUM < 11.
OR ID % 2 <> 0

GET THE QUARTER FROM DATE
select to_char(to_date('31/3/2016','DD/MM/YYYY'),'Q') as quarter
from DATETABLE; # 'TO DATE' is to convert date into date format and 'to char 'is to convert that into charactor and 'Q' is QUARTER.

select TO_CHAR(TO_DATE('03-03-22'),'YEAR') FROM employee

Normalization is used for the faster insertion,updation and deletion of anomalies, 
and when data consistency are necessarily required.It involves dividing a database into two 
or more tables and defining relationships between them. On the other hand, Denormalization 
is used when the faster search is important and to optimize the read performance.
Norm. remove redundancy.Denorm bring redundancy. 

PLSQL : Using PLSQL we can use sql as programming lang like IF,WHILE LOOP,FOR LOOP etc.
Cross Join : Cartition of 2 tables.Eg: If we have 2 shirts and 3 pants we can make 2*3 combinations.
*/
