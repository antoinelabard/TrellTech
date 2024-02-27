package workspace

import (
	"bytes"
	"encoding/json"
	"fmt"
	"github.com/gorilla/mux"
	"io/ioutil"
	"net/http"
	"server/utils"
)

// Structure de la réponse de l'API Trello
type Response struct {
	ID string `json:"id"`
}
type CreateRequest struct {
	DisplayName string `json:"displayName"`
}

func createOrganization(createRequest CreateRequest, apiKey, apiToken string) (*Response, error) {
	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/organizations?key=%s&token=%s", apiKey, apiToken)

	// Création du corps de la requête
	reqBody, err := json.Marshal(createRequest)
	if err != nil {
		return nil, err
	}

	// Création de la requête HTTP
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(reqBody))
	if err != nil {
		return nil, err
	}

	// Ajout de l'en-tête Accept à la requête
	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/json")

	// Envoi de la requête HTTP
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	// Lecture de la réponse HTTP
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	// Décodage de la réponse JSON dans la structure Response
	var response Response
	err = json.Unmarshal(body, &response)
	if err != nil {
		return nil, err
	}
	return &response, nil
}

// Fonction pour récupérer une organisation sur Trello par son ID
func GetOrganization(r *http.Request, apiKey, apiToken string) (*Response, error) {
	// Récupérer l'ID à partir de la route
	vars := mux.Vars(r)
	id, ok := vars["id"]
	if !ok {
		return nil, fmt.Errorf("id is missing")
	}

	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/organizations/%s?key=%s&token=%s", id, apiKey, apiToken)

	// Création de la requête HTTP
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return nil, err
	}

	// Ajout de l'en-tête Accept à la requête
	req.Header.Set("Accept", "application/json")

	// Envoi de la requête HTTP
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	// Lecture de la réponse HTTP
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	// Décodage de la réponse JSON dans la structure Response
	var response Response
	err = json.Unmarshal(body, &response)
	if err != nil {
		return nil, err
	}
	return &response, nil
}

type UpdateRequest struct {
	DisplayName string `json:"displayName"`
}

// Fonction pour mettre à jour une organisation sur Trello
func UpdateOrganization(r *http.Request, apiKey, apiToken string) (*Response, error) {
	// Récupérer l'ID à partir de la route
	vars := mux.Vars(r)
	id, ok := vars["id"]
	if !ok {
		return nil, fmt.Errorf("id is missing")
	}

	// Récupérer le nouveau displayName à partir du corps de la requête
	var updateRequest UpdateRequest
	err := json.NewDecoder(r.Body).Decode(&updateRequest)
	if err != nil {
		return nil, err
	}

	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/organizations/%s?key=%s&token=%s", id, apiKey, apiToken)

	// Création de la requête HTTP
	reqBody, err := json.Marshal(updateRequest)
	if err != nil {
		return nil, err
	}
	req, err := http.NewRequest("PUT", url, bytes.NewBuffer(reqBody))
	if err != nil {
		return nil, err
	}

	// Ajout de l'en-tête Accept à la requête
	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/json")

	// Envoi de la requête HTTP
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	// Lecture de la réponse HTTP
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}

	// Décodage de la réponse JSON dans la structure Response
	var response Response
	err = json.Unmarshal(body, &response)
	if err != nil {
		return nil, err
	}
	return &response, nil
}

// Fonction pour supprimer une organisation sur Trello
func DeleteOrganization(r *http.Request, apiKey, apiToken string) error {
	// Récupérer l'ID à partir de la route
	vars := mux.Vars(r)
	id, ok := vars["id"]
	if !ok {
		return fmt.Errorf("id is missing")
	}

	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/organizations/%s?key=%s&token=%s", id, apiKey, apiToken)

	// Création de la requête HTTP
	req, err := http.NewRequest("DELETE", url, nil)
	if err != nil {
		return err
	}

	// Ajout de l'en-tête Accept à la requête
	req.Header.Set("Accept", "application/json")

	// Envoi de la requête HTTP
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	// Vérifier le code de statut de la réponse
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	return nil
}

// Gestionnaire de route pour supprimer une organisation
func HandleDeleteOrganization(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	// Appel de la fonction pour supprimer une organisation
	err = DeleteOrganization(r, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error deleting organization", http.StatusInternalServerError)
		return
	}

	// Envoi de la réponse au client
	w.WriteHeader(http.StatusOK)
}

// Gestionnaire de route pour créer une organisation
func HandleCreateOrganization(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	// Récupérer le displayName à partir du corps de la requête
	var createRequest CreateRequest
	err = json.NewDecoder(r.Body).Decode(&createRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	// Appel de la fonction pour créer une organisation
	response, err := createOrganization(createRequest, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error creating organization", http.StatusInternalServerError)
		return
	}

	// Envoi de la réponse au client
	json.NewEncoder(w).Encode(response)
}
