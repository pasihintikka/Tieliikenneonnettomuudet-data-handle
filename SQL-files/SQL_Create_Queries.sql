--USE Onnettomuudet


----------------------
-- ALTER COLUMN LENGTH

--ALTER TABLE dbo.Onnettomuudet ALTER COLUMN Vkpv VARCHAR(15);


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

--DELETE FROM Väestö;


--------------------------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES, INVOLVED, CONDITIONS AND LOCATION
-- WITHOUT MILD INCIDENT

/*
SELECT
    o.Vuosi,
	Kk AS Kuukausi,
	Vkpv AS Viikonpäivä,
	Tunti,
	Vakavuus,
	os.Kuollut AS Kuolleita,
	os.Loukk AS Loukkaantuneita,
	os.Oslajisel AS Osallisen_laji,
	Onlksel AS Onnett_Luokka,
	Ontyypsel AS Onnett_Tyyppi,
	Onnpaiksel AS Onnett_Paikka,
	Nopraj AS Nopeusrajoitus,
	t.Noplajisel AS NopRaj_Laji,
	t.Risteys AS Risteävien_lkm,
	t.Risteyssel AS Risteys_Laji,
	Pintasel AS Tienpinta,
	Valsel AS Valoisuus,
	Sääsel AS Sää,
	Lämpötila,
	a.Maakuntsel AS Maakunta,
	a.Kuntasel AS Kunta,
	Katuosoite,
	[position.lat],
	[position.lon]
FROM
    Onnettomuudet o
INNER JOIN Alueet a 
    ON o.alue_id = a.alue_id
INNER JOIN Tieomin t
    ON o.tieomin_id = t.tieomin_id AND
	o.Vuosi = t.Vuosi
INNER JOIN Osalliset os
    ON o.Onnett_id = os.Onnett_id
WHERE
    Vakavuusko > 0
GROUP BY 
    o.Vuosi,
	Kk,
	Vkpv,
	Tunti,
	Vakavuus,
	os.Kuollut,
	os.Loukk,
	os.Oslajisel,
	Onlksel,
	Ontyypsel,
	Onnpaiksel,
	Nopraj,
	t.Noplajisel,
	t.Risteys,
	t.Risteyssel,
	Pintasel,
	Valsel,
	Sääsel,
	Lämpötila,
	a.Maakuntsel,
	a.Kuntasel,
	Katuosoite,
	[position.lat],
	[position.lon];
*/

--------------------------------------------
-- NUMERIC DATA FOR HEATMAP WITHOUT LOCATION

/*
SELECT
    o.Vuosi,
	Kk AS Kuukausi,
	Vkpv AS Viikonpäivä,
	Tunti,
	Vakavuusko AS Vakavuus,
	os.Kuollut AS Kuolleita,
	os.Loukk AS Loukkaantuneita,
	os.Oslaji AS Osallisen_laji,
	Onluokka AS Onnett_Luokka,
	Ontyyppi AS Onnett_Tyyppi,
	Onnpaikka AS Onnett_Paikka,
	Nopraj AS Nopeusrajoitus,
	t.Noplaji AS NopRaj_Laji,
	t.Risteys AS Risteävien_lkm,
	t.Talvhoitlk AS Talvihoitoluokka,
	Pinta AS Tienpinta,
	Valoisuus,
	Sää,
	Lämpötila,
	a.Maakunta,
	a.Kunta,
	v.Väestö
FROM
    Onnettomuudet o
INNER JOIN Alueet a 
    ON o.alue_id = a.alue_id
INNER JOIN Tieomin t
    ON o.tieomin_id = t.tieomin_id AND
	o.Vuosi = t.Vuosi
INNER JOIN Osalliset os
    ON o.Onnett_id = os.Onnett_id
INNER JOIN Väestö v
    ON o.Vuosi = v.Vuosi
WHERE
    a.Maakunta = v.Maakunta
GROUP BY 
    o.Vuosi,
	Kk,
	Vkpv,
	Tunti,
	Vakavuusko,
	os.Kuollut,
	os.Loukk,
	os.Oslaji,
	Onluokka,
	Ontyyppi,
	Onnpaikka,
	Nopraj,
	t.Noplaji,
	t.Risteys,
	t.Talvhoitlk,
	Pinta,
	Valoisuus,
	Sää,
	Lämpötila,
	a.Maakunta,
	a.Kunta,
	v.Väestö;
*/
