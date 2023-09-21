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

*-CONCAT*

- PostgreSQL'de CONCAT()  fonksiyonu, verilen iki veya daha fazla dizeyi birleştirerek tek bir dize oluşturur. Fonksiyonun kullanımı şu şekildedir:

SELECT concat(first_name, ' ', last_name) as full_name FROM employees;

- Concat fonksiyonu, özellikle metinleri birleştirmek gerektiği durumlarda kullanışlıdır. Ayrıca, concat fonksiyonu yerine || operatörü de kullanılabilir. Bu operatör de aynı şekilde iki dizeyi birleştirir:

string1 || string2

*-LEFT*

- LEFT()  fonksiyonu, verilen bir dizenin belirli bir sayıda sol karakterini döndürür. Fonksiyonun kullanımı şu şekildedir:

SELECT left(first_name, 3) as initial FROM employees; ---first_name sütunundan veri alır ve ilk üç karakterini döndürür.

*-RIGHT*

- RIGHT fonksiyonu, verilen bir dizenin belirli bir sayıda sağ karakterini döndürür. Fonksiyonun kullanımı şu şekildedir:

SELECT right(phone_number, 4) as last_four_digits FROM employees; --phone sütunundan veri alır ve son dört karakterini döndürür.

*-LENGTH*

- LENGTH() fonksiyonu, bir karakter dizisinin uzunluğunu döndüren bir fonksiyondur. Yani, bu fonksiyon bir karakter dizisindeki karakterlerin sayısını sayar.

SELECT length(first_name), first_name FROM employees; --first_name'in karakter uzunluğunu verir. 

*-LOWER*

- PostgreSQL'de LOWER() fonksiyonu, bir karakter dizisindeki tüm karakterleri küçük harflere dönüştürür.

SELECT LOWER(first_name), LOWER(last_name) FROM employees;

*-UPPER*

- PostgreSQL'de UPPER() fonksiyonu, bir karakter dizisindeki tüm karakterleri büyük harflere dönüştürür.

SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper FROM employees ORDER BY last_name_upper, first_name_upper;

*-TRIM*

- PostgreSQL'de TRIM() fonksiyonu, bir karakter dizisindeki boşlukları, belirtilen karakterleri veya karakter dizisini kırparak temizler."LEADING", "TRAILING" ve "BOTH" parametreleri, bu karakterleri nereden kaldıracağını belirtir.

TRIM([LEADING | TRAILING | BOTH] trim_character FROM string)

Örnekler:

SELECT TRIM('   hello   '); -- "hello" <br></br>
SELECT TRIM(LEADING '0' FROM '0001234'); -- "1234" <br></br>
SELECT TRIM(TRAILING '!' FROM 'hello!!!!'); -- "hello" <br></br>
SELECT TRIM(BOTH ' ' FROM '   hello   '); -- "hello"

*-REPLACE*

- PostgreSQL'deki REPLACE() fonksiyonu, bir karakter dizisinde belirli bir karakter dizisini bulur ve onu başka bir karakter dizisiyle değiştirir.

SELECT REPLACE(first_name, 'a', 'o'), REPLACE(last_name, 'a', 'o') FROM employees; --Tüm çalışanların isimlerindeki "a" harfini "o" harfi ile değiştirir. <br></br>

SELECT REPLACE(email, 'sqltutorial.org', 'yahoo.com') FROM employees; -- e-posta adreslerindeki "sqltutorial.org" uzantısını "yahoo.com" ile  değiştirir.

*-SPLIT PART*

- PostgreSQL'deki SPLIT_PART() fonksiyonu, bir karakter dizisini belirli bir ayraç karakterine göre parçalar ve parçalardan birini seçer.

SELECT SPLIT_PART(email, '@', 1) AS username FROM employees; --employees tablosundaki email adreslerini @ işaretini baz alarak iki parçaya ayırır ve 1. parçayı seçer. Böylece mail adreslerindeki ilk kısım kullanıcı adı olarak belirlenir. 

_CASE WHEN EXPRESSION_

- "CASE WHEN" SQL'de koşul ifadesi ile kullanılan bir kontrol yapısıdır.  Bu ifade, belirli bir koşulu test etmenizi ve koşulun doğru veya yanlış olmasına bağlı olarak farklı bir değer veya ifade döndürmenizi sağlar.

      CASE 

      WHEN condition1 THEN result1 

      WHEN condition2 THEN result2 

      ... 

      ELSE result 

      END

