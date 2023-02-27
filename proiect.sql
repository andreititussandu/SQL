CREATE DATABASE banca;
USE banca;
CREATE TABLE adresa (
id_adresa INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
tara VARCHAR(45),
oras VARCHAR (45),
strada VARCHAR (45),
numar VARCHAR (45),
bloc VARCHAR (45)
);
CREATE TABLE angajati(
id_angajat INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
nume VARCHAR (45),
prenume VARCHAR(45),
data_nasterii DATE,
data_angajarii DATE,
CNP VARCHAR(45) UNIQUE,
salariu VARCHAR(45),
functie VARCHAR(45),
manager INT NOT NULL,
id_adresa INT
);

CREATE TABLE clienti (
id_client INT PRIMARY KEY,
nume VARCHAR(45),
prenume VARCHAR(45),
CNP_CUI VARCHAR(45) UNIQUE,
tip_client VARCHAR(45),
cod_client VARCHAR (45) UNIQUE,
reprezentant_bancar VARCHAR(45),
id_adresa INT,
id_angajat INT
);

CREATE TABLE conturi(
id_cont INT PRIMARY KEY,
numar_cont VARCHAR (45) UNIQUE,
valoare VARCHAR (45),
valuta VARCHAR (45),
id_client INT
);

CREATE TABLE operatiuni(
cod_operatiune INT PRIMARY KEY,
tip_operatiune VARCHAR (45),
denumire VARCHAR (45),
id_operatiune INT
);

CREATE TABLE tranzactii(
cont_sursa VARCHAR(45),
cont_destinatie VARCHAR(45),
id_operatiune INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
data_tranzactie DATE,
valoare VARCHAR(45),
detalii_tranzactie VARCHAR(45),
id_cont INT
);


ALTER TABLE clienti ADD CONSTRAINT check_tipclient
CHECK (tip_client LIKE '%Persoana %Fizica' OR tip_client LIKE '%Persoana %Juridica');

ALTER TABLE conturi ADD CONSTRAINT check_valuta
CHECK (valuta LIKE '%EUR%' OR valuta LIKE '%RON%' OR valuta LIKE '%USD%' or valuta LIKE '%-%');


ALTER TABLE operatiuni ADD CONSTRAINT check_tipoperatiune
CHECK (tip_operatiune LIKE '%DEPUNERE%' OR tip_operatiune LIKE '%EXTRAGERE%' OR tip_operatiune LIKE '%INFORMARE%' OR tip_operatiune LIKE '%ERROR%');


ALTER TABLE angajati ADD CONSTRAINT fk_manager FOREIGN KEY (manager) REFERENCES angajati(id_angajat);
ALTER TABLE angajati ADD CONSTRAINT fk_adresa2 FOREIGN KEY (id_adresa) REFERENCES adresa(id_adresa);
ALTER TABLE clienti ADD CONSTRAINT fk_adresa FOREIGN KEY (id_adresa) REFERENCES adresa (id_adresa);
ALTER TABLE clienti ADD CONSTRAINT fk_angajat FOREIGN KEY (id_angajat) REFERENCES angajati(id_angajat);
ALTER TABLE conturi ADD CONSTRAINT fk_clienti FOREIGN KEY (id_client) REFERENCES clienti (id_client);
ALTER TABLE tranzactii ADD CONSTRAINT fk_sursa FOREIGN KEY (id_cont) REFERENCES conturi (id_cont);
ALTER TABLE tranzactii ADD CONSTRAINT fk_destinatie FOREIGN KEY (id_cont) REFERENCES conturi (id_cont);
ALTER TABLE tranzactii ADD CONSTRAINT fk_operatiune FOREIGN KEY (id_operatiune) REFERENCES operatiuni (cod_operatiune);


ALTER TABLE clienti CHANGE tip_client tip_client VARCHAR(45) DEFAULT 'PERSOANA FIZICA';
ALTER TABLE clienti DROP FOREIGN KEY fk_adresa;
ALTER TABLE clienti  DROP id_adresa;
ALTER TABLE clienti ADD  id_adresa INT;
ALTER TABLE clienti ADD CONSTRAINT fk_adresa FOREIGN KEY (id_adresa) REFERENCES adresa (id_adresa);

USE banca;

