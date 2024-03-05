package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"net/http"
	"os"
)

func main() {
	if err := godotenv.Load(); err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	// WORKSPACES
	WorkspaceRoutes(r)

	// BOARDS
	BoardRoutes(r)

	// LISTS
	ListRoutes(r)

	// CARDS
	CardRoutes(r)

	//SERVER
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Server listening on port %s\n", port)
	http.ListenAndServe(":"+port, r)
}
