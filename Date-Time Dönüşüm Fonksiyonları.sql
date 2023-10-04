
select * from booking limit 100 

select * from passenger limit 100

select * from payment limit 100

/*
	Veri Tipi Değiştirme (CAST)
*/

--SQL'de veri tipini değiştirmek için cast (dönüştürme) fonksiyonu kullanılır.
--SELECT cast(kolon_adi as veri_tipi)
--FROM tablo;
--SELECT (kolon_adi::veri_tipi)
--FROM tablo;

--ERROR:  operator does not exist: text * integer
--20 TL string bir ifade olduğu için aşağıdaki işlemde integer değer olması gerektiği 
--hatası alınır.
select left('20 TL', 2) * 18  


--Hatayı gidermek için; left('20 TL', 2) => left fonksiyonu ve içerisindeki ifade 
--cast fonksiyonuyla integer değere dönüştürülür. 
select cast(left('20 TL', 2) as integer) * 18

select left('20 TL', 2)::integer



select
	left('20 TL', 2), --Çıktı olarak 20'yi text tipinde verir.
	cast(left('20 TL', 2) as integer), --Çıktı olarak 20'yi integer tipinde verir.
	left('20 TL', 2)::integer -- Çıktı olarak 20'yi integer tipinde verir.


-- 
select 20 --integer tipinde 20'yi getirir.

select cast(20 as varchar) --integer olan 20 değerini varchar olarak getirir.


--Aşağıdaki ifade date'e dönüşümün farklı kullanımlarını gösterir.
select 
	bookingdate,
	cast(bookingdate as date),
	date(bookingdate)
from 
	booking 
limit 100 

--1-) Günlere göre tekil contact id sayımız nedir? Büyükten küçüğe sırala 

--1. Yol
select 
	cast(bookingdate as date) as gun,
	count(distinct contactid) tekilMusteri
from 
	booking 
group by
	cast(bookingdate as date)
order by
	count(distinct contactid) desc


--2.Yol
select 
	date(bookingdate) as gun,
	count(distinct contactid) tekilMusteri
from 
	booking 
group by
	date(bookingdate)
order by
	count(distinct contactid) desc


/*
	To Char
*/

-- TO_CHAR fonksiyonu, veritabanındaki bir veriyi belirli bir formatta görüntülemek için kullanılır. 
-- Bu fonksiyon, veriyi belirli bir düzen içinde görüntülemek için özelleştirilmiş bir şekilde biçimlendirir.
-- TO_CHAR fonksiyonu, tarih ve saat verileri, sayılar, yüzdeler ve diğer veriler gibi farklı veri tipleri için kullanılabilir.
	  

select 
	bookingdate,
	date(bookingdate) gun,
	to_char(bookingdate, 'YYYY') yıl, --4 basamaklı yıl
	to_char(bookingdate, 'YY') yıl, --Yılın son iki basamağı
	to_char(bookingdate, 'MM') ay, --sayısal olarak ay(01,02,..12 gibi)
	to_char(bookingdate, 'MONTH') ay_ismi, --Ayın tam ismi (Ocak,Şubat..,Aralık)
	to_char(bookingdate, 'DD') gun, --Sayısal olarak gün (01,02,..31 gibi)
	to_char(bookingdate, 'DAY') gun_ismi, --Günün tam ismi (Pazartesi,salı,..,Pazar)
	to_char(bookingdate, 'yyyy-mm') yıl_ay, --(2023-09)
	to_char(bookingdate, 'mm-day') yıl_ay --(09-cuma)
from 
	booking 
limit 100


--2-)bookingdate'lere göre satır sayısı nedir?

--1.Yol 'YYYY-MM-DD' formatında 
select 
	to_char(bookingdate, 'YYYY-MM-DD') gun, --to_char cast fonk. gibi kullanılır.
	count(*)
from 
	booking 
GROUP BY
	to_char(bookingdate, 'YYYY-MM-DD')
	
	
--2.Yol 'YYYY-MM' formatında 
select 
	to_char(bookingdate, 'YYYY-MM') gun,
	count(*)
from 
	booking 
GROUP BY
	to_char(bookingdate, 'YYYY-MM')
order by 
	2

