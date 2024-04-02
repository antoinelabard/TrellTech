import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'services/auth_service.dart';
import 'services/boards_services.dart';
import 'services/cards_service.dart';
import 'services/lists_service.dart';
import 'services/organization_service.dart';
import 'services/user_info_service.dart';

/// The home screen
class DebugScreen extends StatelessWidget {
  /// Constructs a [DebugScreen]
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<Auth>().signUp().then((webWiew) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                appBar: AppBar(
                                    title: const Text('Trello Sign-up')),
                                body: WebViewWidget(controller: webWiew))));
                  });
                },
                child: const Text('sign-up'),
              ),
              //text to show apitoken
              Consumer<Auth>(
                builder: (context, auth, child) {
                  return Text(auth.apiToken ?? 'no token');
                },
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // user info
                      Consumer<TokenMember>(
                        builder: (context, tokenMember, child) {
                          return Text(
                              tokenMember.member?.fullName ?? 'no user');
                        },
                      ),
                      //boards
                      Consumer<Boards>(
                        builder: (context, boards, child) {
                          return Text('${boards.boards.length} boards');
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: DebugScreenOrganizations(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DebugScreenOrganizations extends StatelessWidget {
  const DebugScreenOrganizations({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Organizations>(
      builder: (context, organizations, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('${organizations.organizations.length} organizations'),
            //organizations name and boards name
            for (var organization in organizations.organizations)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(organization.name),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    //passing organization id to DebugScreenOrganizationsBoards
                    child: DebugScreenOrganizationsBoards(
                        organizationId: organization.id),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class DebugScreenOrganizationsBoards extends StatelessWidget {
  final String organizationId;

  const DebugScreenOrganizationsBoards(
      {super.key, required this.organizationId});

  @override
  Widget build(BuildContext context) {
    return Consumer<Boards>(
      builder: (context, boards, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var board
                in boards.boardsByOrganizationId[organizationId] ?? [])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(board.name),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    //passing board id to DebugScreenBoardsLists
                    child: DebugScreenBoardsLists(boardId: board.id),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class DebugScreenBoardsLists extends StatelessWidget {
  final String boardId;

  const DebugScreenBoardsLists({super.key, required this.boardId});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrelloLists>(
      builder: (context, trelloLists, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            for (var list in trelloLists.listsByBoardId[boardId] ?? [])
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(list.name),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    //passing list id to DebugScreenListsCards
                    child: DebugScreenListsCards(listId: list.id),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class DebugScreenListsCards extends StatelessWidget {
  final String listId;

  const DebugScreenListsCards({super.key, required this.listId});

  @override
  Widget build(BuildContext context) {
    return Consumer<Cards>(
      builder: (context, cards, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var card in cards.cardsByListId[listId] ?? []) Text(card.name),
          ],
        );
      },
    );
  }
}
