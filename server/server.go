package main

import (
	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"log"
	"net/http"
	"os"
	"server/route"
)

func main() {
	if err := godotenv.Load(); err != nil {
		log.Println("Error loading .env file")
		return
	}

	r := mux.NewRouter()

	// WORKSPACES
	log.Println("Setting up Workspace routes")
	route.WorkspaceRoutes(r)

	// BOARDS
	log.Println("Setting up Board routes")
	route.BoardRoutes(r)

	// LISTS
	log.Println("Setting up List routes")
	route.ListRoutes(r)

	// CARDS
	log.Println("Setting up Card routes")
	route.CardRoutes(r)

	//SERVER
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	log.Printf("Server listening on port %s\n", port)
	if err := http.ListenAndServe(":"+port, r); err != nil {
		log.Fatalf("Server failed to start: %v", err)
	}
}
