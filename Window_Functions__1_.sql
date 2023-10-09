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


--ROW_NUMBER() 
--Sıralama yapmayı sağlar. Partition by'a göre verileri gruplar ve her bir grup için 1'den başlayarak sıralama yapar.
--1,2,3,4  1,2,3  1,2,3,4 gibi.

--RANK()
--Sıralama yapmayı sağlar. Partition by'a göre verileri gruplar. Bir grup içerisinde aynı tarih gibi aynı veri varsa onlara
--aynı sıra numarasını verir. 1,2,2,4 gibi. 3'ü atlar 3 yerine 2 aynı tarih bulunduğundan 2 yazar.

--DENSE_RANK()
--Sıralama yapmayı sağlar.
--Partition by'a göre verileri gruplar. Bir grup içerisinde aynı tarih gibi aynı veri varsa onlara
--aynı sıra numarasını verir. 1,2,2,3 gibi. 3'ü atlamaz ve 4.'ye 3 yazar.

--Üniversite öğrenci kayıt sisteminde ortalamalara göre bir sıralama yapılacak olsa; dense_rank() kullanılır. 2 tane aynı ortalamaya
--sahip öğrenci bulunabilir. Bunların ikisi aynı sıralamaya sahiptir. Sayı atlaması olamayacağı için rank() değil, dense_rank() 
--kullanılır.


select 
	first_name,
	last_name,
	department_id,
	hire_date,
	ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY hire_date) rn,
	RANK() OVER (PARTITION BY department_id ORDER BY hire_date) r,
	DENSE_RANK() OVER (PARTITION BY department_id ORDER BY hire_date) dr
from employees

--Output:
	
"first_name"	"last_name"	"department_id"	"hire_date"	"rn"	"r"	"dr"
"Jennifer"	"Whalen"	1		"1987-09-17"	1	1	1
"Michael"	"Hartstein"	2		"1996-02-17"	1	1	1
"Pat"		"Fay"		2		"1997-08-17"	2	2	2
"Den"		"Raphaely"	3		"1994-12-07"	1	1	1
"Alexander"	"Khoo"		3		"1995-05-18"	2	2	2
"Sigal"		"Tobias"	3		"1997-07-24"	3	3	3
"Shelli"	"Baida"		3		"1997-12-24"	4	4	4
"Guy"		"Himuro"	3		"1998-11-15"	5	5	5
"Karen"		"Colmenares"	3		"1999-08-10"	6	6	6
"Susan"		"Mavris"	4		"1994-06-07"	1	1	1
"Payam"		"Kaufling"	5		"1995-05-01"	1	1	1
"Sarah"		"Bell"		5		"1996-02-04"	2	2	2
"Matthew"	"Weiss"		5		"1996-07-18"	3	3	3
"Britney"	"Everett"	5		"1997-03-03"	4	4	4
"Adam"		"Fripp"		5		"1997-04-10"	5	5	5
"Shanta"	"Vollman"	5		"1997-10-10"	6	6	6
"Irene"		"Mikkilineni"	5		"1998-09-28"	7	7	7
"Alexander"	"Hunold"	6		"1990-01-03"	1	1	1
"Bruce"		"Ernst"		6		"1991-05-21"	2	2	2
"David"		"Austin"	6		"1997-06-25"	3	3	3
"Valli"		"Pataballa"	6		"1998-02-05"	4	4	4
"Diana"		"Lorentz"	6		"1999-02-07"	5	5	5
"Hermann"	"Baer"		7		"1994-06-07"	1	1	1
"John"		"Russell"	8		"1996-10-01"	1	1	1
"Karen"		"Partners"	8		"1997-01-05"	2	2	2
"Jonathon"	"Taylor"	8		"1998-03-24"	3	3	3
"Jack"		"Livingston"	8		"1998-04-23"	4	4	4
"Kimberely"	"Grant"		8		"1999-05-24"	5	5	5
"Charles"	"Johnson"	8		"2000-01-04"	6	6	6
"Steven"	"King"		9		"1987-06-17"	1	1	1
"Neena"		"Kochhar"	9		"1989-09-21"	2	2	2
"Lex"		"De Haan"	9		"1993-01-13"	3	3	3
"Daniel"	"Faviet"	10		"1994-08-16"	1	1	1
"Nancy"		"Greenberg"	10		"1994-08-17"	2	2	2
"John"		"Chen"		10		"1997-09-28"	3	3	3
"Ismael"	"Sciarra"	10		"1997-09-30"	4	4	4
"Jose Manuel"	"Urman"		10		"1998-03-07"	5	5	5
"Luis"		"Popp"		10		"1999-12-07"	6	6	6
"Shelley"	"Higgins"	11		"1994-06-07"	1	1	1
"William"	"Gietz"		11		"1994-06-07"	2	1	1
"Jack"		"Richer"	11		"1994-06-08"	3	3	2
