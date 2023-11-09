select * from orders limit 100
select * from order_items limit 100 --önemli gün tarihi yok
select * from products limit 100 --tarih yok
select * from customers limit 100 --tarih yok
select * from order_reviews limit 100 --önemli gün tarihi yok
select * from seller limit 100 --tarih yok
select * from order_payments limit 100 --tarih yok
select * from product_category_name_translation -- tarih yok.

--Sipariş Analizi--

--1)Aylık olarak order dağılımını inceleyiniz. Tarih verisi için order_approved_at kullanılmalıdır.

select 
	(date_trunc('month',order_approved_at))::date AS order_month,
	count(order_id) as order_count	
from orders 
where order_approved_at is not null
group by 1
order by 1

--2)Aylık olarak order status kırılımında order sayılarını inceleyiniz.

select distinct(order_status) from orders

select 
	(date_trunc('month',order_approved_at))::date AS order_month,
	order_status,
	count(order_id) as order_count	
from orders 
where order_approved_at is not null 
group by 1,2
order by 1

--3-) Ürün kategorisi kırılımında sipariş sayılarını inceleyiniz. 
--Özel günlerde öne çıkan kategoriler nelerdir? Örneğin yılbaşı, sevgililer günü…

-- Tarih olarak onaylanmış sipariş tarihleri baz alınmıştır.
-- Herhangi bir ketagoriye ait olmayan ürünler ele alınmamıştır.
-- Yıl başı 2016-01-01, 2017-01-01, 2018-01-01
-- Sevgililer günü 2016-14-02, 2017-14-02, 2018-14-02
-- Noel 11-25 (25 Aralık)
-- Çocuklar günü 10-12 (12 Ekim)

--3.1) Ürün kategorisi kırılımında sipariş sayıları.
with orders_pcategory_date as 
(
	select 
		o.order_id,
		o.order_status,
		o.order_approved_at::date as order_date,
		p.product_category_name
	from orders as o
	join order_items as oi
	on o.order_id = oi.order_id
	join products as p 
	on oi.product_id = p.product_id
	where 
		p.product_category_name is not null and 
		o.order_approved_at::date is not null
) select 
		p.product_cetagory_name_eng as product_category,
		count(o.order_id) as order_count
	from orders_pcategory_date as o
	join product_category_name_translation as p
	on o.product_category_name = p.product_category_name
	group by 1
	order by 2 desc


--3.2) Özel günlerde öne çıkan kategoriler nelerdir? Örneğin yılbaşı, sevgililer günü… 
--Window function kullanılabilir.

with orders_pcategory_date as  --sipariş,kategori ismi,sipariş tarihi tablosu
(   
	select 
		o.order_id,
		o.order_status,
		o.order_approved_at::date as order_date,
		p.product_category_name
	from orders as o
	join order_items as oi
	on o.order_id = oi.order_id
	join products as p 
	on oi.product_id = p.product_id
	where 
		p.product_category_name is not null and 
		o.order_approved_at::date is not null
), 
ozel_gun_category as ( --Yalnızca özel günlerde tercih edilen ürün kategorileri tablosu
	select 
		o.order_id,
		p.product_cetagory_name_eng as product_category,
		to_char(o.order_date, 'MM-DD') as ay_gun,
		case 
			when to_char(o.order_date, 'MM-DD') = '01-01' then 'Yılbaşı'
			when to_char(o.order_date, 'MM-DD') = '02-14' then 'Sevgililer günü'
			when to_char(o.order_date, 'MM-DD') = '11-25' then 'Noel'
			else 'Çocuklar günü'
		end as ozel_gun
	from orders_pcategory_date as o
	join product_category_name_translation as p
	on o.product_category_name = p.product_category_name
	where to_char(o.order_date, 'MM-DD') = '01-01' or 
	to_char(o.order_date, 'MM-DD') = '02-14' or
	to_char(o.order_date, 'MM-DD') = '11-25' or
	to_char(o.order_date, 'MM-DD') = '10-12'
), ranked_categories as (
    SELECT
        product_category,
        ozel_gun,
        RANK() OVER (PARTITION BY ozel_gun ORDER BY COUNT(order_id) DESC) AS category_rank
    FROM ozel_gun_category
    GROUP BY product_category, ozel_gun
)
SELECT
    product_category,
    ozel_gun
