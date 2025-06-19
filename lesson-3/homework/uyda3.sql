Easy-Level Tasks (10)

    Define and explain the purpose of BULK INSERT in SQL Server.
  BULK INSERT - bu sql server buyrug'i bo'lib u katta hajmdegi malumotlarni to'g'ridan-to'g'ri jadvalga tez va samarali yuklash imkonini beradi.
    List four file formats that can be imported into SQL Server
  1. CSV (Comma-Separated Values)
  2. TXT (Plain Text File)
  3. XML (eXtensible Markup Language)
  4. Excel fayllari (XLS, XLSX)
    Create a table Products with c olumns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
    create table Products (  ProductID int primary key,    ProductName VARCHAR(50),    Price DECIMAL(10, 2))

    Insert three records into the Products table using INSERT INTO.
  insert into (1 , smartphones , 1000$)
  insert into (2 , laptops , 1500$)
  insert into (3 , books , 10$)
    Explain the difference between NULL and NOT NULL.
  NULL = mavhum bu nol ham emas aniq bir son ham emas, lekin biz buni id yoki price va shunga oxshash jadvalarda ishlata olamiz 
  NOT NULL = null qiymat mumkun emas degan manoni anglatadi, bunga aniq bir qiymat kerak.
    Add a unique constraint to the ProductName column in the Products table.
  alter table Products 
  add constraint laptops unique(laptops)
    Write a comment in a SQL query explaining its purpose.
  for example:
  select * from Products 
  where price>= 1000$
    Add CategoryID column to the Products table.
  alter table Products
  add constraint CategoryID 
    Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
  create table Categories ( CategoryID int PRIMARY KEY , CategoryName , varchar(50)UNIQUE)
    Explain the purpose of the IDENTITY column in SQL Server.
 identity  - bu sql serverda avtomatik ravishda qiymatni ozi oshirib boradi.
🟠 Medium-Level Tasks (10)

    Use bulk  insert into import data from a text file into the Products table.
 bulk insert Products
    from 'C:\Data\products.txt'
    Create a foreign key in the Products table that references the Categories table.
  ProductsID  is foreign  key
    Explain the differences between PRIMARY KEY and UNIQUE KEY.
    PRIMARY KEY = bu jadvaldrgi ustunlarni noyob tarzda saqlaydi , null qiymatga ruxsat bermaydi.
   UNIQUE KEY = bu ustun takrorlanmas qiymatlarni saqlaydi , bitta null qiymatga ruxsat beradi.
    Add a CHECK constraint to the Products table ensuring Price > 0.
  alter table products
  add constraint  CHK_Price_Positive
  check (Price > 0)
    Modify the Products table to add a column Stock (INT, NOT NULL).
  alter table products
  ADD Stock INT NOT NULL DEFAULT 0
    Use the ISNULL function to replace NULL values in Price column with a 0.
  update products 
  set  Price = 0
  where Price is null
    Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
  foreign key = malumotni yaxlitligini taminlaydi , Jadvalga faqat mavjud qiymatlar kiritilishiga kafolat beradi.

🔴 Hard-Level Tasks (10)

Murodjon Roʻzmatov, [19/06/2025 13:43]
Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.
  create table students (  CustomerID int primary key,  CustomerName VARCHAR(100), Age INT, CONSTRAINT CHK_Customer_Age CHECK (Age >= 18))
    Create a table with an IDENTITY column starting at 100 and incrementing by 10.
  CREATE TABLE workers (   ID INT IDENTITY(100, 10) PRIMARY KEY, Name VARCHAR(100))
    Write a query to create a composite PRIMARY KEY in a new table OrderDetails.
  CREATE TABLE OrderDetails (  OrderID INT, ProductID INT,Quantity INT,CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID))
    Explain the use of COALESCE and ISNULL functions for handling NULL values.
  ISNULL – oddiy almashtirish uchun yaxshi: NULL → qiymat.
  COALESCE – ko‘p ustunli qiymatlar ichidan birinchi mavjudini olish uchun ideal.
    Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
  CREATE TABLE Employees (EmpID INT PRIMARY KEY, FullName VARCHAR(100),Email VARCHAR(100) UNIQUE)
    Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.
  CREATE TABLE Orders ( OrderID INT PRIMARY KEY OrderDate DATE,CustomerID INT, 
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID)REFERENCES Customers(CustomerID) ON DELETE cascade on update cascade)  
