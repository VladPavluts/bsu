--1
SELECT CASE GROUPING(deptname) 
WHEN 0 THEN deptname 
ELSE 'Total' 
END deptname, 
COUNT(empno) emp_count 
FROM career JOIN dept USING(deptno) JOIN EMP USING(empno) 
GROUP BY ROLLUP(deptname); 

--2
SELECT deptname, jobname, 
CASE GROUPING(deptname) || GROUPING(jobname) 
WHEN '00' THEN 'TOTAL BY DEPT AND JOB' 
WHEN '10' THEN 'TOTAL BY JOB' 
WHEN '01' THEN 'TOTAL BY DEPT' 
WHEN '11' THEN 'GRAND TOTAL for TABLE' 
END category, 
COUNT(empno) enp_count 
FROM career JOIN dept USING(deptno) JOIN emp USING(empno) JOIN job USING(jobno) 
GROUP BY CUBE(deptname, jobname) 
ORDER BY GROUPING(deptname), GROUPING(jobname); 

--3
SELECT deptname, jobname, 
CASE GROUPING(deptname) || GROUPING(jobname) 
WHEN '00' THEN 'TOTAL BY DEPT AND JOB' 
WHEN '10' THEN 'TOTAL BY JOB' 
WHEN '01' THEN 'TOTAL BY DEPT' 
WHEN '11' THEN 'GRAND TOTAL for TABLE' 
END category, 
SUM(salvalue) salary 
FROM career JOIN dept USING(deptno) JOIN emp USING(empno) JOIN job USING(jobno) JOIN salary USING(empno) 
GROUP BY CUBE(deptname, jobname) 
ORDER BY GROUPING(deptname), GROUPING(jobname); 

--4
SELECT deptname, jobname, SUM(salvalue) salary, 
GROUPING(deptname) dept_subtotal, 
GROUPING(jobname) job_subtotal 
FROM career JOIN dept USING(deptno) JOIN emp USING(empno) JOIN job USING(jobno) JOIN salary USING(empno) 
GROUP BY CUBE(deptname, jobname); 

-- 5.
----1
SELECT empname, deptname, COUNT(empno) OVER(PARTITION BY deptname) deptname_emp_count, 
jobname, COUNT(jobname) OVER(PARTITION BY jobname) jobname_emp_count, 
COUNT(*) OVER() total 
FROM career JOIN dept USING(deptno) JOIN emp USING(empno) JOIN job USING(jobno); 

----2 
SELECT startdate, salvalue,  
SUM(salvalue) OVER (ORDER BY startdate RANGE BETWEEN 90 PRECEDING AND CURRENT ROW) SPENDING_PATTERN 
FROM career JOIN emp USING(empno) JOIN salary USING(empno); 

----3
SELECT jobname, num_emps, SUM(ROUND(PCT)) pct_of_all_salaries 
FROM ( 
SELECT jobname, COUNT(*)OVER(PARTITION BY jobname) num_emps, 
RATIO_TO_REPORT(salvalue) OVER()*100 PCT 
FROM career JOIN job USING(jobno) JOIN emp USING(empno) JOIN salary USING(empno) 
) 
GROUP BY jobname, num_emps; 











