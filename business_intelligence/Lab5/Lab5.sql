--1
CREATE OR REPLACE VIEW salary_avg AS (SELECT year, AVG(salvalue) salary_avg FROM salary GROUP BY year);

SELECT RANK() OVER(ORDER BY salary_avg ) rn, salary_avg , year 
FROM salary_avg ;

--2
SELECT DENSE_RANK() OVER(ORDER BY cum_sal) rn, cum_sal, year, month 
FROM (
    SELECT month, year, SUM(salvalue) cum_sal 
    FROM salary GROUP BY year, month
    );
    
    
--3
SELECT empname, salvalue, 
        RANK() OVER(PARTITION BY empname ORDER BY year, month) rn, 
        DENSE_RANK() OVER(PARTITION BY empname ORDER BY year, month) dence_rn,
        year, 
        month 
FROM emp JOIN salary USING(empno);

--4

SELECT year, month, salary_avg, 
RANK() OVER(PARTITION BY groupr ORDER BY salary_avg DESC) salary_rank 
FROM (
SELECT year, month, 
            AVG(salvalue) salary_avg, 
            GROUPING_ID(year, month) groupr 
FROM salary GROUP BY CUBE(year, month));

--5
SELECT jobname, empname, salvalue, 
        CUME_DIST() OVER(PARTITION BY jobname ORDER BY salvalue) CUME_DIST 
FROM emp, salary, job, career 
WHERE career.empno = emp.empno AND career.empno = salary.empno AND career.jobno = job.jobno; 

--6
SELECT jobname, empname, salvalue, 
        PERCENT_RANK() OVER(PARTITION BY jobname ORDER BY salvalue) PERCENT_RANK 
FROM emp, salary, job, career 
WHERE career.empno = emp.empno AND career.empno = salary.empno AND career.jobno = job.jobno; 

--7
SELECT NTILE(3) OVER(ORDER BY empno) groups, empno, empname,birthdate FROM emp;

--8
SELECT empname,empno, ROW_NUMBER()OVER(PARTITION BY empname ORDER BY empno) rn FROM emp;






















