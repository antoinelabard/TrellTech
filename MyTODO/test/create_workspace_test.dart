import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mytodo/service/services/user_info_service.dart';
import 'package:mytodo/views/workspace_add_view.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/auth_service.dart';

void main() {
  testWidgets("Création d'un workspace", (WidgetTester tester) async {
    final mockAuth = Auth();
    final mockTokenMember = TokenMember(mockAuth);

    await tester.pumpWidget(
      ChangeNotifierProvider<TokenMember>(
        create: (context) => mockTokenMember,
        child: const MaterialApp(home: CreateWorkspaceScreen()),
      ),
    );

    print('Création d\'un workspace avec succès');
  });
}