Örnek olarak, bir "customers" tablosunda "city" sütunu bulunuyor ve müşterilerin yaşadıkları şehirleri sorgulamak istiyoruz. Aynı zamanda, bazı müşterilerin yaşadıkları şehirlerin yanlış yazıldığı fark ediliyor. Bu durumda, aşağıdaki örnek SQL sorgusu ile müşterilerin doğru şehirlerini elde edebiliriz:

    SELECT 

    customer_name, 

    CASE 

        WHEN city = 'Istanbl' THEN 'Istanbul' 

        WHEN city = 'Ankra' THEN 'Ankara'

        ELSE city 

    END AS city_corrected  

    FROM customers;

Örneğin, bir müşteri veritabanında, bir müşterinin ülkesine göre farklı vergi oranları uygulanması gerekiyorsa, "CASE WHEN" ifadesi kullanılabilir. Aşağıdaki örnek, bir müşterinin ülkesine göre farklı vergi oranları uygulayan bir sorgudur:

    SELECT name, country, 

       CASE WHEN country = 'USA' THEN price * 0.08 

            WHEN country = 'Canada' THEN price * 0.10 

            ELSE price * 0.12 

       END AS tax 

    FROM customers;

_OTHER CLAUSES (ORDER BY, AS, LIMIT, DISTINCT, HAVING)_

*-ORDER BY*

- SQL'de ORDER BY komutu, veritabanındaki belirli bir tablo veya sütun içindeki kayıtların belirli bir kriterlere göre sıralanmasını sağlar. Örneğin, müşterilerin adlarına göre sıralamak istediğinizde veya satışların tarih sırasına göre sıralamak istediğinizde ORDER BY kullanabilirsiniz.

SELECT * FROM orders ORDER BY order_date,total_price; --"orders" tablosundaki siparişlerin tarih ve tutar sırasına göre sıralanmış halde döndürür.

*-AS*

- SQL'de AS komutu, sorgularda kullanılan sütun veya tablo adlarının yerine farklı bir isim vermenizi sağlar. Bu, sorguların daha okunaklı ve anlaşılır olmasını sağlar. Örneğin, bir tablonun adı uzun ve anlaşılmazsa, bu tablonun sorgularda kullanılması için kısa ve anlaşılır bir ad vermeniz mümkündür.

SELECT SUM(total_price) AS 'Total Sales' FROM orders; -- "orders" tablosundaki siparişlerin toplam tutarını döndürür ve sütun adını "Total Sales" olarak değiştirir. Aynı zamanda AS komutu ile tablo adlarınıda değiştirebilirsiniz. <br></br>

SELECT * FROM customers AS 'Müşteriler' --"customers" tablosunun adını "Müşteriler" olarak değiştirir.

*-LIMIT*

- LIMIT, SQL sorgularında sorgunun sonucunda döndürülecek olan satır sayısını belirlemek için kullanılan bir ifadedir. Örneğin, veritabanındaki tüm müşteri kayıtlarını almak yerine sadece ilk 10 kaydı almak isteyebilirsiniz. Bu durumda, sorgunun sonunda LIMIT 10 kullanılır.

SELECT * FROM customers LIMIT 10;

- Ayrıca, LIMIT ile OFFSET kullanarak belirli bir aralıkta kayıtları alabilirsiniz. Örneğin, 21. ila 30. müşteri kayıtlarını almak için:

SELECT * FROM customers LIMIT 10 OFFSET 20; -customers tablosundaki 21. ila 30. kayıtları döndürür.

*-DISTINCT*

- DISTINCT, SQL sorgularında veritabanındaki aynı değerleri tekrar etmeden sadece farklı değerleri döndürmek için kullanılan bir ifadedir. Örneğin, veritabanındaki tüm müşteri kayıtlarını almak yerine sadece farklı müşteri adlarını almak isteyebilirsiniz. Bu durumda, sorgunun başına DISTINCT yazılır.

SELECT DISTINCT name FROM customers; <br></br>
SELECT city, COUNT(DISTINCT name) FROM customers GROUP BY city; --customers tablosundaki tüm farklı şehirleri ve bu şehirlerde yaşayan farklı müşteri sayılarını döndürür.

*-HAVING*

