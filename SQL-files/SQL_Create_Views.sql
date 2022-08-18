-- SQL SERVER VIEWS

--use Onnettomuudet

----------------------------
-- BASE QUERY COUNT INCIDENT

/*
CREATE OR ALTER VIEW vuos_maak_onnett (
    Vuosi,
	Maakunta,
	V�est�,
	lkm_onnett, 
    lkm_kuolleet,
    lkm_loukkaant
)
AS
SELECT
    o.Vuosi,
	a.Maakuntsel,
	v.V�est�,
	COUNT(Onnett_id) lkm_onnett, 
    SUM(Kuolleet) lkm_kuolleet,
    SUM(Loukkaant) lkm_loukkaant
FROM
    Onnettomuudet o
INNER JOIN Alueet a
        ON o.alue_id = a.alue_id
INNER JOIN V�est� v
        ON o.Vuosi = v.Vuosi
WHERE
	a.Maakuntsel = v.Maakuntsel
GROUP BY 
    o.Vuosi,
	a.Maakuntsel,
	v.V�est�;
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_maak_onnett;
*/

---------------------------------------------------
-- BASE QUERY INCIDENT SERIOUS WITH INCIDENT TYPES

/*
CREATE OR ALTER VIEW vuos_maak_onnett_tyyp
AS
SELECT
    o.Onnett_id,
	o.Vuosi,
    a.Maakuntsel AS Maakunta,
    v.V�est�,
    Vakavuus,
    Onlksel AS Onnett_Luokka,
    Ontyypsel AS Onnett_Tyyppi
FROM
    Onnettomuudet o
INNER JOIN Alueet a
    ON o.alue_id = a.alue_id
INNER JOIN V�est� v
    ON o.Vuosi = v.Vuosi
WHERE
	a.Maakuntsel = v.Maakuntsel
GROUP BY 
    o.Onnett_id,
	o.Vuosi,
    a.Maakuntsel,
	v.V�est�,
    Vakavuus,
    Onlksel,
    Ontyypsel;
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_maak_onnett_tyyp;
*/

------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES AND CONDITIONS
-- WITHOUT MILD INCIDENT

/*
CREATE OR ALTER VIEW vuos_vak_onnett_olos
AS
SELECT
    o.Onnett_id,
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
    Vakavuusko > 0
GROUP BY 
    o.Onnett_id,
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
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_vak_onnett_olos;
*/

----------------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES, CONDITIONS AND LOCATION
-- WITHOUT MILD INCIDENT

/*
CREATE OR ALTER VIEW vuos_vak_onnett_paikka
AS
SELECT
    o.Onnett_id,
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
	v.V�est�,
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
	a.Maakuntsel = v.Maakuntsel AND
    Vakavuusko > 0
GROUP BY 
    o.Onnett_id,
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
	v.V�est�,
	a.Kuntasel,
	Katuosoite,
	[position.lat],
	[position.lon];
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_vak_onnett_paikka;
*/

----------------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INCIDENT TYPES, CONDITIONS AND LOCATION
-- WITH ALL INCIDENT

/*
CREATE OR ALTER VIEW vuos_onnett_paikka
AS
SELECT
    o.Onnett_id,
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
	a.Maak_Loc,
	v.V�est�,
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
	a.Maakuntsel = v.Maakuntsel
GROUP BY 
    o.Onnett_id,
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
	a.Maak_Loc,
	v.V�est�,
	a.Kuntasel,
	Katuosoite,
	[position.lat],
	[position.lon];
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_onnett_paikka;
*/

--------------------------------------------------------------------------------
-- QUERY INCIDENT SERIOUS WITH INVOLVED, INCIDENT TYPES, CONDITIONS AND LOCATION
-- WITH ALL INCIDENT

/*
CREATE OR ALTER VIEW vuos_onnett_paikka_osall
AS
SELECT
    o.Onnett_id,
	o.Vuosi,
	Kk AS Kuukausi,
	Vkpv AS Viikonp�iv�,
	Tunti,
	Vakavuus,
	Loukkaant AS Loukkaantuneet,
	Kuolleet,
	os.Oslajisel AS Osallisen_laji,
	os.Kuollut,
	os.Loukk AS Loukkaantunut,
	os.Ajoneuvika AS Ajon_ik�,
	Onlksel AS Onnett_Luokka,
	Ontyypsel AS Onnett_Tyyppi,
	Onnpaiksel AS Onnett_Paikka,
	Nopraj AS Nopeusrajoitus,
	Pintasel AS Tienpinta,
	Valsel AS Valoisuus,
	S��sel AS S��,
	L�mp�tila,
	a.Maakuntsel AS Maakunta,
	a.Maak_Loc,
	v.V�est�,
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
INNER JOIN Osalliset os
    ON o.Onnett_id = os.Onnett_id
WHERE
	a.Maakuntsel = v.Maakuntsel
GROUP BY 
    o.Onnett_id,
	o.Vuosi,
	Kk,
	Vkpv,
	Tunti,
	Vakavuus,
	Loukkaant,
	Kuolleet,
	os.Oslajisel,
	os.Kuollut,
	os.Loukk,
	os.Ajoneuvika,
	Onlksel,
	Ontyypsel,
	Onnpaiksel,
	Nopraj,
	Pintasel,
	Valsel,
	S��sel,
	L�mp�tila,
	a.Maakuntsel,
	a.Maak_Loc,
	v.V�est�,
	a.Kuntasel,
	Katuosoite,
	[position.lat],
	[position.lon];
*/

-- CHECK VIEW QUERY
/*
SELECT *
FROM
   vuos_onnett_paikka_osall;
*/