import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/service/services/auth_service.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/user_info_service.dart';
import 'package:mytodo/views/list_add_view.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/lists_service.dart';
import 'package:mockito/mockito.dart';

class MockTrelloLists extends Mock implements TrelloLists {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

void main() {
  testWidgets('Create list button should be found', (WidgetTester tester) async {
    final mockTrelloLists = MockTrelloLists();
    final mockTokenMember = TokenMember(Auth());
    final mockAuth = Auth();
    final mockBoards = Boards(mockTokenMember, mockAuth);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TrelloLists>(
            create: (context) => mockTrelloLists,
          ),
          ChangeNotifierProvider<Boards>(
            create: (context) => mockBoards,
          ),
          ChangeNotifierProvider<TokenMember>(
            create: (context) => mockTokenMember,
          ),
        ],
        child: const MaterialApp(home: CreateListScreen(boardId: 'testBoardId')),
      ),
    );

    // Wait for all animations to finish
    await tester.pumpAndSettle();

    // Verify that the create list button exists.
    expect(find.text('create list'), findsOneWidget);
  });
  print("Creation de la list validé avec succès");
}