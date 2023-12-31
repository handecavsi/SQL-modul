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


--3-)Her müşterinin en düşük ödeme yaptığı gün ve rezervasyon tarihini getirin.

--ROW_NUMBER() ile de yapılabilirdi. Ancak FIRST_VALUE() syntax için daha avantajlıdır.
	
select 
	contactid,
	bookingdate,
	paymentdate,
	amount,
	FIRST_VALUE(bookingdate) OVER (PARTITION BY contactid order by amount) as least_payment_bookingdate,
	FIRST_VALUE(paymentdate) OVER (PARTITION BY contactid order by amount) as least_payment_paymentdate
from booking b 
join payment p on b.id = p.bookingid


/*======================================================================================================================*/



/*Travel veri tabanı içerisinde çeşitli case'ler yapılmıştır:*/

--Kullanıcak tablolar:
select * from booking
select * from passenger
select * from payment


--case1: Her müşterinin ilgili rezervasyon tarihi ile iki sonraki rezervasyon tarihini getiriniz.

select contactid,
	   bookingdate,
	   LEAD(bookingdate::date,2,NULL) OVER (PARTITION BY contactid ORDER BY bookingdate) next2_bookingdate
from booking 

--case2: Her müşterinin ilgili rezervasyon tarihi ile iki önceki rezervasyon tarihini getiriniz.

select contactid,
	   bookingdate,
	   LAG(bookingdate::date,2,NULL) OVER (PARTITION BY contactid ORDER BY bookingdate) prev2_bookingdate
from booking 

--case3: Önceki ve sonraki tarihlerin farkını age ile hesaplama:

select bookingdate,
	   next2_bookingdate,
	   age(next2_bookingdate,bookingdate) diff_booking_date
	   FROM
		(select contactid,
	   			bookingdate,
	   			LEAD(bookingdate::date,2,NULL) OVER (PARTITION BY contactid ORDER BY bookingdate) next2_bookingdate
			from booking) T;
			
--case4: gün kırılımda ilgili tarihte en yüksek başarılı ödeme yapılan rezervasyon id'si ile 
--bu rezervasyonun tüm müşteri bilgilerini getirin (bookingid,bookingdate,contactid,passengerid,
--passengername,passengergender)

--Kullanıcak tablolar:
select * from booking --=>bookingdate
select * from passenger --=>bookingid,bookingdate,contactid,passengerid,
--passengername,passengergender
select * from payment --=> paymentstatus

with max_amount as(
	select 
		bookingdate::date as bookingdate,
		b.id,
		contactid,
		p.amount,
		ROW_NUMBER() OVER (PARTITION BY bookingdate::date ORDER BY p.amount desc) as rn
	from booking b 
	join payment p
	on b.id = p.bookingid
	where p.paymentstatus = 'ÇekimBaşarılı'
	ORDER BY 1, 4 desc
) select 
		 m.bookingdate,
		 m.amount,
		 p.dateofbirth,
		 gender,
		 name
		 from max_amount m
  join passenger p on m.id=p.booking_id
  where rn=1


--case5: Her müşterinin en fazla ödeme yaptığı company'i müşteri company'si olarak belirle.

with contact_with_companies  as
(	select 
	contactid,
	company,
	count(p.id) as toplam_ödeme_sayisi,
	sum(amount) as toplam_ödeme_mik
from booking b
join payment p on b.id=p.bookingid
where p.paymentstatus='ÇekimBaşarılı'
group by 1,2
order by 1,2),
row_num as (
	select 
		contactid,
		company,
		toplam_ödeme_sayisi,
		toplam_ödeme_mik,
		ROW_NUMBER() OVER (PARTITION BY contactid ORDER BY toplam_ödeme_sayisi desc, toplam_ödeme_mik desc) as rn
	from contact_with_companies
) select contactid,company from row_num where rn=1


--case6: Her müşterinin en fazla ödeme yaptığı company'i müşteri company'si olarak belirle.
--Belirlenen company'lerin yaş kırılımına göre kullanımı nedir?

