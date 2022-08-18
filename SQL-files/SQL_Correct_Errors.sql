--USE Onnettomuudet


----------------------
-- CHANGE COLUMN LENGTH

--ALTER TABLE dbo.Onnettomuudet ALTER COLUMN Vkpv VARCHAR(15);

-- ADD NEW COLUMN TO TABLE

--ALTER TABLE dbo.Alueet ADD Maak_Loc VARCHAR(5);

------------------------
-- DROP TABLES IF NEEDED

--DROP TABLE dbo.Onnettomuudet;  
--GO

--DROP TABLE dbo.Alueet;  
--GO

--DROP TABLE dbo.Tieomin;  
--GO

--DROP TABLE dbo.Osalliset;  
--GO

--DROP TABLE dbo.Väestö;  
--GO


-----------------------------
-- DELETE ALL DATA FROM TABLE

--DELETE FROM Osalliset;

-- DELETE DATA FROM TABLE BASED ON A CRITERIA

--DELETE FROM Onnettomuudet WHERE  Vuosi < 2009;


-- SELECT DATA WITH CRITERIA

--SELECT Onnett_id, Vuosi, [position.lat], [position.lon], Katuosoite FROM Onnettomuudet WHERE [position.lon] > 40 ORDER BY Vuosi;

----------------------------------------------------------
-- SELECT AND UPDATE NEGATIVE VALUES (NOT ALLOWED COLUMNS)

/*
SELECT Onnett_id, Lämpötila
FROM Onnettomuudet
WHERE Lämpötila IS NULL
GROUP BY Onnett_id, Lämpötila;
*/

--UPDATE Onnettomuudet SET Nopraj = NULL WHERE Nopraj <= 0;

--UPDATE Onnettomuudet SET Katuosoite = NULL WHERE Onnett_id = 6684845;

--UPDATE Onnettomuudet SET Pinta = NULL WHERE Pinta <= 0;

--UPDATE Onnettomuudet SET Sää = NULL WHERE Sää <= 0;

--UPDATE Onnettomuudet SET Valoisuus = NULL WHERE Valoisuus <= 0;

--UPDATE Onnettomuudet SET Tunti = NULL WHERE Tunti < 0;

--UPDATE Osalliset SET Peräv = NULL WHERE Peräv < 0;

--UPDATE Osalliset SET Ajolaji = NULL WHERE Ajolaji < 0;

--UPDATE Osalliset SET Kuollut = 0 WHERE Kuollut IS NULL;

--UPDATE Osalliset SET Loukk = 0 WHERE Loukk IS NULL;

--UPDATE Osalliset SET Ajoneuvika = 0 WHERE Ajoneuvika IS NULL;

/*
SELECT Osall_id, Kuollut, Loukk, Ajoneuvika
FROM Osalliset
WHERE Kuollut IS NULL
GROUP BY Osall_id, Kuollut, Loukk, Ajoneuvika;
*/


------------------------------------------------------------------------
-- CREATE A TABLE TEMP_ONN_COORD FOR UPDATING SOME CORRECTED COORDINATES

/*
CREATE TABLE Temp_Onn_Coord  
   (Onnett_id INT PRIMARY KEY NOT NULL,
   [position.lat] NUMERIC(18,9),
   [position.lon] NUMERIC(18,9));
*/

/*
INSERT INTO Temp_Onn_Coord(Onnett_id, [position.lat], [position.lon]) 
VALUES 
(6431907,65.204661052,25.546662867),
(6502988,65.054843071,25.48537159),
(6580257,65.053328842,25.494511352),
(6652181,65.090591402,25.63593325),
(6709860,60.776581246,25.460115123),
(6514438,64.600200858,26.572252499),
(6537791,64.996936542,25.512934817),
(6555192,NULL,NULL),
(6567107,64.677294663,26.512409028),
(6597827,64.768124384,28.160966245),
(6630943,65.090109766,25.512735902),
(6639532,NULL,NULL),
(6647156,60.685535201,25.348681529),
(6678938,65.341294459,26.927224521),
(6704622,64.934685834,28.815400613),
(6748903,64.726034312,29.682790386),
(6748951,NULL,NULL),
(6776215,NULL,NULL),
(6823553,60.780978096,25.436523769),
(6823781,64.841502922,25.351356139),
(6823811,60.582736107,25.205084422),
(6908229,60.624650687,25.206538919),
(6434291,65.456443756,29.045915739),
(6501694,NULL,NULL),
(6558115,62.161695198,27.262171997),
(6580732,65.208837353,25.427509309),
(6580930,63.097131177,21.68349002),
(6582838,63.992741881,24.839801362),
(6589380,65.875343341,29.248476769),
(6626556,NULL,NULL),
(6627149,65.070463949,25.797367953),
(6661343,65.146444856,28.929984526),
(6680574,65.171715959,25.669612314),
(6684845,65.649778337,25.361707012),
(6714540,60.735368527,25.421172207),
(6743878,65.376225273,25.762530384),
(6773262,65.045248302,26.935084896),
(6787382,64.157716076,28.044708531),
(6846592,61.55727915,25.827222594),
(6888638,65.232309131,25.482837766);
*/

--SELECT * FROM Temp_Onn_Coord;

/*
UPDATE Onnettomuudet
SET 
Onnettomuudet.[position.lat]=Temp_Onn_Coord.[position.lat], 
Onnettomuudet.[position.lon]=Temp_Onn_Coord.[position.lon]
FROM Onnettomuudet
INNER JOIN Temp_Onn_Coord
ON Onnettomuudet.Onnett_id = Temp_Onn_Coord.Onnett_id
*/

--DELETE FROM Temp_Onn_Coord

--DROP TABLE dbo.Temp_Onn_Coord;  
--GO

---------------------------------------------------------------------------
-- CREATE A TABLE TEMP_ALUEET FOR UPDATING ISO-3166-2 LOCATIONS FOR REGIONS

/*
CREATE TABLE Temp_Alueet  
   (Maakunta INT PRIMARY KEY NOT NULL,
   Maakuntsel VARCHAR(50),
   ISO_3166_2 VARCHAR(5));
*/

/*
INSERT INTO Temp_Alueet(Maakunta, Maakuntsel, Maak_Loc) 
VALUES 
(0,'Ei tiedossa',NULL),
(1,'Uusimaa','FI-18'),
(2,'Varsinais-Suomi','FI-19'),
(4,'Satakunta','FI-17'),
(5,'Kanta-Häme','FI-06'),
(6,'Pirkanmaa','FI-11'),
(7,'Päijät-Häme','FI-16'),
(8,'Kymenlaakso','FI-09'),
(9,'Etelä-Karjala','FI-02'),
(10,'Etelä-Savo','FI-04'),
(11,'Pohjois-Savo','FI-15'),
(12,'Pohjois-Karjala','FI-13'),
(13,'Keski-Suomi','FI-08'),
(14,'Etelä-Pohjanmaa','FI-03'),
(15,'Pohjanmaa','FI-12'),
(16,'Keski-Pohjanmaa','FI-07'),
(17,'Pohjois-Pohjanmaa','FI-14'),
(18,'Kainuu','FI-05'),
(19,'Lappi','FI-10');
*/

/*
UPDATE Alueet
SET 
Alueet.Maak_Loc=Temp_Alueet.Maak_Loc
FROM Alueet
INNER JOIN Temp_Alueet
ON Alueet.Maakunta = Temp_Alueet.Maakunta
*/

--SELECT * FROM Temp_Alueet;

--SELECT * FROM Alueet;

--DELETE FROM Temp_Alueet

--DROP TABLE dbo.Temp_Alueet;  
--GO