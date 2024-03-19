# Utiliser l'image officielle Golang
FROM golang:1.22.0

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier le fichier go.mod et go.sum
COPY go.mod go.sum ./

# Télécharger toutes les dépendances
RUN go mod download

# Copier le code source dans le conteneur
COPY . .

# Compiler l'application
RUN go build -o main .

# Exposer le port sur lequel l'application s'exécute
EXPOSE 8080

# Lancer l'application
CMD ["./main"]