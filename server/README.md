# Nom de votre projet

## Prérequis

- [Go](https://golang.org/dl/) (version 1.16 ou supérieure)

## Installation

1. Installez Go en suivant les instructions sur le [site officiel de Go](https://golang.org/doc/install).

2. Installez le SDK Groot en utilisant la commande `go get` dans votre terminal :
    ```go
    go get github.com/groot/groot-sdk
    ```

3. Configurez votre environnement GoLand pour utiliser le SDK Groot :
    - Ouvrez votre projet dans GoLand.
    - Allez dans `File > Settings > Go > Go Modules (vgo)`.
    - Cochez l'option `Enable Go Modules (vgo) integration`.
    - Dans `File > Settings > Go > GOPATH`, assurez-vous que le chemin vers votre SDK Groot est correctement défini dans `Global GOPATH`.
    - Cliquez sur `Apply` puis `OK` pour sauvegarder les modifications.
    - Redémarrez GoLand pour que les modifications prennent effet.

## Commandes Go courantes

- `go build` : compile votre programme.
- `go run` : compile et exécute votre programme.
- `go test` : exécute les tests de votre programme.
- `go get` : télécharge et installe des packages et des dépendances.
- `go mod tidy` : ajoute les dépendances manquantes à `go.mod` et supprime les dépendances inutilisées.

## Licence

Ajoutez ici des informations sur la licence de votre projet.



DOCKER : 

docker build -t trelltech-app .
docker run --name trelltech -p 8080:8080 trelltech-app

docker start trelltech
docker stop trelltech

