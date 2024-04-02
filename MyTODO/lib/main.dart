// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'service/_router.dart';

import 'service/services/auth_service.dart';
import 'service/services/cards_service.dart';
import 'service/services/user_info_service.dart';
import 'service/services/boards_services.dart';
import 'service/services/organization_service.dart';
import 'service/services/lists_service.dart';
import 'service/services/members_service.dart';

/// Le point d'entrée principal de l'application.
void main() {
  runApp(
    MultiProvider(
      providers: [
    // Fournit une instance de Auth à l'arbre de widgets
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, TokenMember>(
          create: (context) => TokenMember(context.read<Auth>()),
          update: (context, auth, userInfo) {
            userInfo = userInfo ?? TokenMember(auth);
            userInfo.authUpdate(auth);
            return userInfo;
          },
        ),
        ChangeNotifierProxyProvider<TokenMember, Boards>(
          create: (context) =>
              Boards(context.read<TokenMember>(), context.read<Auth>()),
          update: (context, tokenMember, boards) {
            boards = boards ?? Boards(tokenMember, context.read<Auth>());
            boards.update();
            return boards;
          },
        ),
        ChangeNotifierProxyProvider3<Auth, TokenMember, Boards, Organizations>(
          create: (context) => Organizations(context.read<TokenMember>(),
              context.read<Auth>(), context.read<Boards>()),
          update: (context, auth, tokenMember, boards, organizations) {
            organizations =
                organizations ?? Organizations(tokenMember, auth, boards);
            organizations.update();
            return organizations;
          },
        ),
        ChangeNotifierProxyProvider2<Auth, Boards, TrelloLists>(
          create: (context) =>
              TrelloLists(context.read<Auth>(), context.read<Boards>()),
          update: (context, auth, boards, trelloLists) {
            trelloLists = trelloLists ?? TrelloLists(auth, boards);
            trelloLists.update();
            return trelloLists;
          },
        ),
        ChangeNotifierProxyProvider2<Auth, Boards, Cards>(
          create: (context) =>
              Cards(context.read<Auth>(), context.read<Boards>()),
          update: (context, auth, boards, cards) {
            cards = cards ?? Cards(auth, boards);
            cards.update();
            return cards;
          },
        ),
        ChangeNotifierProxyProvider3<Auth, Organizations, Boards, Members>(
          create: (context) => Members(context.read<Auth>(),
              context.read<Organizations>(), context.read<Boards>()),
          update: (context, auth, organizations, boards, members) {
            members = members ?? Members(auth, organizations, boards);
            members.update();
            return members;
          },
        ),
      ],
      child: const MyApp(),
    ),
  );
}

/// L'application principale
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