-  WHERE anahtar sözcüğü aggregate fonnksiyonlarıyla kullanılamadığı için HAVING SQL diline eklenmiştir. Kullanımı aşağıdaki gibidir:

        SELECT column_name(s)
        FROM table_name
        WHERE condition
        GROUP BY column_name(s)
        HAVING condition
        ORDER BY column_name(s);


       SELECT COUNT(CUstumerID), Country
       FROM Customers
       GROUP BY Country
       HAVING COUNT(CustomerID)>5;

- Yukarıdaki sorguda her ülkeddeki müşteri sayısı listelenir ve müşteri sayısı 5'ten fazla olan ülkeler seçilir. 
     
      SELECT COUNT(CustomerID), Country
      FROM Customers
      GROUP BY Country
      HAVING COUNT(CustomerID) > 5
      ORDER BY COUNT(CustomerID) DESC;

- Yukarıdaki sorguda müşteri sayısı 5'ten fazla olan ülkeler azalan şekilde sıralanır. COUNT(CostumerID) Where koşuluyla birlikte kullanılmaz. Bunun yerine GROUP BY HAVING ifadesi kullanılır.

*-WHERE Komutu ve LIKE Operatörü*

- J ile başlayan isimler:

      SELECT * FROM employees WHERE name LIKE 'J%';

- @gmail.com ile biten mail adresleri:

      SELECT * FROM employees WHERE email LIKE '%@gmail.com';

- Aşağıdaki sorgu "employees" tablosundaki tüm kayıtları seçer ve sadece "name" sütununda "J_n" harfleri ile başlayan isimlerin olan kayıtları gösterir.

      SELECT * FROM employees WHERE name LIKE 'J_n';

- Aşağıdaki sorgu L ile başlayan, ardından bir joker karakter ardından nd ve ardından iki joker karakterle başlayan müşterileri döndürür:

      SELECT * FROM Customers
      WHERE city LIKE 'L_nd__';

  **5.Aggregate Functions (Toplu Fonksiyonlar)**

- SQL'de Aggregate Functions (Toplu Fonksiyonlar), bir tablonun birden fazla satırındaki verileri tek bir değer olarak özetler. Bunlar genellikle COUNT, SUM, AVG, MAX, MIN gibi fonksiyonlardır. Bu fonksiyonlar sadece SELECT sorgularında kullanılabilir ve genellikle GROUP BY komutu ile birlikte kullanılır.

*-COUNT()*

- "employees" tablosunda kaç tane kayıt olduğunu hesaplamak için aşağıdaki sorguyu kullanabiliriz:

      SELECT COUNT(*) FROM employees;
  
- manager_id'si 100 olan kaç çalışan olduğu aşağıdaki sorguyla listelenir:
  
      SELECT COUNT(employee_id) FROM employees WHERE manager_id= 100;

***COUNT fonksiyonu, NULL değerlerini saymaz. Eğer NULL değerleri dahil edilmek isteniyorsa COUNT(column_name) yerine COUNT(*) kullanılmalıdır.

*-COUNT() with GROUP BY*

- Aşağıdaki SQL sorgusu "employees" tablosundaki kişilerin departmanlara göre gruplandırılmış sayısını döndürür.

      SELECT department_id, COUNT(*) FROM employees GROUP BY department_id;

*-SUM, AVG & GROUP BY*

- SQL'de SUM fonksiyonu, bir tablonun belirli bir sütununda bulunan sayısal değerlerin toplamını hesaplar. Bu fonksiyon genellikle veritabanındaki verilerin toplamını belirlemek için kullanılır. SUM fonksiyonu sadece SELECT sorgularında kullanılabilir ve genellikle GROUP BY komutu ile birlikte kullanılır.

       SELECT department_id, SUM(salary) FROM employees GROUP BY department_id;

- SQL'de AVG fonksiyonu, bir tablonun belirli bir sütununda bulunan sayısal değerlerin ortalamasını hesaplar. Bu fonksiyon genellikle veritabanındaki verilerin ortalamasını belirlemek için kullanılır. AVG fonksiyonu sadece SELECT sorgularında kullanılabilir ve genellikle GROUP BY komutu ile birlikte kullanılır.

      SELECT department_id, AVG(salary) FROM employees GROUP BY department_id;

*-MIN, MAX & GROUP BY*

