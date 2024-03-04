package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"server/controller"
	"server/utils"

	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
)

func main() {
	if err := godotenv.Load(); err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	r.HandleFunc("/create-organization", controller.HandleCreateOrganization).Methods("POST")

	r.HandleFunc("/get-organization/{id}", func(w http.ResponseWriter, r *http.Request) {
		apiKey, apiToken, err := utils.LoadAPIKeys()
		if err != nil {
			http.Error(w, "Error loading API keys", http.StatusInternalServerError)
			return
		}

		response, err := controller.GetOrganization(r, apiKey, apiToken)
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

		response, err := controller.UpdateOrganization(r, apiKey, apiToken)
		if err != nil {
			http.Error(w, "Error updating organization", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(response)
	}).Methods("PUT")

	r.HandleFunc("/get-all-organizations", func(w http.ResponseWriter, r *http.Request) {
		apiKey, apiToken, err := utils.LoadAPIKeys()
		if err != nil {
			http.Error(w, "Error loading API keys", http.StatusInternalServerError)
			return
		}

		responses, err := controller.GetAllOrganizations(apiKey, apiToken)
		if err != nil {
			http.Error(w, "Error getting all organizations", http.StatusInternalServerError)
			return
		}

		json.NewEncoder(w).Encode(responses)
	}).Methods("GET")

	r.HandleFunc("/delete-organization/{id}", controller.HandleDeleteOrganization).Methods("DELETE")

	// BOARDS
	r.HandleFunc("/create-board", controller.HandleCreateBoard).Methods("POST")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Server listening on port %s\n", port)
	http.ListenAndServe(":"+port, r)
}
