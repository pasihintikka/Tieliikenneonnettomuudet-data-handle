# Projektitehtävä: Tieliikenneonnettomuuksien datan käsittely

Opiframe Oy:n järjestämässä Data-analytiikan osaaja koulutuksessa projektitehtävän tarkoituksena on käsitellä jotain mitattua tai verkosta hankkittua dataa ja tehdä siitä johtopäätöksiä data-analytiikan keinoin. 

### Lähdedata

Avoindata.fi sivuilta kokosin Väyläviraston tarjoamat csv -muotoiset vuosittain 2005-2021 kootut tiedostot tieliikenneonnettomuuksista. Tiedostot sisältävät myös paikkatiedon kansallisessa formaatissa.
- Paikkatieto kansallisessa formaatissa ei ole yhteensopiva yleisten visualisointityökalujen kanssa.
- Tieto vuosittaisissa tiedostoissa, joissa yli sata tietosaraketta. Uusimmissa tiedostoissa lisätty uusia tietosarakkeita. Tiedostoista alle puoletkaan eivät sopineet MongoDB ilmaiseen tallennustilaan.
- Tiedostoissa jonkin verran syöttö- tai keräysvirheitä sekä jonkin verran puuttuvia tietoja.

Tilastokeskukselta löytyi hakuehdoilla tallennettavaksi csv –muotoinen tiedosto maakuntien asukasmääristä. Maakunnat mukana onnettomuuksien tapahtuma-alueita määrittelevissä tiedoissa.
- Tiedoston muoto vaati muokkaamista, jotta tallennus tietokantatauluun ja yhteensopivaksi muiden tietokannassa olevien tietojen kanssa oli mahdollista.

### Tietovarastot

Väyläviraston ja Tilastokeskuksen tarjoamat csv –muotoiset tiedostot 35 kpl tallensin paikallisesti tietokoneelle käsittelyä varten.
- Vuosittaisten tiedostojen suuren koon vuoksi (yhteensä lähes 300 Mb) niiden sisältämistä tiedoista puoletkaan eivät sopineet MongoDB:n ilmaiseen tallennustilaan (MongoDB muuntaa joka tietorivin kokoelmaansa yhdeksi dokumentiksi).

Käsitellyt tiedot tallennettiin SQL Serveriin luotuun tietokantaan ja sen tauluihin.
- Tallennettavan tiedon määrää saatiin pienennettyä luomalla tiedoissa toistuvasti esiintyviä selkeitä tietorakenteita varten omat taulut 5 kpl (olisi voinut enemmänkin hajauttaa) ja määriteltiin niille tietojen väliset riippuvuudet (SQL_Create_Tables.sql).

SQL Server tietokantaan tehtyjen kyselyjen perusteella luotuja datatiedostoja tallennettu MongoDB Atlaksen ilmaiseen tietovarastoon.
- Kyselyillä rajattiin tallennettavaa tietomäärää vain siihen, jota arveltiin voivan tarvita MongoDB:llä tehtävässä visualisoinnissa.

### Tietojen käsittely

Käsittelyyn luotiin eri tarkoituksia varten python koodeja. Koodit on tehty Jupyter Notebookissa.
- Paikkatiedon muunnokset kansallisesta kansainväliseen formaattiin (Coord_Conversion_for_Files.ipynb).
- Muunnoksen jälkeen tiedostot pilkottiin kolmeen osaan luotujen tietokannan taulujen mukaan (Editing_Files_for_DB.ipynb).
- Ennen tietokantaan vientiä pilkotuista tiedostoista tarkistettiin sisältövirheitä ja sarake-eroja, jotka aiheuttavat virheitä tietokantaan viennissä (Check_file_error.ipynb ja Check_file_columns.ipynb). Raportoinnissa havaittiin lähdedatassa suuri määrä sisältövirheitä, jotka vääristivät raportointia. Virheitä korjattiin tietosisällön kuvauksen mukaiseen muotoon sekä etsittiin säännönmukaisuutta esim. koordinaattivirheisiin, jotta ne valtaosaltaan voitiin korjata pythonilla ja SQL komennoilla (SQL_Test_Queries.sql ja SQL_Correct_Errors.sql).
- Osa vuosittaisista tiedostoista voitiin pilkkomisen jälkeen yhdistää yhdeksi (File_merge_for_DB.ipynb).
- Tiedostojen siirtoon SQL Serveriin, MongoDB Atlakseen ja Google Sheetsiin sekä niistä haku takaisin tiedostoiksi (Insert_data_to_sqlserver.ipynb, Insert_Data_to_MongoDB.ipynb, Get_Data_from_MongoDB.ipynb ja Insert_Data_to_GoogleSheet.ipynb).

### Tietojen raportointi

Raportoinnnissa tietoa pyritään analysoimaan etsimällä siinä esiintyviä piirteitä, ominaisuuksia ja niiden keskinäisiä riippuvuuksia. Analysointia merkittävästi helpottaa, jos haluttuja asioita visualisoidaan. Visualisointia tehtiin sekä Pythonilla (Jupyter Notebook), MongoDB Atlaksella ja Google Data Studiolla.
- Jupyter Notebookissa visualisointiin tarvittavat tiedot haettiin SQL Server tietokannasta python koodilla joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria (SQL_Create_Views.sql ja SQL_Create_Procedures.sql).
- MongoDB Atlaksen tietovarastoon tallennettiin python koodilla muutamia kokoelmia, joiden sisältö määriteltiin tallennusta varten tehtävän tiedoston SQL kyselyssä joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria.
- Google Data Studiossa visualisointiin tarvittavat tiedot tallennettiin python koodilla Google Sheets tiedoston välilehdille, joiden sisältö määriteltiin SQL kyselyssä käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria.
- SQL Serverin Viewit sisälsivät sellaisia tietokenttiä, joilla visualisoinnin yleisimmät tarpeet täyttyvät.
- SQL Serverin Stored Procedurit sisälsivät enemmän tietokenttiä, hakua rajoitettiin sen kutsussa muuttujana annettavan tiedon mukaan (Vuosi).

### Kaavio toteutuksesta

<p align="center">
<img src="https://user-images.githubusercontent.com/110663840/186427226-a0e35726-7155-46c0-a2ec-737361652865.png" width="750" height="392">
</p>

### Linkit MongoDB Atlas raporttiesimerkkeihin

- Lukumääriä palkkikaavioina [Barcharts sample](https://charts.mongodb.com/charts-opiframe-dvsup/public/dashboards/79658628-7142-4063-962d-8d7fad43de02)
- Lukumääriä kartalla paikkatiedon mukaan [Geomaps sample](https://charts.mongodb.com/charts-opiframe-dvsup/public/dashboards/1250830d-e31f-4fe5-902e-b5ac1c136f11)
- Lukumääriä riippuvuustaulukoissa [Heatmaps sample](https://charts.mongodb.com/charts-opiframe-dvsup/public/dashboards/c37f458d-17f3-42f2-9ceb-62b895655eca)

### Linkki Google Data Studio raporttiesimerkkeihin

- Lukumääriä ja jakaumia taulukoina, kaavioina sekä kartta-alueina [Sample Onnettomuudet](https://datastudio.google.com/reporting/45f072ec-9a91-4ae3-9ebb-2b06cfe717ab)