INSERT INTO operatiuni (cod_operatiune, tip_operatiune, denumire) VALUES 
(100, 'INFORMARE', 'Deschidere cont'),
(101, 'INFORMARE', 'Adaugare cont'),
(102, 'INFORMARE', 'Inchidere cont'),
(200, 'INFORMARE', 'Transfer intre conturi'),
(201, 'INFORMARE', 'Balanta cont'),
(202, 'INFORMARE', 'Istoric tranzactii'),
(300, 'DEPUNERE', 'Depunere ghiseu'),
(301, 'DEPUNERE', 'Depunere ATM'),
(400, 'EXTRAGERE', 'Extragere ghiseu'),
(401, 'EXTRAGERE', 'Extragere ATM'),
(500, 'ERROR', 'Fonduri insuficiente');

INSERT INTO adresa (id_adresa,tara,oras,strada,numar,bloc) VALUES
(01, 'Romania', 'Bucuresti','Str. Constantin Disescu',18,3),
(02, 'Romania', 'Cluj','Str. Al.Ioan Cuza',20,10),
(03, 'Romania', 'Sibiu', 'Str. Frumoasa',15,7),
(04, 'Romania', 'Brasov','Str. Ion Creanga',16,3 ),
(05, 'Romania', 'Targoviste','Str. Mihai Eminescu',18,5),
(06, 'Romania', 'Bucuresti', 'Str. Iuliu Maniu',23,6),
(07, 'Romania', 'Bucuresti', 'Str. Iacob Negruzi',24,9),
(08, 'Romania', 'Bucuresti','Str. Ion Bianu',7,16),
(09, 'Romania', 'Iasi', 'Str. Stejar',18,4),
(010, 'Romania', 'Piatra-Neamt','Str. Alun',21,12),
(011, 'Romania', 'Craviova', 'Str. Ion Mincu',13,19);

INSERT INTO angajati (id_angajat,nume,prenume,data_nasterii,data_angajarii,CNP,salariu,functie,manager,id_adresa) VALUES
(001,'Ion','Maria','1972-09-08', '2000-11-05',2720908562347,4500,'Manager',001,01),
(002,'Popescu','Victor','1976-03-20', '2003-04-25',1760320896314,1700,'Ofiter Bancar',001,02),
(003,'Gheorghe','Alin','1980-07-20', '2006-08-09',180072056234,1700,'Ofiter Bancar',001,03),
(004,'Dumitru','Dan','1983-12-23', '2009-12-07',183122356234,1700,'Ofiter Bancar',001,04),
(005,'Ionescu','Paul','1989-09-20', '2008-08-10',189092056234,1700,'Ofiter Bancar',001,05),
(006,'Georgescu','Alexandru','1991-02-21', '2010-02-03',191022156234,1700,'Ofiter Bancar',001,06),
(007,'Teodorescu','Alina','1980-05-20', '2008-06-30',2800520623456,3500,'Manager',001,07),
(008,'Vicentiu','Paulina','1990-07-08', '2010-06-20',290070856234,1800,'Rprezentat Bancar',007,08),
(009,'Gogan','Elisabeta','1983-11-11', '2012-05-05',283111156234,1800,'Rprezentat Bancar',007,09),
(0010,'Panait','Victoria','1986-04-03', '2013-07-20',286040356234,1800,'Rprezentat Bancar',007,010),
(0011,'Alecsandrescu','Ioan','1992-02-08', '2015-03-10',192020856234,1800,'Rprezentat Bancar',007,011);


INSERT INTO clienti(id_client,nume,prenume,CNP_CUI,tip_client,cod_client,reprezentant_bancar,id_angajat,id_adresa) VALUES
(1,'Vania','Ion','1967842310231','Persoana Fizica','1234','Gogan Elisabeta', '009','09'),
(2,'Dragos','Maria','2965478312654','Persoana Fizica','2345','Panait Victoria','0010','010'),
(3,'Enescu','Vlad','1234567894203', 'Persoana Fizica','3456', 'Panait Victoria','0010','010'),
(4,'Pavelescu','Florin','12356','Persoana Juridica','4567', 'Alecsandrescu Ioan','0011','011'),
(5,'Popescu','Victor','78653','Persoana Juridica','7891','Vicentiu Paulina','008','08'),
(6,'Pana','Alexandra','86545','Persoana Juridica','1685','Vicentiu Paulina','008','08'),
(7,'Petrescu','Victoria','12315','Persoana Juridica','3264','Vicentiu Paulina','008','08'),
(8,'Sanda','Maria','78564','Persoana Juridica','74523','Vicentiu Paulina','008','08');



