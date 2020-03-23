--1
SELECT CEIL(ROW_NUMBER()OVER(ORDER BY empno)/3.0) groups, empno, empname FROM emp;

--2
SELECT NTILE(5) OVER(ORDER BY empno) groups, empno, empname FROM emp;

--3
SELECT deptno, LPAD('*', COUNT(*), '*') count FROM career GROUP BY deptno ORDER BY count;

--4
SELECT 
MAX(deptno10) d10, 
MAX(deptno20) d20, 
MAX(deptno30) d30, 
MAX(deptno40) d40 
FROM ( 
SELECT ROW_NUMBER()OVER(PARTITION BY deptno ORDER BY empno) rn, 
CASE WHEN deptno=10 THEN '*' ELSE NULL END deptno10, 
CASE WHEN deptno=20 THEN '*' ELSE NULL END deptno20, 
CASE WHEN deptno=30 THEN '*' ELSE NULL END deptno30, 
CASE WHEN deptno=40 THEN '*' ELSE NULL END deptno40 
FROM career 
) 
GROUP BY rn 
ORDER BY 1 DESC, 2 DESC, 3 DESC, 4 DESC; 