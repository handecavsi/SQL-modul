# SQL-modul
SQL Training


#**SQL DATA TYPES**

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