FROM ranked_categories
WHERE category_rank = 1;
  


--4-) -Haftanın günleri(pazartesi, perşembe, ….) ve ay günleri (ayın 1’i,2’si gibi) 
--bazında order sayılarını inceleyiniz. 

--4.1-) Haftanın günleri bazında order sayısı

select 
	to_char(order_approved_at::date,'day') as week_day,
	count(order_id) as order_count
from orders
where to_char(order_approved_at::date,'day') is not null
group by 1

--4.2-) Ay günleri bazında order sayısı

select 
	extract(day from order_approved_at::date) as month_day,
	count(order_id) as order_count
from orders
where to_char(order_approved_at::date,'day') is not null
group by 1


--Müşteri Analizi--

--5-) Hangi şehirlerdeki müşteriler daha çok alışveriş yapıyor? 
--Müşterinin şehrini en çok sipariş verdiği şehir olarak belirleyip analizi ona göre yapınız. 

--Örneğin; Sibel Çanakkale’den 3, Muğla’dan 8 ve İstanbul’dan 10 sipariş olmak üzere 3 farklı şehirden 
--sipariş veriyor. 
--Sibel’in şehrini en çok sipariş verdiği şehir olan İstanbul olarak seçmelisiniz ve Sibel’in 
--yaptığı siparişleri İstanbul’dan 21 sipariş vermiş şekilde görünmelidir.

with customer_with_city as (
SELECT 
	c.customer_unique_id,
	c.customer_city, 
	COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY 1,2
ORDER BY 3 desc
), row_num as(
	select 
		customer_unique_id,
		customer_city,
		total_orders,
		row_number() over (partition by customer_unique_id order by total_orders desc) as rn
	from customer_with_city
), costumer_city as (
	select 
		customer_unique_id,
		customer_city,
		total_orders
	from row_num 
	where rn=1
) select * from costumer_city order by total_orders desc
	


--Satıcı Analizi--

--6-)Siparişleri en hızlı şekilde müşterilere ulaştıran satıcılar kimlerdir? Top 5 getiriniz. 
--Bu satıcıların order sayıları ile ürünlerindeki yorumlar ve puanlamaları inceleyiniz ve 
--yorumlayınız.

--Bana seller_id lazım.
--orders tablosunda order delivered customer date'den 
--order_approved_at timestamp'i çıkarırsam müşterinin ürünün
--kendisine teslim edildiği tarihe kadar geçen süreyi bulurum.
--Bu da bana ürünün müşteriye ulaşma süresini verir.
--Bu sürenin en kısa olduğu seller_id'ler en hızlı ulaştıran seller_id'dir denir.
--Bana orders tablosundaki order_delivered_customer_date ve order_purchase_timestamp lazım
--Aynı zamanda bu analizi yalnızca order_status'ü delivered olan ürünlerde yapmak sağlıklı olur.
--Bana orders tablosundaki order_status lazım.
--seller_id'ye bağlı order_id'leri saydırarak, satıcıların order sayısını bulabilirim.
--Bunun için orders tablosuna ihtiyacım var.
--order_reviews tablosundan review_comment_message ve review_score çekmem lazım.
--orders ve order_reviews tablosunu temp faster_sellerid ile bağlamak için 
--order_items tablosuna ihtiyacım var.
select * from orders limit 100

