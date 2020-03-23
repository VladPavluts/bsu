--1

SELECT SUM(CASE WHEN jobname='MANAGER' THEN 1 ELSE 0 END) AS MANAGER,
SUM(CASE WHEN jobname='PRESIDENT' THEN 1 ELSE 0 END) AS PRESIDENT,
SUM(CASE WHEN jobname='CLERK' THEN 1 ELSE 0 END) AS CLERK,
SUM(CASE WHEN jobname='DRIVER' THEN 1 ELSE 0 END) AS DRIVER,
SUM(CASE WHEN jobname='EXECUTIVE DIRECTOR' THEN 1 ELSE 0 END) AS EXECUTIVEDIRECTOR,
SUM(CASE WHEN jobname='FINANCIAL DIRECTOR' THEN 1 ELSE 0 END) AS FINANCIALDIRECTOR,
SUM(CASE WHEN jobname='SALESMAN' THEN 1 ELSE 0 END) AS SALESMAN FROM job JOIN career ON career.jobno = job.jobno;

--2
SELECT MAX(CASE WHEN deptname = 'RESEARCH' THEN empname ELSE NULL END) AS RESEARCH, 
MAX(CASE WHEN deptname = 'ACCOUNTING' THEN empname ELSE NULL END) AS ACCOUNTING, 
MAX(CASE WHEN deptname = 'OPERATIONS' THEN empname ELSE NULL END) AS OPERATIONS, 
MAX(CASE WHEN deptname = 'SALES' THEN empname ELSE NULL END) AS SALES 
FROM (
SELECT deptname , empname , ROW_NUMBER()OVER(PARTITION BY deptname ORDER BY empname) rn 
FROM emp JOIN (career JOIN dept USING(deptno)) USING(empno) 
) GROUP BY rn;

--3
SELECT j.jobname, 
CASE j.jobname 
WHEN 'CLERK' THEN emp_count.CLERK 
WHEN 'DRIVER' THEN emp_count.DRIVER 
WHEN 'EXECUTIVE DIRECTOR' THEN emp_count.EXECUTIVEDIRECTOR 
WHEN 'FINANCIAL DIRECTOR' THEN emp_count.FINANCIALDIRECTOR 
WHEN 'MANAGER' THEN emp_count.MANAGER 
WHEN 'PRESIDENT' THEN emp_count.PRESIDENT 
WHEN 'SALESMAN' THEN emp_count.SALESMAN 
ELSE NULL 
END AS counts_by_j  
FROM ( 
SELECT SUM(CASE WHEN jobname='MANAGER' THEN 1 ELSE 0 END) AS MANAGER, 
SUM(CASE WHEN jobname='PRESIDENT' THEN 1 ELSE 0 END) AS PRESIDENT, 
SUM(CASE WHEN jobname='CLERK' THEN 1 ELSE 0 END) AS CLERK, 
SUM(CASE WHEN jobname='DRIVER' THEN 1 ELSE 0 END) AS DRIVER, 
SUM(CASE WHEN jobname='EXECUTIVE DIRECTOR' THEN 1 ELSE 0 END) AS EXECUTIVEDIRECTOR, 
SUM(CASE WHEN jobname='FINANCIAL DIRECTOR' THEN 1 ELSE 0 END) AS FINANCIALDIRECTOR, 
SUM(CASE WHEN jobname='SALESMAN' THEN 1 ELSE 0 END) AS SALESMAN 
FROM job JOIN career ON career.jobno = job.jobno 
) emp_count, 
(SELECT jobname FROM job) j; 

--4
SELECT CASE rn 
WHEN 1 THEN empname 
WHEN 2 THEN jobname 
WHEN 3 THEN cast(avg_salary as char(4)) 
WHEN 4 THEN cast(deptno as char(4)) 
END emps 
FROM (
SELECT e.empname, e.jobname,e.avg_salary,e.deptno,  
ROW_NUMBER()OVER(PARTITION BY e.empno ORDER BY e.empno) rn 
FROM emps_info e, 
(SELECT * FROM emps_info) t_rows WHERE e.deptno=40 
); 

--5
SELECT DECODE(LAG(deptname) OVER(ORDER BY deptname), deptname, NULL, deptname) LAG, empname 
FROM emp JOIN (career JOIN dept USING(deptno)) USING(empno);
--6
select d30_sal - d10_sal as d30_d10_diff, 
d10_sal - d40_sal as d10_d40_diff 
from (
select sum(case when deptno = 10 then salvalue end) as d10_sal, 
sum(case when deptno = 30 then salvalue end) as d30_sal, 
sum(case when deptno = 40 then salvalue end) as d40_sal 
from emp join salary using(empno) join career using(empno) join job using(jobno) join dept using(deptno) 
) total_by_dept;

