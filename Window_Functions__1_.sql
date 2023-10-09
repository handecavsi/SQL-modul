-- WINDOW FUNCTIONS

-- SQL'de, window functions (pencere işlevleri) bir veri kümesindeki verileri gruplandırmak, sıralamak, analiz etmek ve özetlemek için kullanılan özel bir fonksiyon türüdür. 


-- <window function> ( [expression] ) OVER (
--     [PARTITION BY partition_expression, ... ]
--     [ORDER BY sort_expression [ASC|DESC], ... ]
--     [ROWS frame_specification] 
-- )

-- WINDOW FUNCTIONS WITH AGGREGATE
SELECT 
first_name,
last_name,
department_id,
AVG(salary) OVER (PARTITION BY department_id) as avg_salary
FROM employees

-- ROW_NUMBER
-- ROW_NUMBER fonksiyonu, sorgu sonucunda dönen tüm satırlarda benzersiz bir sayısal değer oluşturur ve her satıra bir sıra numarası atar.
-- ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY column_name)

select 
first_name,
last_name,
department_id,
hire_date,
ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date ASC) as rn
from employees;

-- NTILE
-- NTILE() fonksiyonu, bir veri kümesini eşit sayıda parçaya bölerek, her bir parçanın sıralama içindeki yerini belirlemek için kullanılan bir SQL pencere fonksiyonudur. 
-- NTILE(n) OVER (ORDER BY <order_sutunu>)

SELECT first_name,
last_name,
hire_date,
NTILE(10) OVER (ORDER BY hire_date) as nt
FROM employees;



-- LAG 
-- Lag, SQL'de bir önceki satırdaki değerini almak için kullanılır.
-- LAG(column_name, <offset>, <default_deger>) OVER ( PARTITION BY <partition_sutunu> ORDER BY <order_sutunu>)
--1633789

select 
contactid,
bookingdate,
LAG(bookingdate, 1 , NULL) OVER (PARTITION BY contactid ORDER BY bookingdate ) as prev_bookingdate
from booking


-- LEAD
-- LEAD fonksiyonu, bir tablodaki bir sütunun bir sonraki satırdaki değerini döndürür. Bu, LAG fonksiyonunun tam tersidir.

select 
contactid,
bookingdate,
LEAD(bookingdate, 1 , NULL) OVER (PARTITION BY contactid ORDER BY bookingdate ) as next_bookingdate
from booking




--CASES:

select * from employees limit 100
  
--1-) first_name, last_name, salary, department_id departman bazında ortalama maaş?

--1.YOL GROUP BY ile:
WITH avg_salary AS(
select 
	department_id,
	avg(salary) ort_maas
from employees
GROUP BY 1
)
SELECT 
	first_name,
	last_name,
	ort_maas,
	a.department_id
FROM employees e 
JOIN avg_salary a ON e.department_id = a.department_id

--2.YOL Window function ile:
SELECT 
	department_id,
	first_name,
	last_name,
	avg(salary) OVER (PARTITION BY department_id) ort_maas
FROM employees  

--2-)job_id bazında first_name,last_name,salary,job_id ve o job_id'de kaç kişi çalışır?

--1.YOL GROUPBY
WITH count_employee as
(
	select
		job_id,
		count(employee_id) kisi_sayisi
	from employees
	GROUP BY 1
) SELECT 
		first_name,
		last_name,
		salary,
		e.job_id,
		kisi_sayisi
  FROM employees e 
  JOIN count_employee ce 
  ON e.job_id = ce.job_id

--2.YOL WINDOW FUNC

select 
	first_name,
	last_name,
	salary,
	department_id,
	count(employee_id) OVER (PARTITION BY job_id) kisi_sayisi
FROM employees