--Siparişleri en hızlı şekilde müşterilere ulaştıran satıcılar kimlerdir? Top 5 getiriniz.
with seller_with_duration_comments as (
	select
		o.order_id,
		s.seller_id,
		age(o.order_delivered_customer_date,o.order_approved_at) as deliver_duration,
		orv.review_score,
		orv.review_comment_message
	from orders as o 
	join order_items as oi
	on o.order_id = oi.order_id
	join seller as s
	on s.seller_id = oi.seller_id
	join order_reviews as orv
	on orv.order_id = o.order_id
	where o.order_status = 'delivered' and
	o.order_delivered_customer_date is not null and
	o.order_approved_at is not null and
	o.order_delivered_customer_date > o.order_approved_at
	order by 3
), sellerid_limited as (
	select 
		seller_id,
		count(order_id) as order_count
		from 
	seller_with_duration_comments
	group by 1
	having(count(order_id) > 37)
	order by 2
),sellerid_withinterval as (
	select 
		sl.seller_id,
		swdc.deliver_duration
	from sellerid_limited as sl
	join seller_with_duration_comments as swdc
	on sl.seller_id = swdc.seller_id
), avg_duration as (
  select 
	seller_id,
	avg(deliver_duration) as avg_duration
  from sellerid_withinterval
  group by 1
  order by 2
) select * from avg_duration limit 5


--Ortalama sipariş sayısı için:
with seller_with_ordercount as (
	select
		s.seller_id,
		count(o.order_id) as order_count		
	from orders as o 
	join order_items as oi
	on o.order_id = oi.order_id
	join seller as s
	on s.seller_id = oi.seller_id
	join order_reviews as orv
	on orv.order_id = o.order_id
	where o.order_status = 'delivered' and
	o.order_delivered_customer_date is not null and
	o.order_approved_at is not null and
	o.order_delivered_customer_date > o.order_approved_at
	group by 1
	order by 2
)select round(avg(order_count),2) as avg_order_count 
	from seller_with_ordercount
	

--Bu satıcıların order sayıları ile ürünlerindeki yorumlar ve puanlamaları inceleyiniz ve 
--yorumlayınız.
with seller_with_duration_comments as (
	select
		o.order_id,
		s.seller_id,
		age(o.order_delivered_customer_date,o.order_approved_at) as deliver_duration,
		orv.review_score,
		orv.review_comment_message
	from orders as o 
	join order_items as oi
	on o.order_id = oi.order_id
	join seller as s
	on s.seller_id = oi.seller_id
	join order_reviews as orv
	on orv.order_id = o.order_id
	where o.order_status = 'delivered' and
	o.order_delivered_customer_date is not null and
	o.order_approved_at is not null and
	o.order_delivered_customer_date > o.order_approved_at
	order by 3
), sellerid_limited as (
	select 
		seller_id,
		count(order_id) as order_count
		from 
	seller_with_duration_comments
	group by 1
	having(count(order_id) > 37)
	order by 2
),sellerid_withinterval as (
	select 
		sl.seller_id,
		swdc.deliver_duration
	from sellerid_limited as sl
	join seller_with_duration_comments as swdc
	on sl.seller_id = swdc.seller_id
), avg_duration as (
  select 
	seller_id,
	avg(deliver_duration) as avg_duration
  from sellerid_withinterval
  group by 1
  order by 2
), faster_seller_limited as (
	select * from avg_duration limit 5 
), sellerid_with_review_count as (
	SELECT
    	fsl.seller_id,
    	count(swdc.review_comment_message) as comment_count
	FROM faster_seller_limited fsl
	JOIN seller_with_duration_comments swdc ON fsl.seller_id = swdc.seller_id
	where swdc.review_comment_message is not null
	GROUP BY fsl.seller_id
	ORDER BY 2 
), sellerid_with_avg_rs as (
	SELECT
    	fsl.seller_id,
    	round(avg(swdc.review_score),2) as avg_reviewscore
	FROM faster_seller_limited fsl
	JOIN seller_with_duration_comments swdc ON fsl.seller_id = swdc.seller_id
	GROUP BY fsl.seller_id
	ORDER BY 2
), sellerid_with_ordercount as (
	SELECT
    	fsl.seller_id,
    	COUNT(swdc.order_id) AS order_count
	FROM faster_seller_limited fsl
	JOIN seller_with_duration_comments swdc ON fsl.seller_id = swdc.seller_id
	GROUP BY fsl.seller_id
	ORDER BY order_count
) select 
	swo.seller_id,
	swo.order_count,
	swar.avg_reviewscore,
	swrc.comment_count
