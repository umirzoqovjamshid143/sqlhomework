Define the following terms: data, database, relational database, and table.
1. Data (Ma’lumot):
Ma’lumot — bu raqamlar, matnlar, faktlar yoki kuzatuvlar shaklida ifodalangan xom (ya’ni hali tahlil qilinmagan) axborotdir. Masalan: “Ali 20 yoshda” – bu ma’lumotdir.
2. Database (Ma’lumotlar bazasi):
Ma’lumotlar bazasi — bu ma’lumotlarni tartib bilan saqlash, ularga tezda murojaat qilish va ularni boshqarish uchun mo‘ljallangan tizimdir. Ma’lumotlar bir necha jadval, ko‘rinishlar, indekslar va boshqa obyektlar shaklida saqlanadi.
3. Relational Database (Relatsion ma’lumotlar bazasi):
Relatsion ma’lumotlar bazasi — bu ma’lumotlarni jadvallar ko‘rinishida (satrlarda va ustunlarda) saqlovchi ma’lumotlar bazasidir. Har bir jadvalda ustunlar (fields) va satrlar (records) mavjud bo‘ladi va ular o‘zaro bog‘langan bo‘lishi mumkin.
 4. Table (Jadval):
Jadval — bu relatsion ma’lumotlar bazasining asosiy tuzilmasi bo‘lib, unda ma’lumotlar qat’iy formatda (ustunlar va satrlar ko‘rinishida) saqlanadi. Har bir ustun ma’lum bir turdagi ma’lumotni, har bir satr esa bir obyekt yoki yozuvni ifodalaydi.

List five key features of SQL Server.

1. Ma’lumotlar xavfsizligi (Security)
SQL Server ma’lumotlarni shifrlash, foydalanuvchini aniqlash (autentifikatsiya) va foydalanuvchi huquqlarini boshqarish orqali ma’lumotlaringizni xavfsiz saqlaydi.
 2. Zaxira olish va tiklash (Backup and Restore)
Ushbu tizimda ma’lumotlar bazasining nusxasini olish (backup) va yo‘qolgan ma’lumotlarni tiklash (restore) imkoniyati mavjud.
 3. Yuqori ishlash tezligi (High Performance)
SQL Server tez ishlov berish, indekslash, va keshlash texnologiyalari orqali katta ma’lumotlarni tezda qayta ishlay oladi.
 4. Kengayuvchanlik va uzluksiz ishlash (Scalability and High Availability)
Katta hajmdagi ma’lumotlar bilan ishlashga mos. Always On funksiyasi bilan tizim doim faol holatda ishlay oladi, ya’ni uzilishsiz xizmat ko‘rsatadi.
 5. Biznes tahlil vositalari (Business Intelligence Tools)
SQL Server tarkibida SSRS (Reporting), SSIS (Integration) kabi vositalar mavjud bo‘lib, ular ma’lumotlarni tahlil qilish va hisobotlar tuzish imkonini beradi.

What are the different authentication modes available when connecting to SQL Server? (Give at least 2)

SQL Serverga ulanishda quyidagi autentifikatsiya rejimlari mavjud:
Windows Authentication – Bu rejimda foydalanuvchi Windows tizimidagi akkauntidan foydalangan holda tasdiqlanadi. U xavfsizroq hisoblanadi, chunki parollarni alohida saqlash talab qilinmaydi.
SQL Server Authentication – Bu rejimda foydalanuvchi SQL Serverda yaratilgan foydalanuvchi nomi va parolidan foydalanadi. Windows akkauntidan mustaqil ishlaydi.
Ikkala rejim birgalikda ishlatilsa, bu Mixed Mode Authentication deb ataladi.

Create a new database in SSMS named SchoolDB.