INSERT INTO conturi(id_cont,numar_cont,valoare,valuta,id_client) VALUES
(01,'RO02 INGB 0001 0082 1449 8950','2600','RON','1'),
(02,'RO57 BTRL RONC RT0V 0565 0501','3000','USD','2'),
(03,'RO28 BRDE 450S V210 0000 4500','8000', 'EUR','3'),
(04,'RO30 BRDE 450S V210 0000 4500','7500','RON','4'),
(05,'RO08 INGB 0001 0082 1450 8930','1800','RON','5');


INSERT INTO tranzactii(cont_sursa, cont_destinatie,id_operatiune,data_tranzactie,valoare,detalii_tranzactie,id_cont) VALUES
('RO02 INGB 0001 0082 1449 8950','RO09 INGB 0001 0082 1449 0730','200','2015-06-07','1500','Transfer intre conturi','01'),
('RO57 BTRL RONC RT0V 0565 0501','RO10 BTRL 0001 0082 1449 0730', '202', '2019-08-06','3000','Istoric Tranzactii',02),
('RO28 BRDE 450S V210 0000 4500', 'RO13 BRDE 0001 0082 1449 0730', '301','2018-06-08','5','Depunere Ghiseu',03),
('RO30 BRDE 450S V210 0000 4500', 'RO16 INGB 0001 0082 1449 0730', '500','2017-12-03','1200','Fonduri Insuficiente','04'),
('RO08 INGB 0001 0082 1450 8930','RO18 INGB 0001 0082 1450 8930','201','2019-05-23','600','Balanta','05');

-- Stergeti din tabela client, toti clientii care nu au conturi.

select *from clienti;
select* from conturi;

DELETE FROM clienti 
WHERE id_client>5;

/*Modificati in RON valoarea din tabelul cont, al persoanelor ce au valuta in EUR, tinand cont de rata de schimb 
1EUR=4.65RON. (aveti de modificat aici 2 coloane, valoare si valuta, in aceeasi instructiune UPDATE)*/

UPDATE conturi SET valoare=valoare*4.65,valuta='RON'
WHERE valuta='EUR';


-- Mariti cu 20% valoarea din tabela conturi a persoanelor juridice.

SELECT CL.nume,CL.prenume, C.valoare*1.2 FROM 
conturi C JOIN clienti CL 
ON C.id_client = CL.id_client
WHERE tip_client='Persoana Juridica';

-- Afisati Adresele din Bucuresti

SELECT * FROM adresa
WHERE oras ='Bucuresti';

-- Afisati conturile in RON a caror valoare este intre 1000 si 2000.

SELECT * FROM conturi
WHERE valuta ='RON' AND valoare BETWEEN 1000 AND 2000; 

-- Afisati conturile deschise in RON si EUR.

SELECT * FROM conturi
WHERE valuta ='RON' OR valuta='EUR';

-- Afisati angajatii al caror nume se termina in “escu”.

SELECT * FROM angajati 
WHERE right(nume,4)='escu';

-- Afisati angajatii cu id-urile 6,2,8,9,10.

SELECT * FROM angajati
WHERE id_angajat IN (6,2,8,9,10);

-- Afisati persoanele  fizice sub forma “nume prenume”, “CNP/CUI” , “ cod_client”.

SELECT concat(nume,' ',prenume) Client,CNP_CUI, cod_client FROM clienti
WHERE tip_client='Persoana Fizica';


-- Afisati valoarea medie rotunjita la 2 zecimale a conturilor deschise in EUR, a celor deschise in RON si a celor deschise in USD.

SELECT valuta, avg(valoare) FROM conturi 
WHERE valuta ='RON' OR valuta='EUR' OR valuta='USD'
GROUP BY valuta; -- trebuie folosit double ?

-- Afisati suma tranzactionata de fiecare client in parte in lunile de vara, unde clientul a fost destinatar.;

 SELECT sum(T.valoare) SumaTranzactionata, c.id_client
 FROM clienti C  JOIN conturi CO using(id_client)