from sellerid_with_ordercount as swo
join sellerid_with_avg_rs as swar
on swo.seller_id=swar.seller_id
join sellerid_with_review_count as swrc
on swrc.seller_id = swar.seller_id
order by 2


--7-)Hangi satıcılar daha fazla kategoriye ait ürün satışı yapmaktadır? 
--Fazla kategoriye sahip satıcıların order sayıları da fazla mı? 

--satıcıların ürün kategorisi sayılarına bakalım...

select * from seller limit 100
select * from products limit 100


--Satıcıların ürün kategorisi sayılarına göre fazla kategoriye sahip 10 satıcı

with seller_with_category_count as (
select 
	s.seller_id,
	count(distinct(p.product_category_name)) as category_count
from seller as s
join order_items as oi
on s.seller_id = oi.seller_id
join products as p
on p.product_id = oi.product_id
where p.product_category_name is not null
group by 1
order by 2 desc
) select * from seller_with_category_count limit 10

--Fazla kategoriye sahip satıcıların order sayıları da fazla mı?

with seller_with_category_count as (
select 
	s.seller_id,
	count(distinct(p.product_category_name)) as category_count
from seller as s
join order_items as oi
on s.seller_id = oi.seller_id
join products as p
on p.product_id = oi.product_id
where p.product_category_name is not null
group by 1
order by 2 desc
), seller_with_high_category as (
	select * from seller_with_category_count limit 10
) select 
		swhc.seller_id,
		count(o.order_id) as order_count
	from seller_with_high_category as swhc
	join order_items as oi
	on swhc.seller_id = oi.seller_id
	join orders as o
	on o.order_id = oi.order_id
	group by 1
	order by 2 desc

--8-)-Ödeme yaparken taksit sayısı fazla olan kullanıcılar en çok hangi bölgede yaşamaktadır?
--Bu çıktıyı yorumlayınız.
--Bölge customer_city olarak alınmıştır.
--Eşik değeri verideki taksit sayıları incelenerek değerlendirilmiştir.


select distinct(payment_installments) from order_payments order by 1
--Taksit sayıları: 1'den 24'e kadar..

--Taksitlere göre sipariş sayıları..
select count(order_id) from order_payments where payment_installments=1
--52546
select count(order_id) from order_payments where payment_installments=2
--12413
select count(order_id) from order_payments where payment_installments=3
--10461
select count(order_id) from order_payments where payment_installments=4
--7098
select count(order_id) from order_payments where payment_installments=5
--5239
select count(order_id) from order_payments where payment_installments=6
--3920
select count(order_id) from order_payments where payment_installments=7
--1626
select count(order_id) from order_payments where payment_installments=8
--4268
select count(order_id) from order_payments where payment_installments=9
--644
select count(order_id) from order_payments where payment_installments=10
--5328
select count(order_id) from order_payments where payment_installments=11
--23
select count(order_id) from order_payments where payment_installments=12
--133
select count(order_id) from order_payments where payment_installments=13
--16
select count(order_id) from order_payments where payment_installments=14
--15
select count(order_id) from order_payments where payment_installments=15
--74
select count(order_id) from order_payments where payment_installments=16
--5
select count(order_id) from order_payments where payment_installments=17
--8
select count(order_id) from order_payments where payment_installments=18
--27
select count(order_id) from order_payments where payment_installments=19
--0
select count(order_id) from order_payments where payment_installments=20
--17
select count(order_id) from order_payments where payment_installments=21
--3
select count(order_id) from order_payments where payment_installments=22
--1
select count(order_id) from order_payments where payment_installments=23
--1
select count(order_id) from order_payments where payment_installments=24
--18

--Müşterilerin genellikle 10 taksite kadar satın alma tercih ettiği ve 
--10 taksitten fazla olan taksitlendirmenin çok tercih edilmediği gözlemlenmiştir. 
--Bu nedenle taksit sayısı fazla olarak eşik değeri 5 ile 10 arasında olan müşteriler alınmıştır. 

--taksit sayıları yüksek olan kullanıcılar
SELECT 
    distinct(c.customer_id),
    op.payment_installments
