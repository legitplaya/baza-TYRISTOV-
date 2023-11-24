--creatin
CREATE TABLE Туристы(Код_Туриста INT PRIMARY KEY NOT NULL,
Фамилия NVARCHAR(30), Имя NVARCHAR(30), Отчество NVARCHAR (30))

CREATE TABLE Информация_о_туристах(Код_Туриста INT FOREIGN KEY 
REFERENCES Туристы(Код_туриста), Серия_паспорта NVARCHAR(15), Город 
NVARCHAR(30), Страна NVARCHAR(20), Телефон NVARCHAR(15), Индекс 
NVARCHAR(15))

CREATE TABLE Туры (Код_тура INT PRIMARY KEY NOT NULL, Название 
NVARCHAR (40), Цена MONEY, Информация NVARCHAR(100))

CREATE TABLE Сезоны (Код_сезона INT PRIMARY KEY NOT NULL, 
Код_тура INT FOREIGN KEY REFERENCES Туры (Код_тура), Дата_начала 
DATETIME, Дата_конца DATETIME, Сезон_закрыт BIT, Кол_во_мест INT)
 
CREATE TABLE Путевки (Код_путевки INT PRIMARY KEY NOT NULL, 
Код_тура INT FOREIGN KEY REFERENCES Туристы (Код_туриста), 
Код_сезона INT FOREIGN KEY REFERENCES Сезоны (Код_сезона))

CREATE TABLE Оплата (Код_оплаты INT PRIMARY KEY NOT NULL, 
Код_путевки INT FOREIGN KEY REFERENCES Путевки(Код_путевки), 
Дата_оплаты DATETIME, Сумма MONEY)


--вставка туристов)
INSERT INTO Туристы (Код_Туриста, Фамилия, Имя, Отчество)
VALUES
(1, N'Софронов', N'Евгений', N'Владимирович'),
(2, N'Брагин', N'Валерий', N'Яблокович'),
(3, N'Никитин', N'Константин', N'Евгеньевич'),
(4, N'Александров', N'Данил', N'Александрович'),
(5, N'Афанасьева', N'Софья', N'Викторовна');


INSERT INTO Информация_о_туристах (Код_Туриста, Серия_паспорта, Город, Страна, Телефон, Индекс)
VALUES
(1, N'123456789', N'Чебоксары', N'Россия', N'123-456-7890', N'123456'),
(2, N'987654321', N'Санкт-Петербург', N'Россия', N'987-654-3210', N'654321'),
(3, N'555234244', N'Нижний-Новгород', N'Россия', N'123-555-7635', N'123125'),
(4, N'111113443', N'Казань', N'Россия', N'123-123-6789', N'157971'),
(5, N'990010011', N'Казань', N'Россия', N'789-933-1234', N'232399');

INSERT INTO Туры (Код_тура, Название, Цена, Информация)
VALUES
(1, N'Отдых в санатории', 1500.00, N'7-дневная поездка по Чувашии'),
(2, N'Развлечения в Германии', 2000.00, N'10-дневная экскурсия по Германии'),
(3, N'Горнолыжный курорт', 1800.00, N'7-дневный отдых в Шале'),
(4, N'Путешествие на Гималаи', 1200.00, N'12-дневный поход в горы'),
(5, N'Отдых в столице Татарстана', 1700.00, N'3-дневный поездка в Казань');

INSERT INTO Сезоны (Код_сезона, Код_тура, Дата_начала, Дата_конца, Сезон_закрыт, Кол_во_мест)
VALUES
(1, 1, '2023-05-11', '2023-05-11', 0, 20),
(2, 2, '2023-06-12', '2023-06-12', 0, 15),
(3, 3, '2023-12-13', '2023-12-13', 1, 10),
(4, 4, '2023-08-14', '2023-08-14', 0, 12),
(5, 5, '2023-04-15', '2023-04-15', 0, 18);

INSERT INTO Путевки (Код_путевки, Код_тура, Код_сезона)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 4),
(5, 5, 5);

INSERT INTO Оплата (Код_оплаты, Код_путевки, Дата_оплаты, Сумма)
VALUES
(1, 1, '2023-04-11', 1200.00),
(2, 2, '2023-05-12', 1800.00),
(3, 3, '2023-11-13', 1600.00),
(4, 4, '2023-08-14', 800.00),
(5, 5, '2023-04-15', 1500.00);


