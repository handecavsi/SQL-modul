# SQL-modul
SQL Training


**1.SQL DATA TYPES**

**Metinsel (String) Veri Tipleri**

-_CHAR_: Sabit uzunluktaki metin verilerini tanımlamak için kullanılır. Örnek kullanım; CHAR(20) şeklindedir. Burada giriş yapılacak metin uzunluğu
en fazla 20 karakter olabilir. Eğer metin 20 karakterden daha uzunsa geri kalan kısım atlanır. Eğer metin 20 karakterden kısaysa kalan kısımlar boşlukla
doldurulur.

-_VARCHAR_: Değişken uzunluktaki metin verilerini tanımlamak için kullanılır. Örnek kullanım VARCHAR(255) şeklindedir. 255 karakter uzunluğunda bir metin 
alanı oluşturulur. Eğer giriş verisi 20 karakter uzunluğundaysa yalnızca 20 karakterlik alan tutulur. 

-_TEXT_: Uzun metin verileri için kullanılır. CHAR ve VARCHAR'a göre daha uzun karakterdeki metin verilerini saklar. Bir makale veya bildiri içeriği TEXT
karakteri olarak tanımlanabilir. Max. 2^32-1 (4GB) veri saklayabilir. 

**Sayısal (Numeric) Veri Tipleri**

-_INTEGER(INT)_: Bir kişinin yaşı, ürün adet sayısı gibi tam sayıları tanımlamak için kullanılır. Genellikle 4 byte'lık bir veri tipidir. -2^31 
ile 2^31-1 arasında bir sayı saklayabilir.

-_SMALLINT_: Küçük tam sayılar için kullanılır. bir ürünün stok miktarını saklamak için SMALLINT kullanılabilir. genellikle 2 byte'lık bir veri tipidir ve
-2^15 ile  2^15-1 arasında bir sayı saklayabilir.

-_BIGINT_: Büyük tam sayılar için kullanılır. Örneğin, bir ülkenin nüfusunu saklamak için BIGINT kullanılabilir. BIGINT veri tipi genellikle 8 byte'lık bir veri 
tipidir ve -2^63 ile 2^63-1 arasında bir sayı saklayabilir.

-_FLOAT_: Ondalıklı sayılar için kullanılır. Örneğin, bir ürünün fiyatını saklamak için FLOAT kullanılabilir. FLOAT veri tipi genellikle 4 byte'lık bir veri tipidir 
ve ondalık noktasına kadar 7 veya 8 hane hassasiyette bir sayı saklayabilir.

-_DECIMAL_: Ondalıklı sayıları sabit bir hassasiyette saklar. Örneğin, DECIMAL(10,2) veri tipi, en fazla 10 rakamlı ve 2 ondalıklı sayıları saklar. Bu veri tipi, 
hassasiyet ve doğruluğu ön planda tutan uygulamalar için idealdir. Finansal hesaplamalar için DECIMAL(10,4) veri tipini kullanabilirsiniz.

-_DOUBLE PRECISION_:Ondalıklı sayıları daha yüksek bir hassasiyette saklar. Bu veri tipi, daha büyük sayıları ve daha yüksek hassasiyeti gerektiren uygulamalar için idealdir. 
Bir fiziksel ölçüm için DOUBLE PRECISION kullanabilirsiniz.


**BOOLEAN Veri Tipi**

_BOOLEAN_ veri tipi, true/false (doğru/yanlış) değerlerini saklamak için kullanılır. Bu veri tipi, sadece iki değer alabilir: true ve false. Örnek verecek olursak:

Bir kullanıcının hesabının aktif/deaktif durumunu saklamak için BOOLEAN veri tipi kullanabilirsiniz.
Bir ürünün stokta/stokta olmadığı durumunu saklamak için BOOLEAN veri tipi kullanabilirsiniz.
Bir sorunun çözüldü/çözülmedi durumunu saklamak için BOOLEAN veri tipi kullanabilirsiniz.


**Tarih-Zaman Veri Tipleri**

-_DATE_: Sadece tarih bilgisini saklar, "2022-12-31" gibi. Örneğin bir ürünün son kullanma tarihini saklamak için DATE veri tipi kullanabilirsiniz.

-_TIME_: Sadece saat bilgisini saklar, "12:30:15" gibi. Bir siparişin saatini saklamak için TIME veri tipi kullanabilirsiniz.

-_DATETIME_: Tarih ve saat bilgisini birlikte saklar, "2022-12-31 12:30:15" gibi. Bir haberin yayınlanma tarihini saklamak için DATETIME veri tipi kullanabilirsiniz.

-_TIMESTAMP_: Tarih ve saat bilgisini birlikte saklar ve ayrıca bu bilgilerin hangi zaman diliminde olduğunu da saklar. Örneğin, "2022-12-31 12:30:15 UTC" gibi. 
Bir gönderinin zaman damgasını saklamak için TIMESTAMP veri tipi kullanabilirsiniz.

-_INTERVAL_: Zaman aralığını saklar. Örneğin "2 years 3 months 4 days" gibi. Bir projenin süresini saklamak için INTERVAL veri tipi kullanabilirsiniz.