FROM customers AS c
JOIN orders AS o ON c.customer_id = o.customer_id
JOIN order_payments AS op ON op.order_id = o.order_id
WHERE op.payment_installments > 5 and op.payment_installments <= 10
order by 2 desc
	
--taksit sayıları yüksek olan kullanıcıların yaşadığı bölgeler
with customers_with_highpaymentinstallments as (
	SELECT 
    	distinct(c.customer_id),
    	op.payment_installments
	FROM customers AS c
	JOIN orders AS o ON c.customer_id = o.customer_id
	JOIN order_payments AS op ON op.order_id = o.order_id
	WHERE op.payment_installments > 5 and op.payment_installments <= 10
	order by 2 desc limit 10
),customer_with_states as (
	select 
		cwh.customer_id,
		c.customer_city
	from customers_with_highpaymentinstallments as cwh
	join customers as c
	on cwh.customer_id = c.customer_id
) select distinct(customer_city) from customer_with_states


--9-)-Ödeme tipine göre başarılı order sayısı ve toplam başarılı ödeme tutarını hesaplayınız.
--En çok kullanılan ödeme tipinden en az olana göre sıralayınız.	

select * from order_payments limit 100 --payment_type
select * from orders limit 100 --order_id,order_status != 'canceled'
select distinct(order_status) from orders

--ödeme tipine göre başarılı order sayısı
select 
	payment_type,
	count(o.order_id) as order_count
from order_payments as op
join orders as o
on op.order_id = o.order_id
where order_status != 'canceled' and order_status != 'unavaible'
group by 1
order by 2 desc

--ödeme tipine göre toplam ödeme tutarı
select 
	payment_type,
	round(sum(op.payment_value)::numeric,2) as total_payment
from order_payments as op
join orders as o
on op.order_id = o.order_id
where order_status != 'canceled' and order_status != 'unavaible'
group by 1
order by 2 desc

--9-) -Tek çekimde ve taksitle ödenen siparişlerin kategori bazlı analizini yapınız. 
--En çok hangi kategorilerde taksitle ödeme kullanılmaktadır?

select from order_payments limit 100 --payment_installments
select * from products limit 100 --product_category_name

--tek çekimle ödenen siparişler
	select 
		pcnt.product_cetagory_name_eng,
		count(o.order_id) as tek_cekim_odeme_sayisi		
	from 
	orders as o 
	join order_payments as op
	on o.order_id = op.order_id
	join order_items as oi
	on oi.order_id = o.order_id
	join products as p
	on p.product_id = oi.product_id
	join product_category_name_translation as pcnt
	on pcnt.product_category_name = p.product_category_name
	where op.payment_installments = 1 and o.order_status != 'canceled' and o.order_status != 'unavaible'
	group by 1
	order by 2 desc
	
--taksitle ödenen siparişler
	select 
		pcnt.product_cetagory_name_eng,
		count(o.order_id) as tek_cekim_odeme_sayisi		
	from 
	orders as o 
	join order_payments as op
	on o.order_id = op.order_id
	join order_items as oi
	on oi.order_id = o.order_id
	join products as p
	on p.product_id = oi.product_id
	join product_category_name_translation as pcnt
	on pcnt.product_category_name = p.product_category_name
	where op.payment_installments > 1 and o.order_status != 'canceled' and o.order_status != 'unavaible'
	group by 1
	order by 2 desc
	
--En çok hangi kategorilerde taksitle ödeme kullanılmaktadır? 
with order_with_installments as (
	select 
		pcnt.product_cetagory_name_eng,
		count(o.order_id) as tek_cekim_odeme_sayisi		
	from 
	orders as o 
	join order_payments as op
	on o.order_id = op.order_id
	join order_items as oi
	on oi.order_id = o.order_id
	join products as p
	on p.product_id = oi.product_id
	join product_category_name_translation as pcnt
	on pcnt.product_category_name = p.product_category_name
	where op.payment_installments > 1 and o.order_status != 'canceled' and o.order_status != 'unavaible'
	group by 1
	order by 2 desc
)select * from order_with_installments limit 10
	






	

