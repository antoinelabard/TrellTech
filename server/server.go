package main

import (
	"fmt"
	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"net/http"
	"os"
	"server/route"
)

func main() {
	if err := godotenv.Load(); err != nil {
		fmt.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	// WORKSPACES
	route.WorkspaceRoutes(r)

	// BOARDS
	route.BoardRoutes(r)

	// LISTS
	route.ListRoutes(r)

	// CARDS
	route.CardRoutes(r)

	//SERVER
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("Server listening on port %s\n", port)
	http.ListenAndServe(":"+port, r)
}
