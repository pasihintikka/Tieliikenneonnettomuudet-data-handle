/*
-- CREATE A DATABASE
CREATE DATABASE Onnettomuudet
*/

--USE Onnettomuudet

-------------------------------
-- CREATE A TABLE ONNETTOMUUDET

/*
CREATE TABLE Onnettomuudet  
   (Onnett_id INT PRIMARY KEY NOT NULL,
   alue_id BIGINT,
   tieomin_id INT,
   Vuosi INT,
   Kk INT,
   Päivä VARCHAR(10),
   Kuolleet INT,
   Loukkaant INT,
   Vakavuusko INT,
   Vakavuus VARCHAR(50),
   Tunti INT,
   Vkpv VARCHAR(15),
   Ontyyppi INT,
   Ontyypsel VARCHAR(75),
   Onluokka INT,
   Onlksel VARCHAR(50),
   Osallkm INT,
   Nopraj INT,
   Pinta INT,
   Pintasel VARCHAR(25),
   Valoisuus INT,
   Valsel VARCHAR(25),
   Sää INT,
   Sääsel VARCHAR(25),
   Onnpaikka INT,
   Onnpaiksel VARCHAR(25),
   Lämpötila NUMERIC(4,1),
   Katuosoite VARCHAR(50),
   [position.lat] NUMERIC(18,9),
   [position.lon] NUMERIC(18,9),
   Alkoholi INT,
   Järjnro INT,
   Jutuntunn VARCHAR(10),
   Solmunro NUMERIC(10,1));
*/

---------------------------
-- CREATE A TABLE OSALLISET

/*
CREATE TABLE Osalliset
   (Onnett_id INT,
   Osall_id INT PRIMARY KEY NOT NULL,
   Osnro INT,
   Oslaji INT,
   Oslajisel VARCHAR(50),
   Peräv INT,
   Perävsel VARCHAR(50),
   Ajolaji INT,
   Ajolajisel VARCHAR(50),
   Kuollut INT,
   Loukk INT,
   Ajoneuvika INT,
   Ajoneuvmas INT,
   Kulkusuun INT,
   Kulkussel VARCHAR(50));
*/

------------------------
-- CREATE A TABLE ALUEET

/*
CREATE TABLE Alueet
   (alue_id BIGINT PRIMARY KEY NOT NULL,
   ELY INT,
   Elynimi VARCHAR(50),
   Poliisipri INT,
   Piirinimi VARCHAR(50),
   Maakunta INT,
   Maakuntsel VARCHAR(50),
   Kunta INT,
   Kuntasel VARCHAR(25));
*/

-------------------------
-- CREATE A TABLE TIEOMIN

/*
CREATE TABLE Tieomin
   (tieomin_id INT NOT NULL,
   Vuosi INT NOT NULL,
   Tienpit INT,
   Tienpitsel VARCHAR(25),
   Tie NUMERIC(10,1),
   Aosa NUMERIC(10,1),
   Aet NUMERIC(10,1),
   Ajr NUMERIC(10,1),
   Taajmerk INT,
   Taajamasel VARCHAR(10),
   Liikvalot INT,
   Liikvalsel VARCHAR(50),
   Liittyvtie NUMERIC(10,1),
   Noplaji INT,
   Noplajisel VARCHAR(50),
   Nopsuunvas INT,
   Nopsuunoik INT,
   Taajama VARCHAR(10),
   Mo_mol INT,
   Mo_molsel VARCHAR(50),
   Toimluokka INT,
   Toimlksel VARCHAR(50),
   Kvl NUMERIC(10,1),
   Raskaskvl NUMERIC(10,1),
   Tienlev NUMERIC(10,1),
   Oslakpvm VARCHAR(20),
   Tietyö VARCHAR(10),
   Päällyste INT,
   Päällsel VARCHAR(50),
   Risteys INT,
   Risteyssel VARCHAR(50),
   Rautatie INT,
   Rautatsel VARCHAR(50),
   Muuliit INT,
   Muuliitsel VARCHAR(50),
   Tietyyppi INT,
   Tietyypsel VARCHAR(50),
   Talvhoitlk INT,
   Talvhoitsel VARCHAR(50),
   Tienverkas INT,
   Tienverkse VARCHAR(50),
   Maankäyttö INT,
   Maankäytse VARCHAR(50),
   Valoohjaus INT,
   Valoohjsel VARCHAR(50),
   Lisäkaisty INT,
   Lisäkaisse VARCHAR(50),
   Solmutyyp INT,
   Solmutyyps VARCHAR(50),
   Liitluok INT,
   Liitlksel VARCHAR(50),
   Lähliittie NUMERIC(10,1),
   Suuntlkm NUMERIC(10,1),
   Toimenpide INT,
   Toimpidsel VARCHAR(50),
   Luovpvm VARCHAR(10),
   Valaisomis INT,
   Valomsel VARCHAR(50),
   Poikkileik INT,
   Poikleikse VARCHAR(50),
   Päällyslev NUMERIC(10,1),
   Päällystlk INT,
   Päällksel VARCHAR(50),
   Nakos150 NUMERIC(10,1),
   Nakos300 NUMERIC(10,1),
   Nakos460 NUMERIC(10,1),
   Runkotie NUMERIC(10,1),
   Raskos VARCHAR(10)
   CONSTRAINT PK_Tieomin PRIMARY KEY CLUSTERED (tieomin_id, Vuosi));
*/

------------------------
-- CREATE A TABLE VÄESTÖ

/*
CREATE TABLE Väestö
   (Maakunta INT,
   Maakuntsel VARCHAR(50),
   Vuosi INT,
   Väestö INT);
*/

-------------------------------------
-- CREATE FOREIGN KEYS BETWEEN TABLES

/*
ALTER TABLE dbo.Onnettomuudet
ADD
  CONSTRAINT FK_Alueet_Onnettomuudet FOREIGN KEY (alue_id) REFERENCES dbo.Alueet(alue_id),
  CONSTRAINT FK_Tieomin_Onnettomuudet FOREIGN KEY (tieomin_id, Vuosi) REFERENCES dbo.Tieomin(tieomin_id, Vuosi);
*/

/*
ALTER TABLE dbo.Osalliset
ADD
  CONSTRAINT FK_Onnettomuudet_Osalliset FOREIGN KEY (Onnett_id) REFERENCES dbo.Onnettomuudet (Onnett_id);
*/
