MEMÒRIA PRÀCTICA APIs I SERVEIS


EXERCICI 1: Accés a un servei API

En aquest exercici, he implementat la connexió a una API REST utilitzant Flutter.

Primer, he provat l’endpoint de l’API de cotxes mitjançant RapidAPI per veure quin format de dades retornava (JSON). Això m’ha permès entendre l’estructura dels objectes.

A continuació, he creat la classe CarsModel, que representa els cotxes. Aquesta classe inclou:

- Els atributs: id, year, make, model i type
- Un constructor amb paràmetres obligatoris
- Un mètode fromMap per convertir JSON a objecte
- Un mètode toMap per convertir objecte a JSON

Després, he afegit les funcions per treballar amb JSON, que permeten convertir una llista de JSON en una llista d’objectes CarsModel.

Seguidament, he creat un servei HTTP (CarHttpService), que s’encarrega de:

- Fer la petició GET a l’API
- Afegir les capçaleres necessàries (API key)
- Gestionar errors
- Retornar una llista de cotxes

Finalment, he implementat un test unitari, on he comprovat que:

- La resposta no està buida
- Hi ha elements a la llista
- Els objectes tenen dades correctes

També he configurat el fitxer AndroidManifest.xml per permetre connexions a internet.



EXERCICI 2: Integració de vista i model

En aquest exercici, he creat una interfície gràfica en Flutter per mostrar les dades obtingudes de l’API.

He utilitzat un FutureBuilder per gestionar la crida asíncrona al servei. Això m’ha permès controlar diferents estats:

- Càrrega de dades (loading)
- Errors
- Dades correctes

Per mostrar els resultats, he utilitzat un ListView.builder, que genera una llista dinàmica de cotxes.

Cada element de la llista mostra:

- Marca i model del cotxe
- Any
- Tipus

També he millorat la visualització utilitzant Card i icones, per fer la interfície més clara.

En aquest exercici he integrat correctament:

- Model (CarsModel)
- Servei (CarHttpService)
- Vista (UI amb Flutter)



EXERCICI 3: Aplicació d’acudits

En aquest exercici, he desenvolupat una aplicació que consumeix una API d’acudits.

Primer, he creat el model Joke, amb els atributs:

- id
- setup
- punchline

Després, he implementat el servei JokeService, que:

- Fa una petició GET a l’API
- Rep una llista d’acudits
- Selecciona un acudit aleatori

A continuació, he desenvolupat la interfície amb un StatefulWidget, que permet:

- Mostrar un acudit
- Actualitzar-lo quan es prem un botó

He afegit un botó flotant (FloatingActionButton), que torna a cridar l’API per obtenir un nou acudit.

També he gestionat l’estat de càrrega amb un indicador visual (CircularProgressIndicator).



MILLORES I FUNCIONALITATS EXTRES

A més dels requisits bàsics, he implementat millores per fer l’aplicació més completa.

He creat una pantalla de menú (MenuPage) que permet navegar entre:

- La llista de cotxes
- La pantalla d’acudits

Aquesta navegació s’ha implementat amb Navigator i rutes, permetent una millor experiència d’usuari.

També he organitzat el projecte en carpetes:

- model/
- services/
- screens/

Aquesta estructura facilita el manteniment i segueix bones pràctiques de desenvolupament.