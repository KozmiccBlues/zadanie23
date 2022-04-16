-- 1. Tworzy tabelę pracownik(imie, nazwisko, wyplata, data urodzenia, stanowisko). W tabeli mogą być dodatkowe kolumny, które uznasz za niezbędne.

create table employees(
                          id bigint primary key auto_increment,
                          first_name varchar(30) NOT NULL,
                          last_name varchar(50) NOT NULL,
                          salary decimal(10, 2),
                          birth_date date,
                          position varchar(20) NOT NULL
);

-- 2. Wstawia do tabeli co najmniej 6 pracowników
INSERT INTO employees (first_name, last_name , salary, birth_date, position)
VALUES('Anna', 'Nowak', 6500.00 , '1990-01-02', 'accountant'),
      ('Michał', 'Grabarczyk', 25000.00 , '1985-10-18', 'sales manager'),
      ('Agnieszka', 'Lewandowska', 5000.00 , '1996-12-12', 'junior accountant'),
      ('Grzegorz', 'Pietruszka', 7000.00 , '1989-10-20', 'logistics specialist'),
      ('Karolina', 'Pionek', 6000.00 , '1987-03-15', 'recruiter'),
      ('Zenon', 'Lipa', 10000.00 , '1984-04-12', 'sales coordinator');

-- 3. Pobiera wszystkich pracowników i wyświetla ich w kolejności alfabetycznej po nazwisku

select * from employees order by last_name asc;

-- 4.Pobiera pracowników na wybranym stanowisku
select * from employees where position = 'accountant';

-- 5.Pobiera pracowników, którzy mają co najmniej 30 lat

ALTER TABLE employees
    ADD age INT;

update employees set age = timestampdiff(year, birth_date, curdate());

select * from employees where age > 30;

-- 6.Zwiększa wypłatę pracowników na wybranym stanowisku o 10%

update employees set salary = salary + (salary * 10/100)
where position = 'sales manager';


-- 7. Pobiera najmłodszego pracowników (uwzględnij przypadek, że może być kilku urodzonych tego samego dnia)

select first_name, last_name, age, birth_date
from employees
where birth_date = (select max(birth_date) from employees);

-- 8.Usuwa tabelę pracownik

drop table employees;

-- 9.Tworzy tabelę stanowisko (nazwa stanowiska, opis, wypłata na danym stanowisku)
-- 10.Tworzy tabelę adres (ulica+numer domu/mieszkania, kod pocztowy, miejscowość)
-- 11.Tworzy tabelę pracownik (imię, nazwisko) + relacje do tabeli stanowisko i adres
-- 12. Dodaje dane testowe (w taki sposób, aby powstały pomiędzy nimi sensowne powiązania)

create table position (
                          id INT primary key auto_increment,
                          title varchar(30) NOT NULL,
                          job_description varchar(100) NOT NULL,
                          salary decimal(10, 2)
);

create table address (
                         id INT primary key auto_increment,
                         street_no varchar(50) NOT NULL,
                         postalcode varchar(6) NOT NULL,
                         city varchar(30) NOT NULL
);

create table employee (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          first_name varchar(30) not null,
                          last_name varchar(30) not null
);

INSERT INTO employee
(first_name, last_name)
VALUES('Sara', 'Kosmalska'),
      ('Krzysztof', 'Kowalski'),
      ('Marta', 'Szczotka'),
      ('Ernest', 'Pióro')
    ('Sabina', 'Kot')
('Emilia', 'Sroka');

INSERT INTO address (
    street_no, postalcode, city)
VALUES('Świętojańska 12', '81-300', 'Gdynia'),
      ('Św. Piotra 8A','80-280', 'Gdańsk'),
      ('Meksykańska 66', '45-003', 'Opole'),
      ('Marynarska 18B', '76-215', 'Słupsk');
('Starowiejska 15C', '81-380', 'Gdynia')
('C.K. Norwida 1', '80-280', 'Gdańsk');

INSERT INTO position (
    title, job_description, salary)
VALUES('manager', 'zarządzanie całym działem', 10000.00),
      ('koordynator', 'opiekun 3-osobowego zespołu', 8000.00),
      ('księgowy/wa', 'rozliczanie faktur', 7000.00),
      ('rekruter/ka', 'przeprowadzanie rekrutacji', 6000.00),
      ('handlowiec', 'sprzedaż produktów', 7000.00);


create table employee_details(
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 employee_id INT UNIQUE NOT NULL,
                                 street_no varchar(50) NOT NULL,
                                 postalcode varchar(6) NOT NULL,
                                 city varchar(30) NOT NULL,
                                 FOREIGN KEY(employee_id) REFERENCES employee(id)
);

insert into employee_details
(employee_id,street_no, postalcode, city)
values
    (1, 'Świętojańska 12', '81-300', 'Gdynia'),
    (2,'Św. Piotra 8A','80-280', 'Gdańsk'),
    (3,'Meksykańska 66', '45-003', 'Opole'),
    (4,'Marynarska 18B', '76-215', 'Słupsk'),
    (5,'Starowiejska 15C', '81-380', 'Gdynia'),
    (6,'C.K. Norwida 1', '80-280', 'Gdańsk');

create table employee_job_details(
                                     id INT PRIMARY KEY AUTO_INCREMENT,
                                     employee_id INT  NOT NULL,
                                     position_id INT NOT NULL,
                                     title varchar(30) NOT NULL,
                                     job_description varchar(100) NOT NULL,
                                     salary decimal(10, 2),
                                     FOREIGN KEY(employee_id) REFERENCES employee(id),
                                     FOREIGN KEY(position_id) REFERENCES employee_job_details(id)
);

insert into employee_job_details(
    employee_id, position_id, title, job_description, salary)
VALUES(1,1,'manager', 'zarządzanie całym działem', 10000.00),
      (2,2,'koordynator', 'opiekun 3-osobowego zespołu', 8000.00),
      (3,3, 'księgowy/wa', 'rozliczanie faktur', 7000.00),
      (4,4,'rekruter/ka', 'przeprowadzanie rekrutacji', 6000.00),
      (5,5,'handlowiec', 'sprzedaż produktów', 7000.00),
      (6,5,'handlowiec', 'sprzedaż produktów', 7000.00);