**Array Veri Tipi**

SQL veritabanlarında, array veri tipleri bir dizi (koleksiyon) içinde birden çok veriyi saklamak için kullanılır. Array veri tipleri, bir kolon içinde birden çok 
veriyi saklamak için kullanılabilir ve genellikle bir tablo içinde bir kullanıcının birden çok özelliğini saklayabilir. Örneğin bir web sitesindeki kullanıcının 
bir veya birden çok telefon numarasını saklamak için array veri tipi kullanılabilir.


**2.Veri Tabanlarında Anahtar (Key) Kavramı**

İlişkisel veritabanları, verileri saklamak ve sorgulamak için SQL (Structured Query Language) kullanır. Veritabanlarında oluşturduğumuz tablonun bir diğer tablo ile ilişki kurabilmesi için anahtar kavramını anlamak gerekir. 

-_Primary Key (Birincil Anahtar)_

Primary Key (Birincil Anahtar) bir veri tabanında bir tablo içerisindeki her bir kaydı benzersiz bir şekilde tanımlamak için kullanılan bir anahtardır. Birincil anahtar, tablodaki diğer anahtarlar primary key'den referans alır. 

-_Foreign Key (Yabancı Anahtar)_

Foreign Key (Yabancı Anahtar) SQL'de bir başka tablonun birincil anahtarına bağlantı kurmak için kullanılan anahtardır. Foreign key, ilişkisel veri tabanlarında tablolar arasında ilişki tanımlamak için kullanılır.

Foreign key ile:
- Veri tabanındaki tablolar arasında ilişki kurulur.
- Veri güvenliği sağlanır.
- Veri kalitesi sağlanır.
- Veri normalizasyonu sağlanır.

