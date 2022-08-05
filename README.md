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
- Tallennettavan tiedon määrää saatiin pienennettyä luomalla tiedoissa toistuvasti esiintyviä selkeitä tietorakenteita varten omat taulut 5 kpl (olisi voinut enemmänkin hajauttaa) ja määriteltiin niille tietojen väliset riippuvuudet.

SQL Server tietokantaan tehtyjen kyselyjen perusteella luotuja datatiedostoja tallennettu MongoDB Atlaksen ilmaiseen tietovarastoon.
- Kyselyillä rajattiin tallennettavaa tietomäärää vain siihen, jota arveltiin voivan tarvita MongoDB:llä tehtävässä visualisoinnissa.

### Tietojen käsittely

Käsittelyyn luotiin eri tarkoituksia varten python koodeja. Koodit on tehty Jupyter Notebookissa.
- Paikkatiedon muunnokset kansallisesta kansainväliseen formaattiin (Coord_Conversion_for_Files.ipynb)
- Muunnoksen jälkeen tiedostot pilkottiin kolmeen osaan luotujen tietokannan taulujen mukaan (Editing_Files_for_DB.ipynb)
- Ennen tietokantaan vientiä pilkotuista tiedostoista tarkistettiin sisältövirheitä ja sarake-eroja, jotka aiheuttavat virheitä tietokantaan viennissä (Check_file_error.ipynb ja Check_file_columns.ipynb)
- Osa vuosittaisista tiedostoista voitiin pilkkomisen jälkeen yhdistää yhdeksi (File_merge_for_DB.ipynb)
- Tiedostojen siirtoon SQL Serveriin ja MongoDB Atlakseen sekä niistä haku takaisin tiedostoiksi (Insert_data_to_sqlserver.ipynb, Insert_Data_to_MongoDB.ipynb ja Get_Data_from_MongoDB.ipynb)

### Tietojen raportointi

Raportoinnnissa tietoa pyritään analysoimaan etsimällä siinä esiintyviä piirteitä, ominaisuuksia ja niiden keskinäisiä riippuvuuksia. Analysointia merkittävästi helpottaa, jos haluttuja asioita visualisoidaan. Visualisointia tehtiin sekä Pythonilla (Jupyter Notebook) ja MongoDB Atlaksella
- Jupyter Notebookissa visualisointiin tarvittavat tiedot haettiin SQL Server tietokannasta python koodilla joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria
- MongoDB Atlaksen tietovarastoon tallennettiin python koodilla muutamia kokoelmia, joiden sisältö määriteltiin tallennusta varten tehtävän tiedoston SQL kyselyssä joko tekemällä haun yhteydessä SQL kysely tai käyttämällä muutamaa SQL serveriin tallennettua Viewiä tai Stored Proceduria
- SQL Serverin Viewit sisälsivät sellaisia tietokenttiä, joilla visualisoinnin yleisimmät tarpeet täyttyvät.
- SQL Serverin Stored Procedurit sisälsivät enemmän tietokenttiä, hakua rajoitettiin sen kutsussa muuttujana annettavan tiedon mukaan (Vuosi).

### Kaavio toteutuksesta

<p align="center">
<img src="https://user-images.githubusercontent.com/110663840/183087903-71838152-038a-4fda-b9b0-7e28f7559063.png" width="750" height="392">
</p>
