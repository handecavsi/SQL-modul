--Sales tablosu oluşturma
/*veri setindeki date ve double precision verileri postgresql ile uyumlu olmadığından text 
olarak tanımlandı.*/
CREATE Table sales 
(
	id integer not null,
	orderid integer,
	orderdetail_id integer,
	date text,
	userid integer,
	username varchar(250),
	name_surname varchar(250),
	status integer,
	itemid integer,
	itemcode integer,
	itemname varchar(250),
	amount integer,
	unit_price text,
	price text,
	total_price text,
	category1 varchar(250),
	category2 varchar(250),
	category3 varchar(250),
	category4 varchar(250),
	brand varchar(250),
	gender char,
	birthdate text,
	region varchar(250),
	city varchar(250),
	town varchar(250),
	district varchar(250),
	adress text
)

/*Tablo oluşturulduktan sonra; PostgreSQL üzerinden import/export Data'dan veri 
import edildi.*/

select * from sales limit 100

--Veriyi import edebilmek için text tipinde tanımlanan veriler çekildi.
select date,birthdate,unit_price,price,total_price from sales limit 100

--unit_price,price,total_price kolonlarındaki ',' '.' olarak değiştirildi.
Update sales
	set unit_price = REPLACE(unit_price, ',', '.')

Update sales
	set price = REPLACE(price, ',', '.')
	
Update sales
	set total_price = REPLACE(total_price, ',', '.')	


/*unit_price,price,total_price kolonlarını text veri tipinden 
double_precision'a çevirmek.*/

ALTER TABLE sales
ALTER COLUMN unit_price TYPE double precision USING unit_price::double precision;

ALTER TABLE sales
ALTER COLUMN price TYPE double precision USING price::double precision;

ALTER TABLE sales
ALTER COLUMN total_price TYPE double precision USING total_price::double precision;


select unit_price, price, total_price from sales limit 100

--date ve birthdate kolonlarını timestamp tipine çevirmek.
--postgresql'de datetime kullanılmıyor. Bu nedenle timestamp kullanıldı.

--date ve birthdate verileri timestamp dönüşümüne uygun hale getirildi.
Update sales
	SET date = TO_TIMESTAMP(date, 'DD.MM.YYYY HH24:MI')

Update sales
	SET birthdate = TO_TIMESTAMP(birthdate, 'DD.MM.YYYY HH24:MI')

--date ve birthdate text kolonları timestamp olarak güncellendi.
ALTER TABLE sales
ALTER COLUMN date TYPE timestamp USING date::timestamp;

ALTER TABLE sales
ALTER COLUMN birthdate TYPE timestamp USING birthdate::timestamp;

select date,birthdate from sales limit 100