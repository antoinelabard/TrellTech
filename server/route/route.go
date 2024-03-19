package route

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
	r.HandleFunc("/get-organization/{id}", HandleGetOrganization).Methods("GET")
	r.HandleFunc("/update-organization/{id}", HandleUpdateOrganization).Methods("PUT")
	r.HandleFunc("/get-all-organizations", HandleGetAllOrganizations).Methods("GET")
	r.HandleFunc("/get-organization-boards/{id}", HandleGetOrganizationBoards).Methods("GET")
}

func HandleGetOrganization(w http.ResponseWriter, r *http.Request) {
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

func HandleUpdateOrganization(w http.ResponseWriter, r *http.Request) {
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
func HandleGetAllOrganizations(w http.ResponseWriter, r *http.Request) {
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

func HandleGetOrganizationBoards(w http.ResponseWriter, r *http.Request) {
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
	r.HandleFunc("/update-board/{id}", HandleUpdateBoard).Methods("PUT")
	r.HandleFunc("/get-board/{id}", HandleGetBoard).Methods("GET")
	r.HandleFunc("/get-members/{boardId}", handleGetMembers).Methods("GET")
	r.HandleFunc("/delete-board/{boardId}", HandleDeleteBoard).Methods("DELETE")
}

func HandleUpdateBoard(w http.ResponseWriter, r *http.Request) {
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

func HandleGetBoard(w http.ResponseWriter, r *http.Request) {
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

func HandleDeleteBoard(w http.ResponseWriter, r *http.Request) {
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
	r.HandleFunc("/create-list", HandleCreateList).Methods("POST")
	r.HandleFunc("/get-lists-board/{idBoard}", HandleGetListsinaboard).Methods("GET")
	r.HandleFunc("/update-list/{idList}", HandleUpdateList).Methods("PUT")
	r.HandleFunc("/get-cards/{idList}", HandleGetCards).Methods("GET")
	r.HandleFunc("/get-list/{idList}", HandleGetList).Methods("GET")
}

func HandleCreateList(w http.ResponseWriter, r *http.Request) {
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

func HandleGetListsinaboard(w http.ResponseWriter, r *http.Request) {
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

func HandleUpdateList(w http.ResponseWriter, r *http.Request) {
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

func HandleGetCards(w http.ResponseWriter, r *http.Request) {
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

func HandleGetList(w http.ResponseWriter, r *http.Request) {
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
	r.HandleFunc("/create-card", HandleCreateCard).Methods("POST")
	r.HandleFunc("/get-card/{id}", HandleGetCard).Methods("GET")
	r.HandleFunc("/update-card/{id}", HandleUpdateCard).Methods("PUT")
	r.HandleFunc("/delete-card/{id}", HandleDeleteCard).Methods("DELETE")
}

func HandleCreateCard(w http.ResponseWriter, r *http.Request) {
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

func HandleGetCard(w http.ResponseWriter, r *http.Request) {
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
func HandleUpdateCard(w http.ResponseWriter, r *http.Request) {
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

func HandleDeleteCard(w http.ResponseWriter, r *http.Request) {
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
