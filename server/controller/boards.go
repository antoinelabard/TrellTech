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
