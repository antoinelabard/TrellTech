package utils

import (
	"github.com/joho/godotenv"
	"os"
)

// Fonction pour charger les clés API à partir des variables d'environnement
// Utilisation : apiKey, apiToken, err := LoadAPIKeys()
func LoadAPIKeys() (string, string, error) {
	err := godotenv.Load()
	if err != nil {
		return "", "", err
	}

	apiKey := os.Getenv("TRELLO_API_KEY")
	apiToken := os.Getenv("TRELLO_API_TOKEN")

	return apiKey, apiToken, nil
}