with contact_with_company as (
	select 
		contactid,
		company,
		count(b.id) toplam_ödeme_sayisi,
		sum(amount) toplam_ödeme_mik	
	from booking b
	join payment p 
	on b.id = p.bookingid
	where p.paymentstatus = 'ÇekimBaşarılı'
	group by 1,2
	order by 1,2
),
row_num as (
select 
	contactid,
	company,
	toplam_ödeme_sayisi,
	toplam_ödeme_mik,
	ROW_NUMBER() OVER (PARTITION BY contactid ORDER BY toplam_ödeme_sayisi desc, toplam_ödeme_mik desc) as rn
from contact_with_company
),
contact_comp as (
	select 
	contactid,
	company
  	from row_num where rn = 1
), 
all_ages as (
	select 
		cc.contactid,
		cc.company,
		extract(year from age(current_date,dateofbirth)) as age
	from contact_comp as cc
	join booking b 
	on cc.contactid = b.contactid
	join passenger ps 
	ON ps.booking_id = b.id
	)
select 
	   company,
	   case
	   	when age >= 22 AND age < 33 then '22-32'
	   		when age >= 32 AND age < 43 then '32-42'
	   			when age >= 42 AND age < 53 then '42-52'
	   				when age >= 52 AND age < 63 then '52-62'
	   					when age >= 62 AND age < 73 then '62-72'
	   						when age >= 72 AND age < 83 then '72-82'
	   							ELSE '83+' 
		END as age_segment,
		count(*)
from all_ages 
group by company, age_segment


--yaş kırılımı sayısı 100'den büyük olanlar nedir?
--Pratik olarak HAVING kullanarak bulabiliriz. 

with contact_with_company as (
	select 
		contactid,
		company,
		count(b.id) toplam_ödeme_sayisi,
		sum(amount) toplam_ödeme_mik	
	from booking b
	join payment p 
	on b.id = p.bookingid
	where p.paymentstatus = 'ÇekimBaşarılı'
	group by 1,2
	order by 1,2
),
row_num as (
select 
	contactid,
	company,
	toplam_ödeme_sayisi,
	toplam_ödeme_mik,
	ROW_NUMBER() OVER (PARTITION BY contactid ORDER BY toplam_ödeme_sayisi desc, toplam_ödeme_mik desc) as rn
from contact_with_company
),
contact_comp as (
	select 
	contactid,
	company
  	from row_num where rn = 1
), 
all_ages as (
	select 
		cc.contactid,
		cc.company,
		extract(year from age(current_date,dateofbirth)) as age
	from contact_comp as cc
	join booking b 
	on cc.contactid = b.contactid
	join passenger ps 
	ON ps.booking_id = b.id
	)
select 
	   company,
	   case
	   	when age >= 22 AND age < 33 then '22-32'
	   		when age >= 32 AND age < 43 then '32-42'
	   			when age >= 42 AND age < 53 then '42-52'
	   				when age >= 52 AND age < 63 then '52-62'
	   					when age >= 62 AND age < 73 then '62-72'
	   						when age >= 72 AND age < 83 then '72-82'
	   							ELSE '83+' 
		END as age_segment,
		count(*)
from all_ages 
group by company, age_segment
HAVING count(*) > 1000


--Gün kırılımında, ilgili tarihte en yüksek başarılı ödeme yapılan rezervasyon id'si ile bu rezervasyonun tüm yolcu bilgilerini getirin. 
--bookingid,bookingdate,contactid,passengerid,passengername,passengergender

WITH max_amount AS (
        SELECT bookingdate::date AS bookingdate,
               b.id AS booking_id,
               b.contactid,
               p.amount,
               rank() OVER (PARTITION BY bookingdate::date ORDER BY p.amount DESC) AS rn
          FROM booking AS b
         INNER JOIN payment AS p
            ON b.id = p.bookingid
         WHERE p.paymentstatus = 'ÇekimBaşarılı'
       ) 
SELECT bookingdate,
       booking_id,
       amount,
       contactid,
       p.id AS passenger_id,
       p.name AS passenger_name,
       p.gender
  FROM max_amount AS ma
  LEFT JOIN passenger AS p
    ON p.bookingid = ma.booking_id
 WHERE rn = 1
 ORDER BY bookingdate
;


--Aynı sorgunun from'dan sonra subquery ile yazılmış hali


SELECT bookingdate,
       booking_id,
       amount,
       contactid,
       p.id AS passenger_id,
       p.name AS passenger_name,
       p.gender
  FROM (SELECT bookingdate::date AS bookingdate,
               b.id AS booking_id,
               b.contactid,
               p.amount,
               rank() OVER (PARTITION BY bookingdate::date ORDER BY p.amount DESC) AS rn
          FROM booking AS b
         INNER JOIN payment AS p
            ON b.id = p.bookingid
         WHERE p.paymentstatus = 'ÇekimBaşarılı') AS ma
  LEFT JOIN passenger AS p
    ON p.bookingid = ma.booking_id
 WHERE rn = 1
 ORDER BY bookingdate



