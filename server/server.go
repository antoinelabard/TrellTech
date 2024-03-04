package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"server/login"
	"server/utils"
	"server/workspace"

	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(); err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	r.HandleFunc("/create-organization", workspace.HandleCreateOrganization).Methods("POST")

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

	r.HandleFunc("/delete-organization/{id}", workspace.HandleDeleteOrganization).Methods("DELETE")

	r.HandleFunc("/login", login.Handler).Methods("GET")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Server listening on port %s\n", port)
	http.ListenAndServe(":"+port, r)
}