JOIN tranzactii T ON T.cont_destinatie=CO.numar_cont
 WHERE MONTH(t.data_tranzactie) in (6, 7, 8)
 GROUP BY c.id_client;

 /*Afisati suma tranzactionata de fiecare client in parte, pentru tranzactiile cu id-ul 200,202,203, 
 acolo unde clientul a fost sursa.(cont.id_client=tranzactii.cont_sursa) 
Se sa afiseze: "nume prenume" clientului, suma iesita din cont sub forma "<valoarea tranzactionata> RON" 
 (aici trebuie sa faceti concat(valoarea,'RON') ).*/
 
 SELECT sum(T.valoare) SumaTranzactionata, T.id_operatiune,concat_ws(' ',nume,prenume,T.valoare,valuta) ValoareTranzactionata
 FROM clienti JOIN conturi CO using(id_client)
 JOIN tranzactii T ON T.cont_sursa=CO.numar_cont
 WHERE valuta='RON' AND T.id_operatiune IN (200,202,203)
 GROUP BY id_client;
 
--  Afisati valoarea tranzactonata in luna curenta. Observatie: Atentie, aici trebuie afisati din  tranzactii.

SELECT sum(valoare) FROM tranzactii
WHERE MONTH(data_tranzactie)= month(current_date());

-- Afisati numarul conturilor  deschise in euro.

SELECT count(valuta) FROM conturi
WHERE valuta='EUR';


-- Afisati clientii cu conturi deschise. Afisare: "nume prenume", CNP/CUI, tip_client, numar_cont, valoare, valuta;

SELECT concat(C.nume, ' ', C.prenume) Client,C.CNP_CUI,C.tip_client,CO.numar_cont,CO.valoare,CO.valuta
FROM clienti C JOIN conturi CO 
ON C.id_client=CO.id_client;

/*Afisati clientii cu conturi deschise in RON si sediul lor. Afisare: "nume prenume", 
"tara, oras, strada, numar, bloc/cladire" ca adresa, tip_client, numar_cont, valoare, valuta;*/

SELECT 
concat(C.nume, ' ', C.prenume) Client,concat(A.tara,' ',A.oras,' ',A.strada,' ',A.numar,' ',A.bloc) Adresa,C.tip_client,
CO.numar_cont,CO.valoare,CO.valuta
FROM clienti C JOIN conturi CO using(id_client)
JOIN adresa A using(id_adresa)
WHERE valuta='RON';

/*Afisati tranzactiile in ultimele 3 luni, ca: "tip_operatiune denumire"
 ca operatiune, data_tranzactie, valoare, detalii_tranzactie;*/
 
 SELECT T.data_tranzactie,T.valoare,T.detalii_tranzactie,concat(O.tip_operatiune,' ',O.denumire) Operatiune
 FROM tranzactii T JOIN operatiuni O
 ON T.id_operatiune=O.cod_operatiune;
 -- WHERE MONTH(data_tranzactie)=MONTH(data_tranzactie)-3; 


/*Afisati numele clientilor, numele reprezentantiilor bancari si operatiunuile facute.
Afisati: "nume prenume" nume_client, "nume prenume" reprezentant_bancar, "tip_operatiune denumire" operatiune, detalii_tranzactie*/

SELECT DISTINCT concat(C.nume,' ', C.prenume) nume_client,concat(A.nume,' ',A.prenume)reprezentant_bancar,
concat(O.tip_operatiune,' ',O.denumire) operatiune,T.detalii_tranzactie
FROM clienti C JOIN angajati A ON
C.id_angajat=A.id_angajat
JOIN tranzactii T JOIN operatiuni O ON
 T.id_operatiune=O.cod_operatiune;
 
 
 /*Afisati clientii, angajatii si adresa lor, folosind subinterogari(fara joinuri) sub forma:
"nume prenume" client, id_adresa, 'Client' Observatii,
"nume prenume" angajat, id_adresa, 'Angajat' Observatii,
HINT: Folositi UNION*/