--Her ay için, ilgili ayda toplam başarılı ödeme tutarına göre müşterileri 10 ntile'a ayırın. Bu grupları a+,a,b+,b,c+,c.. gibi sınıflara ayırarak segmente edin.

--Tarih olarak payment_date kullanınız.
--Aylık olarak, her müşterinin toplam başarılı ödeme tutarını hesaplayınız.
--Örneğin; Sibel Ocak Ayında 100 TL, Murat Nisan ayında 250 TL ...
--Daha sonra bu veri setini her ay için 10 ntile'a bölün.
--ntile(10) OVER (PARTITION BY payment_month ORDER BY amount)
--Daha sonra ntile çıktısına göre a+,a,b+,b,c+,c.. gibi sınıflara ayırarak segmente edin.

with all_data as (
	select 
		date_trunc('month', paymentdate) as payment_month,
		b.contactid,
		sum(p.amount) as total_amount,
		ntile(10) over (partition by date_trunc('month', p.paymentdate) order by sum(p.amount)) as nt
	from payment as p
	left join booking as b 
	on b.id=p.bookingid
	where p.paymentstatus='ÇekimBaşarılı'
	group by 1,2
) 
select 
payment_month,
case 
when nt=1 then 'A+'
when nt=2 then 'A'
when nt=3 then 'B+'
when nt=4 then 'B'
when nt=5 then 'C+'
when nt=6 then 'C'
when nt=7 then 'D+'
when nt=8 then 'D'
when nt=9 then 'E+'
when nt=10 then 'E'
END AS contact_segment,
count(distinct contactid) as contact_count
from all_data
group by 1,2


--Her müşterinin en fazla ödeme yaptığı company'i o müşterinin companysi olarak belirleyiniz.
--Bu case row_number konu anlatımında anlatılmıştır.

WITH contacts_with_companies AS (
        SELECT b.contactid,
               b.company,
               count(DISTINCT p.id) AS payment_count
          FROM payment AS p
         INNER JOIN booking AS b
            ON b.id = p.bookingid
         WHERE p.paymentstatus = 'ÇekimBaşarılı'
         GROUP BY 1,2
       ),
       row_num AS (
        SELECT contactid,
               company,
               payment_count,
               row_number() OVER (PARTITION BY contactid ORDER BY payment_count DESC) AS rn
          FROM contacts_with_companies
       ) SELECT contactid,
       			company
  		 FROM row_num
 	     WHERE rn = 1;
 
--Her company'nin yolcularının yaşı kırılımında aylık olarak yolcu sayısını getirin.Her müşterinin en fazla ödeme yaptığı company'i o müşterinin companysi olarak belirlenmelidir.
--Bu case row_number konu anlatımında anlatılmıştır.
--Bu soru zorunlu değildir. 

WITH contacts_with_companies AS (
        SELECT b.contactid,
               b.company,
               count(DISTINCT p.id) AS payment_count
          FROM payment AS p
         INNER JOIN booking AS b
            ON b.id = p.bookingid
         WHERE p.paymentstatus = 'ÇekimBaşarılı'
         GROUP BY 1,
                  2
       ),
       row_num AS (
        SELECT contactid,
               company,
               payment_count,
               row_number() OVER (PARTITION BY contactid ORDER BY payment_count DESC) AS rn
          FROM contacts_with_companies
       ),
	   contacts_companies as (
			SELECT contactid,
       				company
  			FROM row_num
 			WHERE rn = 1
    ), all_ages as 
    (
		select 
		cc.contactid,
		cc.company,
		p.id as passenger_id,
		EXTRACT ( YEAR FROM (AGE ( current_date , p.dateofbirth)) ) as passenger_age
		from contacts_companies  as cc 
		inner join booking as b on cc.contactid=b.contactid
		inner join passenger as p on p.bookingid=b.id
		order by 1
	)
select company,
       case 
       when passenger_age>=22 AND passenger_age<33 THEN '22-32'
        when passenger_age>=32 AND passenger_age<43 THEN '32-42'
         when passenger_age>=42 AND passenger_age<53 THEN '42-52'
          when passenger_age>=52 AND passenger_age<63 THEN '52-62'
           when passenger_age>=62 AND passenger_age<73 THEN '62-72'
            when passenger_age>=72 AND passenger_age<83 THEN '72-82'
            ELSE '83+' END AS age_segment,
            count(distinct passenger_id) as passenger_count
from all_ages 
group by 1,2

