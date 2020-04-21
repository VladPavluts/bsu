--1
SELECT empname,jobname, salvalue, 
SUM(salvalue) OVER(PARTITION BY empname ORDER BY empname 
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumulative_salvalue 
FROM emp JOIN career USING(empno) JOIN salary USING(empno) JOIN job USING(jobno); 

--2
SELECT startdate, salvalue, 
SUM(salvalue) OVER (ORDER BY startdate RANGE BETWEEN 90 PRECEDING AND CURRENT ROW) SPENDING_PATTERN 
FROM career JOIN emp USING(empno) JOIN salary USING(empno) WHERE year=2010;

--3
SELECT empname,
AVG(salvalue) OVER(PARTITION BY empname ORDER BY empname 
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) avg_salvalue 
FROM emp JOIN career USING(empno) JOIN salary USING (empno);

--4
SELECT empname, salvalue, 
AVG(salvalue) OVER(PARTITION BY empname ORDER BY empname ROWS UNBOUNDED PRECEDING) avg_salvalue 
FROM emp JOIN career using(empno) JOIN salary USING (empno) WHERE year=2010 and month=1;