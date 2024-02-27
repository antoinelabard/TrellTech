package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"server/utils"
	"server/workspace"

	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load()
	if err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	// Définir les routes ici
	r.HandleFunc("/create-organization", workspace.HandleCreateOrganization).Methods("POST")
	// TES DANS POSTMAN HEADER KEY VALUE / displayName Test
	r.HandleFunc("/get-organization/{id}", func(w http.ResponseWriter, r *http.Request) {
		apiKey, apiToken, err := utils.LoadAPIKeys()
		if err != nil {
			http.Error(w, "Error loading API keys", http.StatusInternalServerError)
			return
		}
		response, err := workspace.GetOrganization(r, apiKey, apiToken)
		if err != nil {
			http.Error(w, "Error getting organization", http.StatusInternalServerError)
			return
		}
		json.NewEncoder(w).Encode(response)
	}).Methods("GET")

	r.HandleFunc("/update-organization/{id}", func(w http.ResponseWriter, r *http.Request) {
		apiKey, apiToken, err := utils.LoadAPIKeys()
		if err != nil {
			http.Error(w, "Error loading API keys", http.StatusInternalServerError)
			return
		}
		response, err := workspace.UpdateOrganization(r, apiKey, apiToken)
		if err != nil {
			http.Error(w, "Error updating organization", http.StatusInternalServerError)
			return
		}
		json.NewEncoder(w).Encode(response)
	}).Methods("PUT")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	// Lancer le serveur
	fmt.Printf("Server listening on port %s\n", port)
	http.ListenAndServe(":"+port, r)
}
