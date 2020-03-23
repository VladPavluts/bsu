select DEPTADDR from DEPT WHERE DEPTNAME='SALES';
select * from DEPT where DEPTADDR in('CHICAGO','NEW YORK');
select min(SALVALUE) from SALARY where YEAR=2009;
select count(*) from EMP;

select JOBNO,
case 
when JOBNAME in('DRIVER','CLERK') then 'WORKER'
else JOBNAME 
end, 
MINSALARY from JOB;

select YEAR, max(SALVALUE) from SALARY group by YEAR order by YEAR;
select YEAR, round(avg(SALVALUE),2) from SALARY group by YEAR having count(distinct MONTH)>=3;

select * from EMP cross join CAREER cross join SALARY;

select MONTH,YEAR,SALVALUE,EMPNAME from SALARY join EMP on EMP.EMPNO = SALARY.EMPNO order by EMPNAME;

select STARTDATE, ENDDATE, EMPNAME, JOBNAME, DEPTNAME 
from CAREER 
join EMP on EMP.EMPNO = CAREER.EMPNO 
join JOB on JOB.JOBNO = CAREER.JOBNO 
join DEPT on DEPT.DEPTNO= CAREER.DEPTNO;

select EMPNAME from EMP where EMPNO=(select EMPNO from SALARY where SALVALUE=(select min(SALVALUE) from SALARY));

select EMPNAME,
case 
when MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 >= 20 and MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 <= 30 
then 'возраст 20-30' 
when MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 >= 31 and MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 <= 40 
then 'возраст 31-40' 
when MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 >= 41 and MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 <= 50 
then 'возраст 41-50' 
when MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 >= 51 and MONTHS_BETWEEN(SYSDATE, BIRTHDATE) / 12 <= 60 
then 'возраст 51-60' 
else 'возраст не определен' 
end as AGE_GROUP 
from EMP;