SSMS grafik interfeysi orqali yaratish:
SQL Server Management Studio dasturini oching va SQL Serverga ulaning.
Chap tomondagi Object Explorer oynasida Databases papkasiga o‘ng tugma bilan bosing.
New Database... ni tanlang.
Ochilgan oynada Database name qatoriga SchoolDB deb yozing.
OK tugmasini bosing.
T-SQL kod yordamida yaratish:
CREATE DATABASE SchoolDB;
SSMS da yangi query oynasini oching.
Yuqoridagi kodni yozing yoki nusxa ko‘chiring.
Execute tugmasini bosing yoki F5 ni bosing.

Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

Describe the differences between SQL Server, SSMS, and SQL.

SQL (Strukturaviy So‘rov Tili)
Bu ma’lumotlar bazasini boshqarish va manipulyatsiya qilish uchun ishlatiladigan dasturlash tili.
SQL yordamida ma’lumotlarni yaratish, o‘qish, yangilash va o‘chirish bo‘yicha so‘rovlar yoziladi.
Misol: SELECT * FROM Customers;, INSERT INTO Orders VALUES(...);
SQL Server
Bu Microsoft kompaniyasi tomonidan ishlab chiqilgan Munosabatli Ma’lumotlar Bazasi Boshqaruv Tizimi (RDBMS).
SQL tilidan foydalangan holda ma’lumotlarni saqlaydi, boshqaradi va olib keladi.
Bu ma’lumotlar saqlanadigan dasturiy ta’minotdir.
SSMS (SQL Server Management Studio)
Bu SQL Serverni boshqarish uchun ishlatiladigan grafik interfeysli dastur.
Foydalanuvchilar SQL so‘rovlarini yozish, bazalarni boshqarish, serverlarni sozlash va ma’muriyat ishlarini oson bajarishlari uchun mo‘ljallangan.
Bu SQL Server bilan ishlash uchun qulay boshqaruv muhiti.

Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
 DQL (Data Query Language) — Ma’lumot So‘rovlari Tili
 SELECT * FROM Employees WHERE Department = 'Sales';
 DML (Data Manipulation Language) — Ma’lumotlarni Manipulyatsiya Qilish Tili
 INSERT INTO Employees (Name, Department) VALUES ('Alice', 'HR');
UPDATE Employees SET Department = 'Marketing' WHERE Name = 'Alice';
DELETE FROM Employees WHERE Name = 'Alice';
DDL (Data Definition Language) — Ma’lumotlar Tuzilmasini Belgilash Tili
CREATE TABLE Employees (
    ID int PRIMARY KEY,
    Name varchar(50),
    Department varchar(50));
ALTER TABLE Employees ADD Salary int;
DROP TABLE Employees;
DCL (Data Control Language) — Ma’lumotlarni Boshqarish Tili
GRANT SELECT, INSERT ON Employees TO User1;
REVOKE INSERT ON Employees FROM User1;
TCL (Transaction Control Language) — Tranzaksiyalarni Boshqarish Tili
UPDATE Employees SET Salary = Salary + 1000 WHERE Department = 'Sales';
SAVEPOINT BeforeBonus;
ROLLBACK TO BeforeBonus;
COMMIT

Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, FirstName, LastName, Age)
VALUES
  (1, 'Ali', 'Karimov', 20),
  (2, 'Sara', 'Nurmuhammedova', 22),
  (3, 'Olim', 'Rahimov', 19);

Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link :https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak

 Faylni yuklab olish:
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak manzilidan AdventureWorksDW2022.bak faylini yuklab oling.

 SQL Server Management Studio (SSMS) dasturini oching va serverga ulang.
 Bazani tiklash:
Object Explorer’da Databases ustiga o‘ng tugma bosing.

Restore Database... tanlang.
 Zaxira faylini tanlash:
Source bo‘limida Device ni tanlang.

Yonidagi ... tugmasini bosing.

Add tugmasi yordamida AdventureWorksDW2022.bak faylini ko‘rsating va tanlang.

 Bazani nomini kiriting (masalan, AdventureWorksDW2022).
 Options bo‘limida, agar kerak bo‘lsa, Overwrite the existing database (WITH REPLACE) ni belgilang.
 OK tugmasini bosing va tiklash jarayonining tugashini kuting.
 Bazani yangilang va ma’lumotlar mavjudligini tekshiring.
