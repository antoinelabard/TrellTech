import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'services/auth_service.dart';

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LOGS VIEWS : TEST DES ROUTE')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Retour à la page d\'accueil'),
            ),
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
          ],
        ),
      ),
    );
  }
}