SELECT concat(nume, ' ', prenume) Client, 
(SELECT concat_ws(' ', tara, oras, strada,numar,bloc) FROM adresa WHERE id_adresa=cln.id_adresa) AS Adresa ,'Client' Observatii
FROM clienti cln
UNION 
SELECT concat(nume,' ',prenume) Angajat,
(SELECT concat_ws(' ',nume,prenume,functie) FROM angajati WHERE id_adresa=ang.id_adresa) AS Angajat, 'Angajat' Observatii
FROM angajati ang;

/*Afisati, folosind subinterogari, angajatii care sunt manageri.
Afisare: nume, prenume, data_angajarii, CNP, salariu, functie/job*/

SELECT concat(nume,' ',prenume),
(SELECT concat_ws(' ',nume,prenume) FROM angajati WHERE functie='Manager') AS Manager FROM angajati;

/*Creati un view cu clientii, angajatii si adresa lor, sub forma:
"nume prenume" client, "tara, oras, strada, numar, bloc/cladire" adresa, 'Client' Observatii,
"nume prenume" angajat, "tara, oras, strada, numar, bloc/cladire" adresa, 'Angajat' Observatii,
HINT: Folositi UNION*/


CREATE VIEW pacpac AS
SELECT concat(nume, ' ', prenume) Client, 
(SELECT concat_ws(' ', tara, oras, strada,numar,bloc) FROM adresa WHERE id_adresa=cln.id_adresa) AS Adresa ,'Client' Observatii
FROM clienti cln
UNION 
SELECT concat(nume,' ',prenume) Angajat,
(SELECT concat_ws(' ',tara,oras,strada,numar,bloc) FROM adresa WHERE id_adresa=ang.id_adresa) AS Adresa, 'Angajat' Observatii
FROM angajati ang;

/*Creati un view cu angajatii care nu sunt manageri si de portofoliul a cator clienti se ocupa.
Afisare: nume, prenume, data_angajarii, CNP, salariu, functie/job, nr_clienti*/

CREATE VIEW pacpac1 AS
SELECT A.nume,A.prenume,A.data_angajarii,A.CNP,A.salariu,A.functie, count(A.id_angajat)
FROM angajati A JOIN clienti C ON A.id_angajat=C.id_angajat
WHERE functie!='Manager'
GROUP BY A.id_angajat;

/*Creati o tabela temporara cu angajatii care sunt manageri si cei care nu sunt manageri.
Afisare: "nume prenume" Angajat,"nume prenume" Manager, data_angajarii, CNP, salariu, functie/job*/

CREATE VIEW pacpac2 AS
SELECT distinct concat_ws(' ',A.nume,A.prenume,A.data_angajarii,A.CNP,A.salariu,A.functie)  ReprezentantBancar,
concat_ws(' ',Ang.nume,Ang.prenume,Ang.data_angajarii,Ang.CNP,Ang.salariu,Ang.functie) Manager
FROM angajati A, angajati Ang-- JOIN angajati Ang ON A.id_angajat=Ang.id_angajat
WHERE A.functie <> 'Manager' and a.manager = ang.id_angajat and Ang.functie='Manager';

/*Creati un view care sa contina un raport general cu tranzactiile efectuate in luna curenta, in functie de operatiunea efectuata.
Afisare: "tip_operatiune denumire" operatiune, valoare_totala, valoare_medie rotunjita la 2 zecimale .
 Sa se afiseze doar daca valoarea_totala depaseste valoarea_medie.*/

SELECT concat(O.tip_operatiune,' ', O. denumire) Operatiune, T.valoare, avg(T.valoare)
FROM tranzactii T JOIN operatiuni O ON T.id_operatiune=O.cod_operatiune 
HAVING T.valoare > avg(T.valoare) AND MONTH(current_date)=MONTH(T.data_tranzactie);

-- Creati un index compus pe tabela clienti, pe coloanele id_client, cod_client;
CREATE INDEX clienti ON clienti(id_client,cod_client);

-- Creati un index simplu pe tabela cont, coloana numar_cont;
CREATE UNIQUE INDEX conturi ON conturi(numar_cont);

-- Creati un index unic pe tabela angajati, coloana id_adresa. Ce observati?

CREATE UNIQUE INDEX angajati ON angajati(id_adresa); -- am creat un index pe o cheie primara... si cheia primara deja are index?

-- Stergeti indecsii creati.

DROP INDEX clienti ON clienti;
DROP INDEX conturi ON conturi;
DROP INDEX angajati ON angajati;


