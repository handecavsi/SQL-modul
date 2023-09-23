select * from passenger

select * from booking

select * from payment


/*
Çok fazla alt sorgu kullanmak performans açısından faydalı değildir. 
Bu nedenle temp(geçici) tablolar kullanılabilir. Verilen Passenger, Booking ve Payment
veri setleri kullanılarak PostgreSQL'de tablolar oluşturulmuştur. 

Aşağıda bu tablolar ile ilgili çeşitli case'ler denenmiştir:
*/

--Ödeme tarihi 2020 olan bookingid'lerin contactid'leri nelerdir?

--1. YOL:

-- 1-) Payment date'i 2020 olan bookingid'ler payment tablosundan çekilir.
Select bookingid from payment 
where extract(year from paymentdate) = 2020 

--Çekilen bookingid'lerin contactid bilgileri booking tablosundan çekilir. 
--Inner Join Örneği:
Select contactid, extract(year from p.paymentdate) paymentdate from booking b 
inner join payment p on b.id=p.bookingid
where extract(year from p.paymentdate) = 2020

--2. YOL
--Subquery Örneği:
Select contactid from booking 
where id in 
(
Select bookingid from payment 
where extract(year from paymentdate) = 2020
)

-- 2-) 2021 yılında kart tipi kredi kartı olan bookingid'lerin cinsiyet dağılımı nasıldır?

/*Kart tipi kredi kartı olan ve ödeme tarihi 2021 olan bookingid bilgileri payment tablosundan
çekilir.*/
select bookingid from payment 
where cardtype = 'KrediKartı' and extract(year from paymentdate) = 2021

/*payment tablosundan çekilen bookingid'ler ile aynı booking_id'lere sahip gender bilgileri 
passenger tablosundan çekilir.*/
select gender, count(gender) from passenger where booking_id in
(
	select bookingid from payment 
	where cardtype = 'KrediKartı' and extract(year from paymentdate) = 2021
)
group by gender


--3-) Ortalama miktarı 300'den fazla olan bookingid'lerin hangi platformdan(web,app gibi) geldiği? 

--1. YOL (ALT sorgu)
select environment, count(environment) from booking 
where id in
(select bookingid from payment
group by bookingid 
Having avg(amount) > 300)
group by environment

--2. YOL (Temp Table)
WITH avg_amount_bid AS
(
	select bookingid 
	from payment
	group by bookingid 
	Having avg(amount) > 300
)

select b.environment, count(*) satirsayısı 
from booking b
inner join avg_amount_bid aid 
on b.id = aid.bookingid
group by environment

--SONUÇ 
/*
"app":	11777
"web":	11807
*/

-- 4-) Doğum tarihine göre (genç yaşlı segmentle) ödeme başarılı-başarısız durumu incele.

 select extract(year from dateofbirth) from passenger 
 select paymentstatus from payment
 
 WITH odeme_basari_yas AS
 (
 	select dateofbirth, paymentstatus,
 		case 
 			when extract(year from dateofbirth) < 1970 then 'Yaşlı'
			when extract(year from dateofbirth) >= 1970 and extract(year from dateofbirth) <= 1990 then 'Orta yaşlı'
			when extract(year from dateofbirth) > 1990 then 'Genç'
 		end yas_segment
 	from passenger ps
 	inner join payment py 
 	on ps.booking_id = py.bookingid
 )
select 
	yas_segment, paymentstatus,
	count(*) satirsayisi
from 
	odeme_basari_yas
group by 
	yas_segment, paymentstatus
order by 
	yas_segment, paymentstatus
	
-- 5-) company e göre 2020 ve 2021 yıllarında ki Kredi kartıyla ödeme yapan müşterilerden çekimi başarılı olanlardan elde ettiğimiz kar ?
-- çekimi başarısız olan müşterilerden ne kadar kar kaybettik?

WITH booking_table_2021 AS (
	select
		id, company
	from
		booking
	where
		bookingdate >= '2020-01-01' and
		bookingdate < '2021-01-01'
	),
	
booking_table_2022 AS (
	select
		id, company
	from
		booking
	where
		bookingdate >= '2021-01-01' and
		bookingdate < '2022-01-01'
	),
	
payment_table as (
	select
		bookingid, amount, cardtype, paymentstatus
	from
		payment
	where
		cardtype = 'KrediKartı' 
	),
	
