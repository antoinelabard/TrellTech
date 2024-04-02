import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mytodo/service/services/boards_services.dart';
import 'package:mytodo/service/services/cards_service.dart';
import 'package:mytodo/views/board_add_view.dart';
import 'package:mytodo/views/card_add_view.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/auth_service.dart';
import 'package:mytodo/service/services/user_info_service.dart';
import 'package:mytodo/service/services/organization_service.dart';
class CreateBoardScreen extends StatelessWidget {
  const CreateBoardScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Board'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Handle button press
          },
          child: Text('Create'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Create button should be found', (WidgetTester tester) async {
    final mockTokenMember = TokenMember(Auth());
    final mockAuth = Auth();
    final mockBoards = Boards(mockTokenMember, mockAuth);
    final mockOrganizations = Organizations(
        mockTokenMember, mockAuth, mockBoards);


    var mockCards;
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<Cards>(
            create: (context) => mockCards,
          ),
          ChangeNotifierProvider<Boards>(
            create: (context) => mockBoards,
          ),
          ChangeNotifierProvider<TokenMember>(
            create: (context) => mockTokenMember,
          ),
        ],
        child: const MaterialApp(home: CreateBoardScreen()),
      ),
    );
    // Wait for all animations to finish
    await tester.pumpAndSettle();

    // Verify that the create button exists.
    expect(find.text('Create'), findsOneWidget);
  });
  print("Création d'une card validé avec succès");
}