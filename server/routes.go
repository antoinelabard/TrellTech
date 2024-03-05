package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"server/controller"
	"server/utils"

	"github.com/gorilla/mux"
)

func WorkspaceRoutes(r *mux.Router) {
	r.HandleFunc("/create-organization", controller.HandleCreateOrganization).Methods("POST")
	r.HandleFunc("/delete-organization/{id}", controller.HandleDeleteOrganization).Methods("DELETE")
	r.HandleFunc("/get-organization/{id}", handleGetOrganization).Methods("GET")
	r.HandleFunc("/update-organization/{id}", handleUpdateOrganization).Methods("PUT")
	r.HandleFunc("/get-all-organizations", handleGetAllOrganizations).Methods("GET")
	r.HandleFunc("/get-organization-boards/{id}", handleGetOrganizationBoards).Methods("GET")
}

func handleGetOrganization(w http.ResponseWriter, r *http.Request) {
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
}

func handleUpdateOrganization(w http.ResponseWriter, r *http.Request) {
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
}
func handleGetAllOrganizations(w http.ResponseWriter, r *http.Request) {
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
}

func handleGetOrganizationBoards(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	boards, err := controller.GetOrganizationBoards(id, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting organization boards", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(boards)
}

// BOARD

func BoardRoutes(r *mux.Router) {
	r.HandleFunc("/create-board", controller.HandleCreateBoard).Methods("POST")
	r.HandleFunc("/update-board/{id}", handleUpdateBoard).Methods("PUT")
	r.HandleFunc("/get-board/{id}", handleGetBoard).Methods("GET")
	r.HandleFunc("/get-members/{boardId}", handleGetMembers).Methods("GET")
	r.HandleFunc("/delete-board/{boardId}", handleDeleteBoard).Methods("DELETE")
}

func handleUpdateBoard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	response, err := controller.UpdateBoard(r, id, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error updating board", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(response)
}

func handleGetBoard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	boardName, err := controller.GetBoard(id, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting board", http.StatusInternalServerError)
		return
	}

	w.Write([]byte(boardName))
}

func handleGetMembers(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	boardId := vars["boardId"]

	members, err := controller.GetMembers(boardId, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting members", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(members)
}

func handleDeleteBoard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	boardId := vars["boardId"]

	err = controller.DeleteBoard(boardId, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error deleting board", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
}

// LISTS

func ListRoutes(r *mux.Router) {
	r.HandleFunc("/create-list", handleCreateList).Methods("POST")
	r.HandleFunc("/get-lists-board/{idBoard}", handleGetListsinaboard).Methods("GET")
	r.HandleFunc("/update-list/{idList}", handleUpdateList).Methods("PUT")
	r.HandleFunc("/get-cards/{idList}", handleGetCards).Methods("GET")
	r.HandleFunc("/get-list/{idList}", handleGetList).Methods("GET")
}

func handleCreateList(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	// Extract idBoard and name from the request body
	var createListRequest struct {
		IdBoard string `json:"idBoard"`
		Name    string `json:"name"`
	}
	err = json.NewDecoder(r.Body).Decode(&createListRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	listResponse, err := controller.CreateList(createListRequest.IdBoard, createListRequest.Name, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error creating list", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(listResponse)
}

func handleGetListsinaboard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	idBoard := vars["idBoard"]

	lists, err := controller.GetListsinaboard(idBoard, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting lists", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(lists)
}

func handleUpdateList(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	idList := vars["idList"]

	// Extract newName from the request body
	var updateListRequest struct {
		NewName string `json:"name"`
	}
	err = json.NewDecoder(r.Body).Decode(&updateListRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	listResponse, err := controller.UpdateList(idList, updateListRequest.NewName, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error updating list", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(listResponse)
}

func handleGetCards(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	idList := vars["idList"]

	cards, err := controller.GetCards(idList, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting cards", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(cards)
}

func handleGetList(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	idList := vars["idList"]

	list, err := controller.GetList(idList, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting list", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(list)
}

// CARDS

func CardRoutes(r *mux.Router) {
	r.HandleFunc("/create-card", handleCreateCard).Methods("POST")
	r.HandleFunc("/get-card/{id}", handleGetCard).Methods("GET")
	r.HandleFunc("/update-card/{id}", handleUpdateCard).Methods("PUT")
	r.HandleFunc("/delete-card/{id}", handleDeleteCard).Methods("DELETE")
}

func handleCreateCard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	// Extract idList and name from the request body
	var createCardRequest struct {
		IdList string `json:"idList"`
		Name   string `json:"name"`
	}
	err = json.NewDecoder(r.Body).Decode(&createCardRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	cardResponse, err := controller.CreateCard(createCardRequest.IdList, createCardRequest.Name, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error creating card", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(cardResponse)
}

func handleGetCard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	cardResponse, err := controller.GetCard(id, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error getting card", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(cardResponse)
}
func handleUpdateCard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	// Extract newName from the request body
	var updateCardRequest struct {
		NewName string `json:"name"`
	}
	err = json.NewDecoder(r.Body).Decode(&updateCardRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		return
	}

	cardResponse, err := controller.UpdateCard(id, updateCardRequest.NewName, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error updating card", http.StatusInternalServerError)
		return
	}

	json.NewEncoder(w).Encode(cardResponse)
}

func DeleteCard(id, apiKey, apiToken string) error {
	fmt.Println("Deleting card")
	url := fmt.Sprintf("https://api.trello.com/1/cards/%s?key=%s&token=%s", id, apiKey, apiToken)

	req, err := http.NewRequest("DELETE", url, nil)
	if err != nil {
		return err
	}

	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()

	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("unexpected status code: %d", resp.StatusCode)
	}

	return nil
}

func handleDeleteCard(w http.ResponseWriter, r *http.Request) {
	apiKey, apiToken, err := utils.LoadAPIKeys()
	if err != nil {
		http.Error(w, "Error loading API keys", http.StatusInternalServerError)
		return
	}

	vars := mux.Vars(r)
	id := vars["id"]

	err = controller.DeleteCard(id, apiKey, apiToken)
	if err != nil {
		http.Error(w, "Error deleting card", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
}
