--1
SELECT empname,startdate - 10, startdate, startdate + 10, 
ADD_MONTHS(startdate,-6),ADD_MONTHS(startdate,6), 
ADD_MONTHS(startdate,-12),ADD_MONTHS(startdate,12) 
FROM career JOIN emp USING(empno) where empname='JOHN KLINTON';

--2
SELECT s2.startdate - s1.startdate 
FROM (SELECT startdate FROM  career JOIN emp USING(empno) WHERE empname='JOHN MARTIN') s1, 
(SELECT startdate FROM  career JOIN emp USING(empno) WHERE empname='ALEX BOUSH') s2;

--3
SELECT startdate, enddate,FLOOR(MONTHS_BETWEEN(enddate, startdate)) months, 
FLOOR(MONTHS_BETWEEN(enddate, startdate)/12) years 
FROM career JOIN emp USING(empno) WHERE empname='JOHN MARTIN';

--4
SELECT empname, LEAD (startdate) over (ORDER BY startdate) - startdate as interval 
FROM career JOIN emp USING(empno) JOIN dept USING(deptno) WHERE deptno= 20;

--5
SELECT startdate, ADD_MONTHS(TRUNC(startdate, 'Y'), 12) - TRUNC(startdate, 'Y') as days_in_year 
FROM career ;

--6
SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'hh24')) hours, TO_NUMBER(TO_CHAR(SYSDATE, 'mi')) minutes,
       TO_NUMBER(TO_CHAR(SYSDATE, 'ss')) seconds, TO_NUMBER(TO_CHAR(SYSDATE, 'dd')) day,
       TO_NUMBER(TO_CHAR(SYSDATE, 'mm')) month,  TO_NUMBER(TO_CHAR(SYSDATE, 'yyyy')) year 
FROM dual;

--7
SELECT TRUNC(SYSDATE, 'mm') firstday,
LAST_DAY(SYSDATE) lastday 
FROM dual;

--8
SELECT ROWNUM, ADD_MONTHS(TRUNC(SYSDATE,'Y'), (ROWNUM - 1) * 3) start_of_qaurter,
ADD_MONTHS(TRUNC(SYSDATE,'Y'), ROWNUM * 3) end_of_qaurter 
FROM emp WHERE ROWNUM <= 4;

--9
SELECT * FROM (SELECT (TRUNC(SYSDATE,'Y') + (LEVEL - 1)) mondays 
FROM dual 
CONNECT BY LEVEL <= ADD_MONTHS(TRUNC(SYSDATE,'Y'),12) - TRUNC(SYSDATE,'Y'))
WHERE TO_CHAR( mondays, 'DY') = 'MON';

--10

SELECT 
MAX(CASE week_day WHEN 2 THEN day_number end) monday,
MAX(CASE week_day WHEN 3 THEN day_number end) tuesday,
MAX(CASE week_day WHEN 4 THEN day_number end) wednesday,
MAX(CASE week_day WHEN 5 THEN day_number end) thursday,
MAX(CASE week_day WHEN 6 THEN day_number end) friday,
MAX(CASE week_day WHEN 7 THEN day_number end) saturday,
MAX(CASE week_day WHEN 1 THEN day_number end) sunday 
FROM (SELECT * 
FROM(
SELECT TRUNC(SYSDATE, 'mm')+level-1 month_date,
TO_CHAR(TRUNC(SYSDATE, 'mm')+level-1, 'iw') week_number,
TO_CHAR(TRUNC(SYSDATE, 'mm')+level-1, 'dd') day_number,
TO_NUMBER(TO_CHAR(TRUNC(SYSDATE, 'mm')+level-1, 'd')) week_day,
TO_CHAR(TRUNC(SYSDATE, 'mm')+level-1, 'mm') curr_month, 
TO_CHAR(SYSDATE, 'mm') month_number 
FROM dual 
CONNECT BY level <=31) WHERE curr_month = month_number)
GROUP BY week_number ORDER BY week_number;