![foreign-key-simple-mysql](https://github.com/handecavsi/SQL-modul/assets/34586454/b30f0bd5-18cf-480a-b9d4-0d4f2cc6c7fc)


**3.SQL'de Temel Operatörler**

-_CREATE Komutu_

SQL'de, CREATE komutu veritabanı veya tablolarda yeni bir tablo oluşturmak için kullanılır. 

Tablo oluşturmak için genel kullanım şekli şöyledir:

CREATE TABLE tablo_ismi (

kolon1_ismi veri_tipi,

. . .

);

test_db isimli bir database oluşturmak ve bu database'de bir tablo tanımlamak için aşağıdaki işlemler yapılır;

create database test_db; 

create table ogrenci <br></br>
( <br></br>
  id integer, <br></br>
  isim varchar(30), <br></br>
  soyisim varchar(30), <br></br>
  primary key (id) <br></br>

)

create table ders <br></br>
( <br></br>
  id integer primary key, <br></br>
  name varchar(30), <br></br>
  ogrenci_id integer <br></br>
  foreign key (pgrenci_id) references ogrenci(id) <br></br>
)

-_ALTER/DROP Komutu_

- SQL'de, ALTER komutu veritabanı veya tablolarda mevcut olan tablonun yapısını veya özelliklerini değiştirmek için kullanılır. Genel olarak ALTER komutu ile tablolara kolon ekleme, kolon silme, kolon ismini değiştirme, kolon veri tipini değiştirme, constraint ekleme veya silme gibi işlemler yapılabilir. 

- SQL'de, DROP komutu veritabanı veya tablolarda mevcut olan tablo, index, view, procedure, trigger, sequence, synonym, domain, role, constraint gibi veritabanı objelerini silmek için kullanılır.

ALTER KUllanım Örnekleri:

ALTER TABLE calisanlar ADD COLUMN cinsiyet VARCHAR(10) ---calisanlar tablosuna cinsiyet isimli kolon ekler.
ALTER TABLE calisanlar DROP COLUMN cinsiyet ---calisanlar tablosundan cinsiyet isimli kolonu siler. 
ALTER TABLE calisanlar RENAME COLUMN ad TO isim ---calisanlar tablosunda ad isimli sütunu isim olarak değiştirir.

ALTER komutu sadece tablolara değil aynı zamanda veritabanlarına da uygulanabilir. Örneğin;

ALTER DATABASE veritabani_ismi SET default_character_set = utf8

DROP Kullanım Örnekleri:

DROP TABLE table_name;

DROP INDEX index_name;

DROP VİEW view_name;

DROP PROCEDURE procedure_name;

DROP TRIGGER trigger_name;

DROP SEQUENCE sequence_name;

DROP SYNONYM synonym_name;

DROP DOMAIN domain_name;

DROP ROLE role_name;

DROP CONSTRAINT constraint_name;

- DROP; belirtilen tablo, index, view, procedure, trigger, sequence, synonym, domain, role, constraint gibi veritabanı objelerini veritabanından tamamen siler.

-_INSERT/COPY Komutu_

- SQL'de, INSERT komutu veritabanı veya tablolarda mevcut olan tablo'ya yeni veri eklemek için kullanılır.

INSERT INTO calisanlar <br></br>
( <br></br>
  ad, <br></br>
  soyad, <br></br>
  yas <br></br>
) <br></br>
VALUES <br></br>
( <br></br>
'HANDE' <br></br>
'ÇAVŞİ ZAİM' <br></br>
30 <br></br>
)

- COPY komutu, veritabanındaki bir tablonun verilerini veya verileri içeren bir dosyadan veritabanına veri yüklemek için kullanılır. Bu komut genellikle çok hızlı ve büyük veri setlerinin yüklenmesi için kullanılır.

COPY calisanlar <br></br>
( <br></br>
ad, <br></br>
soyad, <br></br>
yas <br></br>
) <br></br>
FROM '/tmp/calisanlar.csv' WITH (FORMAT CSV, DELIMITER ',')

/tmp/calisanlar.csv adlı dosyadaki verileri çalışanlar tablosuna yükler, format csv ve delimiter ',' olarak ayarlar. Ayrıca, COPY komutu ile veritabanındaki verileri yedeklemek veya başka bir veritabanına taşımak da mümkündür.

-_UPDATE Komutu_

- SQL'de, UPDATE komutu veritabanı veya tablolarda mevcut olan tabloda bulunan verileri güncellemek için kullanılır.

UPDATE calisanlar SET yaş=30 WHERE ad = 'HANDE'

Update komutunda WHERE ifadesi önemlidir. Güncellenecek veride filtreleme yapmayı sağlar. Bu sorguda ismi HANDE olan verinin YAŞ bilgisi 30 olarak 
güncellenir. EĞER WHERE ad='HANDE' ifadesi kullanılmasaydı tüm YAŞ verileri 30 olarak güncellenirdi. Bu nedenle UPDATE komutu kullanılırken; WHERE
ifadesini kullanmak hayati önem taşır. 

-_TRUNCATE/DELETE Komutu_

- SQL'de, TRUNCATE komutu veritabanı veya tablolarda mevcut olan tablonun verilerini silmek için kullanılır. Bu komut, veritabanındaki bir tablonun tüm satırlarını veya kayıtlarını hızlı bir şekilde siler.

TRUNCATE TABLE calisanlar --calisanlar tablosundaki tüm verileri silerek tabloyu temizler. 

- SQL'de, DELETE komutu veritabanı veya tablolarda mevcut olan tablonun verilerini silmek için kullanılır. Bu komut, veritabanındaki bir tablonun belirli satırlarını veya kayıtlarını siler.

DELETE FROM calisanlar WHERE ad = 'John' --WHERE ile filtreleme yaparak yalnızca adı 'John' olan satır verisini temizler. Diğer veriler silinmez.

Yukarıdaki sorgu aynı UPDATE sorgusunda olduğu gibi WHERE koşulu ile filtreleme yapar. Eğer WHERE ad='John' filtresi kullanılmasaydı tablodaki tüm
veriler silinirdi. Bu nedenle UPDATE komutunda olduğu gibi DELETE komutunda da WHERE koşulu hayati önem taşır. 

-_SELECT Komutu & Aritmetik Fonksiyonlar_

- SQL'de, SELECT komutu veritabanı veya tablolarda mevcut olan verileri sorgulamak için kullanılır. Bu komut, veritabanındaki bir tablonun veya birden fazla tablonun belirli satırlarını veya kayıtlarını seçerek döndürür.

SELECT ad, soyad FROM calisanlar WHERE yas > 30 --yaşı 30'dan büyük olan çalışanların adını ve soyadını döndürür.

SQL Pratikleri yapmak için kullanışlı bir link: https://www.hackerrank.com/domains/sql


**4.String Functions & Case When & Other Clauses**

_STRING FUNCTIONS (Metinsel Fonksiyonlar)_

- SQL'de string fonksiyonlar, karakter dizisi (string) verileri üzerinde işlemler yapmak için kullanılan işlevlerdir. Bu fonksiyonlar, string verilerini manipüle etmek, dönüştürmek veya karşılaştırmak için kullanılabilirler.
- Bu fonksiyonlar, SQL sorgularında kullanılan WHERE, SELECT, ORDER BY ve GROUP BY gibi ifadelerde sıklıkla kullanılırlar. Örneğin, bir tablodaki bir sütunun değerini kesmek veya birleştirmek, bir karakter dizisinde belirli bir alt dizenin konumunu bulmak veya belirli bir harf veya harf dizisini içeren tüm değerleri seçmek gibi işlemler için kullanılabilirler.
- Metinsel fonksiyonlar, verilerin manipülasyonunu daha kolay hale getirerek verilerin analiz edilmesini ve raporlanmasını kolaylaştırır. Ayrıca, birçok programlama dili ve veritabanı yönetim sistemi, metinsel fonksiyonlar da dahil olmak üzere string işleme için çeşitli fonksiyonlar sağlamaktadır.

<span style="text-decoration:underline;">CONCAT</span>

-PostgreSQL'de CONCAT()  fonksiyonu, verilen iki veya daha fazla dizeyi birleştirerek tek bir dize oluşturur. Fonksiyonun kullanımı şu şekildedir:

SELECT concat(first_name, ' ', last_name) as full_name FROM employees;


