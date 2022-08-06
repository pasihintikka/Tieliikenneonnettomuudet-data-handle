-- SQL SERVER PROCEDURES

--use Onnettomuudet

--------------------------------------------
-- BASE QUERY INCIDENT WITH INJURED INVOLVED
-- BY SELECTED YEAR

/*
CREATE OR ALTER PROCEDURE uspGetLoukk_Osall (@vuosi INT)
AS 
BEGIN
    SELECT
        Vuosi,
		o.Onnett_id AS Onnett_nro,
		Onlksel AS Onnett_luokka,
		Onnpaiksel AS Onnettomuuspaikka,
		Loukk AS Loukkantuneita,
		Oslajisel AS Osallisen_laji
    FROM 
        Onnettomuudet o
	INNER JOIN Osalliset os
        ON o.Onnett_id = os.Onnett_id
    WHERE
        Vuosi = @vuosi AND
		Loukkaant > 0
    ORDER BY 
        Vuosi,
		o.Onnett_id,
		Onlksel,
		Onnpaiksel,
		Loukk,
		Oslajisel;
END;
*/

-- CHECK PROCEDURE
/*
EXEC uspGetLoukk_Osall 2017
*/

-----------------------------------------
-- BASE QUERY INCIDENT WITH DEAD INVOLVED
-- BY SELECTED YEAR

/*
CREATE OR ALTER PROCEDURE uspGetKuoll_Osall (@vuosi INT)
AS 
BEGIN
    SELECT
        Vuosi,
		o.Onnett_id AS Onnett_nro,
		Onlksel AS Onnett_luokka,
		Onnpaiksel AS Onnettomuuspaikka,
		Kuollut AS Kuolleita,
		Loukk AS Loukkaantuneita,
		Oslajisel AS Osallisen_laji
    FROM 
        Onnettomuudet o
	INNER JOIN Osalliset os
        ON o.Onnett_id = os.Onnett_id
    WHERE
        Vuosi = @vuosi AND
		Kuolleet > 0
    ORDER BY 
        Vuosi,
		o.Onnett_id,
		Onlksel,
		Onnpaiksel,
		Kuollut,
		Loukk,
		Oslajisel;
END;
*/

-- CHECK PROCEDURE
/*
EXEC uspGetKuoll_Osall 2017
*/

------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES AND CONDITIONS
-- WITHOUT MILD INCIDENT BY SELECTED YEAR

/*
CREATE OR ALTER PROCEDURE uspGetVakOnnett_Olos (@vuosi INT)
AS 
BEGIN
    SELECT
        o.Vuosi,
	    Kk AS Kuukausi,
	    Vkpv AS Viikonp�iv�,
	    Tunti,
	    Vakavuus,
	    Loukkaant AS Loukkaantuneet,
	    Kuolleet,
	    Onlksel AS Onnett_Luokka,
	    Ontyypsel AS Onnett_Tyyppi,
	    Onnpaiksel AS Onnett_Paikka,
	    Nopraj AS Nopeusrajoitus,
	    t.Noplajisel AS NopRaj_Laji,
	    t.Risteys AS Riste�vien_lkm,
	    t.Risteyssel AS Risteys_Laji,
	    Pintasel AS Tienpinta,
	    Valsel AS Valoisuus,
	    S��sel AS S��,
	    L�mp�tila
    FROM
        Onnettomuudet o
    INNER JOIN Tieomin t
        ON o.tieomin_id = t.tieomin_id AND
	    o.Vuosi = t.Vuosi
	WHERE
        o.Vuosi = @vuosi AND
		Vakavuusko > 0
    GROUP BY 
        o.Vuosi,
	    Kk,
	    Vkpv,
	    Tunti,
	    Vakavuus,
	    Loukkaant,
	    Kuolleet,
	    Onlksel,
	    Ontyypsel,
	    Onnpaiksel,
	    Nopraj,
	    t.Noplajisel,
	    t.Risteys,
	    t.Risteyssel,
	    Pintasel,
	    Valsel,
	    S��sel,
	    L�mp�tila;
END;
*/

-- CHECK PROCEDURE
/*
EXEC uspGetVakOnnett_Olos 2017
*/

----------------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES, CONDITIONS AND LOCATION
-- WITHOUT MILD INCIDENT BY SELECTED YEAR

/*
CREATE OR ALTER PROCEDURE uspGetVakOnnett_Paikka (@vuosi INT)
AS 
BEGIN
    SELECT
        o.Vuosi,
	    Kk AS Kuukausi,
	    Vkpv AS Viikonp�iv�,
	    Tunti,
	    Vakavuus,
	    Loukkaant AS Loukkaantuneet,
	    Kuolleet,
	    Onlksel AS Onnett_Luokka,
	    Ontyypsel AS Onnett_Tyyppi,
	    Onnpaiksel AS Onnett_Paikka,
		Nopraj AS Nopeusrajoitus,
	    Pintasel AS Tienpinta,
	    Valsel AS Valoisuus,
	    S��sel AS S��,
	    L�mp�tila,
	    a.Maakuntsel AS Maakunta,
		V�est�,
	    a.Kuntasel AS Kunta,
	    Katuosoite,
	    [position.lat],
	    [position.lon]
    FROM
        Onnettomuudet o
    INNER JOIN Alueet a
        ON o.alue_id = a.alue_id
	INNER JOIN V�est� v
        ON o.Vuosi = v.Vuosi
	WHERE
        o.Vuosi = @vuosi AND
		a.Maakuntsel = v.Maakuntsel AND
		Vakavuusko > 0
    GROUP BY 
        o.Vuosi,
	    Kk,
	    Vkpv,
	    Tunti,
		Vakavuus,
	    Loukkaant,
	    Kuolleet,
	    Onlksel,
	    Ontyypsel,
	    Onnpaiksel,
		Nopraj,
	    Pintasel,
	    Valsel,
	    S��sel,
	    L�mp�tila,
	    a.Maakuntsel,
		V�est�,
	    a.Kuntasel,
	    Katuosoite,
	    [position.lat],
	    [position.lon];
END;
*/

-- CHECK PROCEDURE
/*
EXEC uspGetVakOnnett_Paikka 2017
*/