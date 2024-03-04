package login

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
)

type User struct {
	ID       string `json:"id"`
	Username string `json:"username"`
	FullName string `json:"fullName"`
	Email    string `json:"email"`
	Token    string `json:"token"`
}

type LoginRequest struct {
	Token string `json:"token"`
}

func Handler(w http.ResponseWriter, r *http.Request) {
	// Récupérer le token à partir du corps de la requête
	var loginRequest LoginRequest
	err := json.NewDecoder(r.Body).Decode(&loginRequest)
	if err != nil {
		http.Error(w, "Error decoding request body", http.StatusBadRequest)
		fmt.Println("Error decoding request body:", err)
		return
	}

	// Appeler l'API Trello pour récupérer les informations de l'utilisateur
	resp, err := http.Get(fmt.Sprintf("https://api.trello.com/1/members/me?key=%s&token=%s", os.Getenv("TRELLO_API_KEY"), loginRequest.Token))
	if err != nil {
		fmt.Println("Erreur lors de la récupération des informations de l'utilisateur :", err)
		return
	}
	defer resp.Body.Close()

	// Déserialized la réponse JSON
	var user User
	err = json.NewDecoder(resp.Body).Decode(&user)
	if err != nil {
		fmt.Println("Erreur lors de la déserialisation de la réponse JSON :", err)
		return
	}

	// Stocker le token dans le local storage
	err = os.Setenv("TOKEN", user.Token)
	if err != nil {
		fmt.Println("Erreur lors de la sauvegarde du token dans le local storage :", err)
		return
	}

	// Afficher les informations de l'utilisateur
	fmt.Printf("Vous êtes connecté en tant que %s (%s) avec l'email %s et le token %s\n", user.Username, user.FullName, user.Email, user.Token)
}

func main() {
	http.HandleFunc("/", Handler)
	http.ListenAndServe(":8080", nil)
}
