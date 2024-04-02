import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytodo/views/board_view.dart';
import 'package:mytodo/views/card_view.dart';
import 'package:mytodo/views/board_add_view.dart';
import 'package:mytodo/views/card_add_view.dart';
import 'package:mytodo/views/list_add_view.dart';
import 'package:mytodo/views/workspace_add_view.dart';
import 'package:mytodo/views/board_update_view.dart';
import 'package:mytodo/views/card_update_view.dart';
import 'package:mytodo/views/list_update_view.dart';
import 'package:mytodo/views/workspace_update_view.dart';
import 'package:mytodo/views/list_view.dart';
import 'package:mytodo/views/workspace_view.dart';
import 'package:mytodo/views/worskpace_all_view.dart';

import 'debug.dart';
import 'debug_detail.dart';
import '../views/home_view.dart';

/// The route configuration.
final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'debug',
          builder: (BuildContext context, GoRouterState state) {
            return const DebugScreen();
          },
        ),
        GoRoute(
          path: 'details',
          builder: (BuildContext context, GoRouterState state) {
            return const DetailsScreen();
          },
        ),
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const OrgsAndBoardsListScreens();
          },
        ),
        GoRoute(
          path: 'create-workspace',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateWorkspaceScreen();
          },
        ),
        GoRoute(
          name: 'org',
          path: 'org/:orgId',
          builder: (BuildContext context, GoRouterState state) {
            return OrganizationScreen(orgId: state.pathParameters['orgId']);
          },
        ),
        GoRoute(
          path: 'create-board',
          builder: (BuildContext context, GoRouterState state) {
            return const CreateBoardScreen();
          },
        ),
        GoRoute(
          path: 'board/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return BoardScreen(boardId: state.pathParameters['boardId']);
          },
        ),
        GoRoute(
          path: 'edit-organization/:orgId',
          builder: (BuildContext context, GoRouterState state) {
            return EditOrganizationScreen(orgId: state.pathParameters['orgId']
            );
          },
        ),
        GoRoute(
          path: 'edit-board/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return EditBoardScreen(boardId: state.pathParameters['boardId']!);
          },
        ),
        GoRoute(
          path: 'list/:listId',
          builder: (BuildContext context, GoRouterState state) {
            return ListScreen(listId: state.pathParameters['listId']!);
          },
        ),
        GoRoute(
          path: 'create-list/:boardId',
          builder: (BuildContext context, GoRouterState state) {
            return CreateListScreen(boardId: state.pathParameters['boardId']!);
          },
        ),
        GoRoute(
          path: 'edit-list/:listId',
          builder: (BuildContext context, GoRouterState state) {
            return EditListScreen(listId: state.pathParameters['listId']!);
          },
        ),
        GoRoute(
          path: 'card/:cardId',
          builder: (BuildContext context, GoRouterState state) {
            return CardScreen(cardId: state.pathParameters['cardId']!);
          },
        ),
        GoRoute(
            path: 'create-card/:listId',
            builder: (BuildContext context, GoRouterState state) {
              return CreateCardScreen(listId: state.pathParameters['listId']!);
            }
        ),
        GoRoute(
          path: 'edit-card/:cardId',
          builder: (BuildContext context, GoRouterState state) {
            return EditCardScreen(cardId: state.pathParameters['cardId']!);
          },
        )
      ],
    ),
  ],
);
