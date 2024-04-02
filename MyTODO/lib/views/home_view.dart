// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/auth_service.dart';
import 'package:mytodo/components/button.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Définition de la classe HomeScreen qui est un StatelessWidget
class HomeScreen extends StatelessWidget {
  // Constructeur de la classe
  const HomeScreen({super.key});

  // Méthode de construction de l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application avec le titre
      body: Center(
        child: Column(
          // Alignement des widgets dans la colonne
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Widget pour détecter un double tap
            GestureDetector(
              onDoubleTap: () => {
                // Navigation vers la page de débogage
                context.go('/debug'),
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.blue,
                  ),
                  SizedBox(width: 10), // Espace entre l'icône et le texte
                  Text(
                    'MyTODO',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            // Boîte de taille fractionnée pour le texte
            const FractionallySizedBox(
              widthFactor: 0.8,
              child: Text(
                'Bienvue sur MyTODO, l\'application qui vous aide à gérer vos tâches. Connectez-vous avec votre compte Trello pour commencer.',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 18,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 60),  // Boîte de taille fractionnée pour le bouton personnalisé
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Button(
                iconName: Icons.looks,
                text: "Connexion avec Trello",
                onPressed: () =>
                // Lecture du service d'authentification et inscription
                context.read<Auth>().signUp().then((webView) => {
                  // Navigation vers la page d'inscription
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        backgroundColor: Colors.blue,
                        appBar: AppBar(
                            title: const Text('Trello Sign-up')),
                        // Affichage de la page web dans l'application
                        body: WebViewWidget(controller: webView),
                      ),
                    ),
                  ),
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}