--3.Yol 'YYYY' ve 'MONT' ayrı olarak 
select 
	to_char(bookingdate, 'YYYY') yıl,
	to_char(bookingdate, 'MONT') ay,
	count(*)
from 
	booking 
GROUP BY
	to_char(bookingdate, 'YYYY'),
	to_char(bookingdate, 'MONT') 


-- 3-) 2021 yılındaki verileri getir.

--1. Yol to_char ile yılı belirleme.
select 
	*
from 
	booking 
WHERE
	to_char(bookingdate, 'YYYY') = '2021' -- 118 (sorgu çalışma süresi)


--2. yol 2021 yılını Between kullanarak belirleme.
SELECT 
	*
FROM 
	booking
WHERE 
	bookingdate BETWEEN '2021-01-01 00:00:00' AND '2022-01-01 00:00:00'  -- 114 (sorgu çalışma süresi)


--**Dip Not!!
--1. yol ile 2. yol aynı sonuçları getirse de performans farklılıkları vardır.
--yıl sorgularken; to_char gibi tarih dönüşüm fonksiyonları kullanmak sorgunun daha uzun
--sürede çalışmasına neden olur.
--Between kullanarak, daha hızlı çalışan bir sorgu yazabiliriz.




/*
	Date/Time Fonksiyonları
*/


-- current_date: Bugünün tarihini döndürür.
SELECT current_date


--current_date fonksiyonu belirli bir tarihle bugünün tarihi arasındaki farkı 
--hesaplamamız gereken durumlarda kullanılabilir.
SELECT 
	bookingdate,
	current_date,
	current_date - bookingdate
FROM 
	booking
limit 100


-- current_time: Şu andaki saati döndürür.
select current_time


-- current_timestamp: Şu anki tarih ve saati döndürür.
select current_timestamp


-- date_trunc: Belirtilen birimi kullanarak tarih başını getirir.
SELECT 
	bookingdate,
	date_trunc('day',bookingdate),
	date_trunc('month',bookingdate),
	date_trunc('year',bookingdate)
FROM 
	booking
limit 10



-- extract: Belirtilen birimi kullanarak tarih veya zaman verisinden bir parçayı döndürür.
--Aynı işlem to_char ile de yapılabilir. 
--Aralarındaki fark extract fonksiyonun numeric değer döndürmesidir.
--to_char ile text tipinde ay ve günlerin tam adını getirebiliriz. (Ocak,Şubat,Salı,Çarşamba gibi)
--Genel fark döndürülen verinin tipidir. 
SELECT 
	bookingdate,
	to_char(bookingdate, 'YYYY') yıl_to_char,
	to_char(bookingdate, 'MM') ay_to_char,
	extract(year from bookingdate) yıl_extract,
	extract(month from bookingdate) ay_extract
FROM 
	booking
limit 10



--4-) 5. aydan sonraki verileri getir.

SELECT 
	*
FROM 
	booking
where
	extract(month from bookingdate) > 5
limit 10



--5-)Aylara göre 2020 yılının contactid verilerini getir.

--1. Yol Extract ile.
SELECT 
	EXTRACT(MONTH FROM bookingdate),
    count(*)
FROM 
	booking
where
	bookingdate BETWEEN '2020-01-01 00:00:00' AND '2021-01-01 00:00:00' 
group by
	1
order by 
	1 

--2. Yol to_char ile
SELECT 
	to_char(bookingdate, 'MM'),
    count(*)
FROM 
	booking
where
	bookingdate BETWEEN '2020-01-01 00:00:00' AND '2021-01-01 00:00:00' 
group by
	1
order by 
	1 


-- age: İki tarih arasındaki farkı döndürür.
SELECT 
    bookingdate,
    AGE(current_date , bookingdate ),
    current_date - bookingdate 
FROM booking
limit 100

-- date_part: Belirtilen birimi kullanarak tarih verisinden bir parçayı döndürür.

SELECT 	
	bookingdate,
	date_part('month' ,bookingdate) datepart,
	extract(month from bookingdate) ext,
	to_char(bookingdate, 'MM') tochar
FROM 
	booking
limit 10


select current_date

SELECT NOW()

SELECT cast(NOW() as date)











