# Trelltech - Trello client

This is a simple client for Trello. It is written in Dart and Go and uses the requests library to interact with the
Trello API.

The frontend is a flutter app that connect to a backend, which fetch the data from Trello.

## Getting Started

You can clone this repository using:

```bash
git clone https://github.com/antoinelabard/skype_flutter_clone.git 
```

### Prerequisites

- Flutter SDK
- Dart SDK
- An IDE (e.g., Android Studio, VS Code, IntelliJ) with Flutter plugin installed
- For Android builds: Android Studio and Android SDK (specify API level if needed)

### Frontend

This project is a [Flutter](https://flutter.dev/) application. To get started, make sure you have Flutter installed on
your development machine. If you haven't, please refer to
the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

Make sure you have an Android emulator running, or a device connected, then execute:

```
flutter build apk
flutter run
```

### Backend

To run the backend, you need to have [Go](https://go.dev/) and [Docker](https://www.docker.com/) installed.

```bash
docker build -t trelltech-app .
docker run --name trelltech -p 8080:8080 trelltech-app

docker start trelltech
docker stop trelltech
```

For further documentation on how to use the backend, please refer to . #TODO
