package controller

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"server/utils"
)

type CreateBoardRequest struct {
	Name           string `json:"name"`
	IdOrganization string `json:"idOrganization"`
}

func CreateBoard(r *http.Request, apiKey, apiToken string) (*Response, error) {
	var createBoardRequest CreateBoardRequest
	err := json.NewDecoder(r.Body).Decode(&createBoardRequest)
	if err != nil {
		return nil, fmt.Errorf("error decoding request body: %v", err)
	}

	url := fmt.Sprintf("https://api.trello.com/1/boards/?name=%s&idOrganization=%s&key=%s&token=%s", createBoardRequest.Name, createBoardRequest.IdOrganization, apiKey, apiToken)

	reqBody, err := json.Marshal(createBoardRequest)
	if err != nil {
		return nil, fmt.Errorf("error marshalling request body: %v", err)
	}
	req, err := http.NewRequest("POST", url, bytes.NewBuffer(reqBody))
	if err != nil {
		return nil, fmt.Errorf("error creating new request: %v", err)
	}

	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("error sending request: %v", err)
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading response body: %v", err)
	}

	var response Response
	err = json.Unmarshal(body, &response)
	if err != nil {
		return nil, fmt.Errorf("error unmarshalling response body: %v", err)
	}
	return &response, nil
}
func HandleCreateBoard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	response, err := CreateBoard(r, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error creating board", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(response)
}

type UpdateBoardRequest struct {
	NewName           string `json:"name"`
	NewIdOrganization string `json:"idOrganization"`
}

func UpdateBoard(r *http.Request, id, apiKey, apiToken string) (*Response, error) {
	var updateBoardRequest UpdateBoardRequest
	err := json.NewDecoder(r.Body).Decode(&updateBoardRequest)
	if err != nil {
		return nil, fmt.Errorf("error decoding request body: %v", err)
	}

	url := fmt.Sprintf("https://api.trello.com/1/boards/%s/?key=%s&token=%s", id, apiKey, apiToken)

	if updateBoardRequest.NewIdOrganization != "" {
		url = fmt.Sprintf("%s&idOrganization=%s", url, updateBoardRequest.NewIdOrganization)
	}

	if updateBoardRequest.NewName != "" {
		url = fmt.Sprintf("%s&name=%s", url, updateBoardRequest.NewName)
	}
	fmt.Printf("New name: %s\n", updateBoardRequest.NewName)

	req, err := http.NewRequest("PUT", url, nil)
	if err != nil {
		return nil, fmt.Errorf("error creating new request: %v", err)
	}

	req.Header.Set("Accept", "application/json")
	req.Header.Set("Content-Type", "application/json")

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("error sending request: %v", err)
	}
	defer resp.Body.Close()

	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("error reading response body: %v", err)
	}

	var response Response
	err = json.Unmarshal(body, &response)
	if err != nil {
		return nil, fmt.Errorf("error unmarshalling response body: %v", err)
	}
	return &response, nil
}

type Board struct {
	Name string `json:"name"`
}

func GetBoard(id, apiKey, apiToken string) (string, error) {
	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/boards/%s?key=%s&token=%s", id, apiKey, apiToken)

	// Création de la requête HTTP
	req, err := http.NewRequest("GET", url, nil)
	if err != nil {
		return "", err
	}

	// Ajout de l'en-tête Accept à la requête
	req.Header.Set("Accept", "application/json")

	// Envoi de la requête HTTP
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	// Lecture de la réponse HTTP
	body, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	// Décodage de la réponse JSON dans la structure Board
	var board Board
	err = json.Unmarshal(body, &board)
	if err != nil {
		return "", err
	}

	// Retourner le nom du tableau
	return board.Name, nil
}

type Member struct {
	Id   string `json:"id"`
	Name string `json:"fullName"`
}

func GetMembers(boardId, apiKey, apiToken string) ([]*Member, error) {
	// Construction de l'URL de l'API
	url := fmt.Sprintf("https://api.trello.com/1/boards/%s/memberships?key=%s&token=%s", boardId, apiKey, apiToken)

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

	// Décodage de la réponse JSON dans la structure Member
	var members []*Member
	err = json.Unmarshal(body, &members)
	if err != nil {
		return nil, err
	}
	return members, nil
}
