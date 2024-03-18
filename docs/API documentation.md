# API documentation

This documentation gives an overview of the routes provides by the backend.

## Table of content

- [Organizations routes](#organizations-routes)
- [Boards routes](#boards-routes)
- [Lists routes](#lists-routes)
- [Cards routes](#cards-routes)

## Organizations routes

- `GET /get-all-organizations` : Get all the organizations of the user
- `GET /get-organization/{id}` : Get the organization with the given id
- `GET /get-organizations-boards/{id}` : Get all the boards of the organization with the given id
- `POST /create-organization/{id}` : Create the organization with the given id
- `PUT /update-organization/{id}` : Update the organization with the given id

## Boards routes

- `GET /get-all-boards` : Get all the boards of the user
- `GET /get-board/{id}` : Get the board with the given id
- `POST /create-board/{id}` : Create the board with the given id
- `PUT /update-board/{id}` : Update the board with the given id
- `DELETE /delete-board/{id}` : Delete the board with the given id

## Lists routes

- `GET /get-list/{id}` : Get the list with the given id
- `GET /get-lists-board/{idBoard}` : Get the list with the given id
- `GET /get-cards/{id}` : Get all the cards of the list with the given id
- `POST /create-list/{id}` : Create the list with the given id
- `PUT /update-list/{id}` : Update the list with the given id
- `DELETE /delete-list/{id}` : Delete the list with the given id

## Cards routes

- `GET /get-card/{id}` : Get the card with the given id
- `POST /create-card/{id}` : Create the card with the given id
- `PUT /update-card/{id}` : Update the card with the given id
- `DELETE /delete-card/{id}` : Delete the card with the given id
