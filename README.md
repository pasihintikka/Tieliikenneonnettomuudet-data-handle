# Harjoitus: Tieliikenneonnettomuuksien datan käsittely

Opiframe Oy:n järjestämässä Data-analytiikan osaaja koulutuksessa projektitehtävän tarkoituksena on käsitellä jotain mitattua tai verkosta hankkittua dataa ja tehdä siitä johtopäätöksiä data-analytiikan keinoin. 

### Lähdedata

Avoindata.fi sivuilta kokosin Väyläviraston tarjoamat csv -muotoiset vuosittain 2005-2021 kootut tiedostot tieliikenneonnettomuuksista. Tiedostot sisältävät myös paikkatiedon kansallisessa formaatissa.
- Paikkatieto kansallisessa formaatissa ei ole yhteensopiva yleisten visualisointityökalujen kanssa.
- Tieto vuosittaisissa tiedostoissa, joiden koko on aika suuri (yli sata tietosaraketta) niiden sisältämien tietojen johdosta. Uusimmissa tiedostoissa lisätty uusia tietosarakkeita. Tiedostoista alle puoletkaan eivät sopineet MongoDB ilmaiseen tallennustilaan.
- Tiedostoissa jonkin verran (ei merkittävässä määrin) syöttö- tai keräysvirheitä sekä jonkin verran puuttuvia tietoja.
- Tilastokeskukselta löytyi hakuehdoilla tallennettavaksi csv –muotoinen tiedosto maakuntien asukasmääristä. Maakunnat mukana onnettomuuksien tapahtuma-alueita määrittelevissä tiedoissa.
- Tiedoston muoto vaati muokkaamista, jotta tallennus tietokantatauluun ja yhteensopivaksi muiden tietokannassa olevien tietojen kanssa.

### Tietovarastot

Väyläviraston ja Tilastokeskuksen tarjoamat csv –muotoiset tiedostot 35 kpl tallensin paikallisesti tietokoneelle käsittelyä varten.
- Tieto vuosittaisissa tiedostoissa, joiden koko on aika suuri (yli sata tietosaraketta vajaa 300 Mb) niiden sisältämien tietojen johdosta. Uusimmissa tiedostoissa lisätty uusia tietosarakkeita. Tiedostoista alle puoletkaan eivät sopineet MongoDB:n ilmaiseen tallennustilaan (tiedostojen koko kasvoi reilusti sinne muunnettaessa).

Käsitellyt tiedot tallennettiin SQL Serveriin luotuun tietokantaan ja sen tauluihin.
- Tallennettavan tiedon määrää saatiin pienennettyä luomalla tiedoissa toistuvasti esiintyviä selkeitä tietorakenteita varten omat taulut 5 kpl (olisi voinut enemmänkin hajauttaa) ja määriteltiin niille tietojen väliset riippuvuudet.

SQL Server tietokantaan tehtyjen kyselyjen perusteella luotuja datatiedostoja tallennettu MongoDB Atlaksen ilmaiseen tietovarastoon.
- Kyselyillä rajattiin tallennettavaa tietomäärää vain siihen, jota arveltiin voivan tarvita MongoDB:llä tehtävässä visualisoinnissa.

### Tietojen käsittely

- Paikkatiedon formaatin muunnokset kansallisesta kansainväliseen formaattiin (python ohjelmakoodi 
Coord_Conversion_for_Files.ipynb)
- Muunnoksen jälkeen tiedostot pilkottiin kolmeen osaan luotujen tietokannan taulujen mukaan (python ohjelmakoodi Editing_Files_for_DB.ipynb)
- Ennen tietokantaan vientiä pilkotuista tiedostoista tarkistettiin sisältövirheitä ja sarake-eroja, jotka aiheuttavat virheitä tietokantaan viennissä (python ohjelmakoodit Check_file_error.ipynb ja Check_file_columns.ipynb)
- Osa vuosittaisista tiedostoista voitiin pilkkomisen jälkeen yhdistää yhdeksi (python ohjelmakoodi File_merge_for_DB.ipynb)
- Tiedostojen siirtoon SQL Serveriin ja MongoDB Atlakseen sekä niistä haku takaisin tiedostoiksi python koodeilla Insert_data_to_sqlserver.ipynb, Insert_Data_to_MongoDB.ipynb ja 
Get_Data_from_MongoDB.ipynb

### Tietojen visualisointi

Visualisointia tehtiin Jupyter Notebookilla (python ohjelmoinnilla) ja MongoDB Atlaksella
- Jupyter Notebookissa visualisointiin tarvittavat tiedot haettiin SQL Server tietokannasta python koodilla joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria
- MongoDB Atlaksen tietovarastoon tallennettiin python koodilla muutamia Collectioneja, joiden sisältö määriteltiin tallennusta varten tehtävän tiedoston SQL kyselyssä joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria
- SQL Serverin Viewit sisälsivät sellaisia yleisiä tietokenttiä, joista visualisoinnin yleisimmät tarpeet täyttyvät.
- SQL Serverin Stored Procedurit sisälsivät hieman enemmän tietokenttiä, mutta haun kutsussa on annettava muuttujana tieto minkä vuoden tietoja haku koskee.

### Kaavio toteutuksesta

<p align="center">
![image](https://user-images.githubusercontent.com/110663840/183085528-6e82c9a7-44bd-4bf8-ad24-169def3f99c0.png)
</p>