sonuc_2021 as (

	select
		2021 yıl,
		company, paymentstatus,
		sum(amount) ciro,
		count(distinct bookingid)
	from
		booking_table_2021 t1 
	inner join
		payment_table t2 on t1.id  = t2.bookingid
	group by
		company, paymentstatus
	order by
		company, paymentstatus
	),
	
sonuc_2022 as (
	select
		2022 yıl,
		company, paymentstatus,
		sum(amount) ciro,
		count(distinct bookingid)
	from
		booking_table_2022 t1 
	inner join
		payment_table t2 on t1.id  = t2.bookingid
	group by
		company, paymentstatus
	order by
		company, paymentstatus
	)


select 
	*,
	case 
		when ciro > 100000 then 'yuksek' 
		when ciro <= 100000 and ciro > 50000 then 'orta' 
		else 'dusuk' end as ciro_barem
from 
	(
	select * from sonuc_2022
	union all 
	select * from sonuc_2021
	) asd


-- 6-) yıl ve aylara göre müşteri sayımız nedir?

select * from booking


select 
	EXTRACT(YEAR FROM bookingdate) yıl,
	EXTRACT(MONTH FROM bookingdate) ay,
	count(distinct contactid) as musteri_sayisi
from 
	booking
group by
	EXTRACT(YEAR FROM bookingdate),
	EXTRACT(MONTH FROM bookingdate)
order by 
	EXTRACT(YEAR FROM bookingdate),
	EXTRACT(MONTH FROM bookingdate)


-- 7-) yıl ve aylara göre üyelik durumuna göre müşteri sayımız nasıldır?

select 
	EXTRACT(YEAR FROM bookingdate) yıl,
	EXTRACT(MONTH FROM bookingdate) ay,
	membersales,
	count(distinct contactid) as musteri_sayisi
from 
	booking
group by
	EXTRACT(YEAR FROM bookingdate),
	EXTRACT(MONTH FROM bookingdate),
	membersales
order by 
	EXTRACT(YEAR FROM bookingdate),
	EXTRACT(MONTH FROM bookingdate),
	membersales

select * from booking limit 100 

select * from passenger limit 100

select * from payment limit 100

--8-) company e göre üye ve üye olmayan tekil contactid sayımız nedir?

--1. YOL

select
	company, 
	membersales,
	count(distinct contactid)
from
	booking
group by
	company, 
	membersales


-- 2.yol (CASE-WHEN)

select distinct membersales from booking

select
	company,
	count( distinct case when membersales = 'Üyeliksiz' then contactid end) üyeliksizmusteri,
	count( distinct case when membersales = 'üyelikli' then contactid end) üyemusteri,
	count(distinct contactid) toplammusteri
from
	booking 
group by
	company

-- 9-) hem üye hem üye olmadan işlem yapan contactidler nelerdir?

-- 1. yol 

select
	contactid
from
	booking
group by
	contactid
having
	count(distinct membersales) > 1

--2. YOL (Temp Table)

WITH uyemusteri AS
(
	select contactid from booking where membersales = 'üyelikli'
),

uyeliksizmusteri AS 
(
	select contactid from booking where membersales = 'Üyeliksiz'
)

select u.contactid 
from 
	uyemusteri u 
inner join 
	uyeliksizmusteri us 
ON 
	u.contactid = us.contactid
	 

-- 10-) company e göre üye ve üye olmayan tekil contactid sayımız nedir? 
-- yıl ve aylara göre değişimi


select
	company,
	extract(year from bookingdate),
	extract(month from bookingdate),
	count( distinct case when membersales = 'Üyeliksiz' then contactid end) üyeliksizmusteri,
	count( distinct case when membersales = 'üyelikli' then contactid end) üyemusteri,
	count(distinct contactid)
from
	booking 
group by
	company,
	extract(year from bookingdate),
	extract(month from bookingdate)


select
	company, 
	membersales,
	extract(year from bookingdate) yıl,
	extract(month from bookingdate) ay,
	count(distinct contactid) tekilmusteri
from
	booking
group by
	company, 
	membersales,
	extract(year from bookingdate),
	extract(month from bookingdate)
order by
	company, membersales


--11-) yıllara ve aylara göre cinsiyet dağılımı nasıldır?

select
	extract(year from t2.bookingdate) yıl,
	extract(month from t2.bookingdate) ay,
	gender,
	count(distinct contactid) tekilmusteri
from
	passenger t1
inner join
	booking t2 on t1.bookingid = t2.id
group by
	extract(year from t2.bookingdate),
	extract(month from t2.bookingdate),
	gender
order by
	extract(year from t2.bookingdate),
	extract(month from t2.bookingdate),
	gender

