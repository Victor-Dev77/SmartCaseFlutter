# BlueSmart SuitCase

Application Flutter qui controle une valise connecté.

## Communication

App communique à une carte ESP32 via un protocole MQTT.

## Fonctionnalités

- Ajouter toutes vos destinations et retrouvez les sur une map

- Rechercher la météo de votre ville de destination.

- Connaître en temps réel la localisation de votre valise via le signal wifi.

- Calculer le poids de la valise afin de determiné s'il y a une différence de poids entre 2 pesées.

## Technologies

- **MQTT** Communication ESP <--> Application

- **Firebase** Authentification + Stockage des destinations et du poids

- **API OpenWeather** Récuperer la météo d'une ville

- **API Google Places** Récuperer adresse d'une destination et d'une ville (destination + météo)