- SQL'de MAX fonksiyonu, bir tablonun belirli bir sütununda bulunan en yüksek değeri döndürür. Bu fonksiyon genellikle veritabanındaki verilerin en yüksek değerini belirlemek için kullanılır. MAX fonksiyonu sadece SELECT sorgularında kullanılabilir ve genellikle GROUP BY komutu ile birlikte kullanılır.

      SELECT MAX(salary) FROM employees WHERE department_id = 8;
      SELECT department_id, MAX(salary) FROM employees GROUP BY department_id;

- SQL'de MIN fonksiyonu, bir tablonun belirli bir sütununda bulunan en düşük değeri döndürür. Bu fonksiyon genellikle veritabanındaki verilerin en düşük değerini belirlemek için kullanılır. MIN fonksiyonu sadece SELECT sorgularında kullanılabilir ve genellikle GROUP BY komutu ile birlikte kullanılır.

      SELECT MIN(salary) FROM employees WHERE department_id = 3;
      SELECT department_id, MIN(salary) FROM employees GROUP BY department_id;


**6.SQL'de JOIN Komutu**

- SQL join işlemleri, bir veya daha fazla tablo arasında veri eşleme işlemidir. Tablolar arasındaki ilişkilere göre farklı join türleri bulunmaktadır.

  1. Inner Join: Veritabanındaki iki veya daha fazla tablo arasındaki eşleşen verilerin birleştirilmesini sağlar. Inner join, yalnızca ilişkili olan verilerin seçilmesine olanak tanır. İlişkili veriler, belirli bir kriter (örneğin, birleştirme anahtarı) üzerinden eşleştirilir. Eşleşmeyen veriler atılır ve sadece eşleşen veriler görüntülenir. Inner join, verileri birleştirirken verilerin verimli bir şekilde sorgulanmasını ve analiz edilmesini sağlar.
  2. Left Join: Veritabanındaki iki veya daha fazla tablo arasındaki verilerin birleştirilmesini sağlar. Left join, sol tablo içindeki tüm verileri ve sağ tablo ile eşleşen verileri seçer. Eşleşmeyen sağ tablo verileri NULL olarak görüntülenir. Bu tür bir join, sol tablo verilerinin tümünün görüntülenmesini ve eşleşmeyen sağ tablo verilerinin belirlenmesini sağlar. Left join, verilerin tamamının analiz edilmesi, raporlama veya veri keşfetme gibi amaçlar için kullanılabilir.
  3. Right Join: Veritabanındaki iki veya daha fazla tablo arasındaki verilerin birleştirilmesini sağlar. Right join, sağ tablo içindeki tüm verileri ve sol tablo ile eşleşen verileri seçer. Eşleşmeyen sol tablo verileri NULL olarak görüntülenir. Bu tür bir join, sağ tablo verilerinin tümünün görüntülenmesini ve eşleşmeyen sol tablo verilerinin belirlenmesini sağlar. Right join, verilerin tamamının analiz edilmesi, raporlama veya veri keşfetme gibi amaçlar için kullanılabilir.
  4. Full Outer Join: Veritabanındaki iki veya daha fazla tablo arasındaki verilerin tam birleştirilmesini sağlar. Full outer join, sol ve sağ tablodaki tüm verileri, her iki tablo arasındaki eşleşen ve eşleşmeyen verileri de dahil olmak üzere seçer. Eşleşmeyen veriler NULL olarak görüntülenir. Full outer join, verilerin tamamının analiz edilmesi, raporlama veya veri keşfetme gibi amaçlar için kullanılabilir. Ayrıca, iki tablo arasındaki eşleşmeyen verilerin belirlenmesine ve düzeltilmesine yardımcı olabilir.
  5. Cross Join: Veritabanındaki iki veya daha fazla tablo arasında herhangi bir ilişki olmaksızın verilerin birleştirilmesini sağlar. Bu join türü, her bir kayıt için diğer tablonun tüm kayıtlarıyla birleştirilmesini sağlar. Yani bir tablo içindeki her bir kayıt diğer tablo içindeki tüm kayıtlarla eşleştirilir. Cross join, verileri çok fazla artırabilir ve performans sorunlarına yol açabilir, bu yüzden performansı önemli olan uygulamalarda sıklıkla kullanılmaz. Ancak veri keşfetme ve analitik uygulamalarda kullanılabilir.