--1 zadanie proceduriiii

--1.1
create proc proc_p1
@Фамилия nvarchar(50)
as
select *
from Туристы
where Фамилия=@Фамилия

exec proc_p1 "Афанасьева"

--1.2
create proc proc_p2
@nameTour nvarchar(50)
as
select *
from Туры
where Название=@nameTour

exec proc_p2 "Отдых в столице Татарстана"

--1.3
create proc proc_p3
@Фамилия nvarchar(50)
as
select *
from Туристы inner join [Информация_о_туристах] on Туристы.[Код_Туриста]=[Информация_о_туристах].[Код_Туриста] where Туристы.[Фамилия]=@Фамилия

exec proc_p3 "Афанасьева"

--1.4
create proc proc_p4
@nameTour nvarchar(50)
as
select *
from Туры inner join Сезоны
on Туры.[Код_тура]=Сезоны.[Код_тура]
where Туры.Название=@nameTour

exec proc_p4 "Отдых в столице Татарстана"

--1.5
create proc proc_p5
@nameTour nvarchar(50),
@Курс float
as update Туры set
Цена=Цена/(@Курс)
where Название=@nameTour

exec proc_p5 "Отдых в столице Татарстана", 22
select *from Туры

--1.6
create proc proc_p6
@nameTour nvarchar(50),
@Курс float = 26
as update Туры set
Цена=Цена/(@Курс)
where Название=@nameTour

exec proc_p6 "Отдых в столице Татарстана", 21


--2 zadanie procedura sql xml nwl c#l l3l

--2.1
create proc proc_po1
@TouristID int,
@LastName nvarchar(60) output
as
select @LastName = Фамилия
from Туристы
where [Код_Туриста] = @TouristID

declare @LastName nvarchar(60)
exec proc_po1 "5",
@LastName output 
select @LastName as "Фамилия туриста"

--2.2
create proc proc_po2
@CountCity int output as select
@CountCity = count([Код_Туриста])
from [Информация_о_туристах]
where Город like N'%аз%'

declare @CountCity 
int exec proc_po2 @CountCity
output select @CountCity
as 'Количество туристов, прожвивающих в городах %аз%'

--2.3
create proc proc_po3
@TouristID int,
@CountTour int output
as select
@CountTour = COUNT(Туры.[Код_тура])
from Путевки 
inner join Сезоны on Путевки.[Код_сезона] = Сезоны.[Код_сезона]
inner join Туры on Туры.[Код_тура] = Сезоны.[Код_тура]
inner join Туристы on Путевки.[Код_тура] = Туристы.[Код_Туриста]
where Туристы.[Код_Туриста] = @TouristID

declare @CountTour int
exec proc_po3 '5', @CountTour output
select @CountTour
as 'Количество туров, которые турист посетил'

--2.4
create proc proc_po4
@TouristID int,
@BeginDate smalldatetime,
@EndDate smalldatetime,
@SumMoney money output
as select @SumMoney = sum(Сумма)
from Оплата inner join Путевки on 
Оплата.[Код_путевки] = 
Путевки.[Код_путевки]
inner join Туристы on
Путевки.[Код_тура] = 
Туристы.[Код_Туриста]
where [Дата_оплаты]
between(@BeginDate)
and (@EndDate)
and Туристы.[Код_Туриста] = @TouristID

declare 
@TouristID int,
@BeginDate smalldatetime,
@EndDate smalldatetime,
@SumMoney money 
exec proc_po4 '5',
'1/20/2005',
'1/20/2024',
@SumMoney output

select @SumMoney
as 'Общая сумма за период'

--2.5
create proc proc_po5
@CodeTour int,
@ChisloPutevok int output as 
select @ChisloPutevok = 
COUNT(Путевки.[Код_сезона])
from Путевки inner join Сезоны on
Путевки.[Код_сезона] = Сезоны.[Код_сезона]
inner join Туры on Туры.[Код_тура] = Сезоны.[Код_тура]
where Сезоны.[Код_тура] = @CodeTour

declare @ChisloPutevok
int exec proc_po5 '5',
@ChisloPutevok output

select @ChisloPutevok
as 'Число путевок, проданных в этом туре'
--КОНЕЦ!!!