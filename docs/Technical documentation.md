# Technical documentation

This document provides a detailed overview of the architecture and the implementation of the Trello client.

## Table of Contents

- [Architecture](#architecture)
- [Frontend](#frontend)
- [Backend](#backend)

## Architecture

The project is divided into two main parts: the frontend and the backend.

The frontend is a Flutter application that connects to a backend, which is a Go server that fetches the data from
Trello.

Here is a diagram of the components' communication:

![components](components%20communication.png)

## Frontend

Here is a class diagram of the mobile application:

![client architecture](client%20architecture.png)

The display of the data is handled by a set of widgets, which are organized in 2 categories:

- The screens, which have a rooting structure to navigate between them.
- The components, which are reusable widgets that are used in one or multiple screens.

Inside the application, the manipulated data are stored in class named _models_.
Those class are responsible to represent with fidelity the data that are fetched from the backend as objects.
It can be, for example, a card or a board.

The data is fetched from the backend using a set of methods, which are responsible for making the requests to the
server. These methods reunite all the crud for a model, and are each gathered in a repository.

The repository is responsible to communicate with the outside world, and convert the fetched data into the models
format, to make them usable by the application.

## Backend

The API endpoints are documented [here](API%20documentation.md).

The backend handles no data storage, so the API
is only used to fetch data from Trello. The crud is inspired by endpoints that Trello provides, but it only keeps the
features and data that the project needs in our context. No useless endpoint is provided to the frontend, and some data
may have changes in their format.
