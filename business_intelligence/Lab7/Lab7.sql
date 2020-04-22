--1
SELECT emp1.empname || ' works for ' || emp2.empname AS emp_manager 
FROM emp emp1, emp emp2 
WHERE emp1.manager_id = emp2.empno;

--2
SELECT empname || ' reports to ' || PRIOR empname AS walk_top_down 
FROM emp 
CONNECT BY PRIOR empno = manager_id 
START WITH manager_id is null; 

--3
SELECT LTRIM(SYS_CONNECT_BY_PATH(empname, '->'), '->') LEAF__BRANCH__ROOT 
FROM emp WHERE LEVEL = 3 
CONNECT BY PRIOR manager_id = empno 
START WITH empname= 'CLARK'; 

--4
SELECT LTRIM(SYS_CONNECT_BY_PATH(empname, '->'), '->') EMP_TREE 
FROM emp CONNECT BY PRIOR empno= manager_id 
START WITH manager_id is null; 

--5
SELECT LPAD('_', LEVEL - 1, '_') || empname Org_Chart  
FROM emp CONNECT BY PRIOR empno = manager_id 
START WITH manager_id is null; 

--6
SELECT empname 
FROM emp CONNECT BY PRIOR empno = manager_id 
START WITH empname= 'ALLEN'; 
