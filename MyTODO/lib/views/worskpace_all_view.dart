// Importation des packages nécessaires
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/board_list.dart';
import 'package:mytodo/components/orgs_list.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';

// Définition de la classe OrgsAndBoardsListScreens qui est un StatelessWidget
class OrgsAndBoardsListScreens extends StatelessWidget{
  // Constructeur de la classe OrgsAndBoardsListScreens
  const OrgsAndBoardsListScreens({super.key});

  // Méthode pour construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application personnalisée
      appBar: AppBarComponent(),
      // Corps de l'écran
      body: SingleChildScrollView(
          primary: true,
          padding: const EdgeInsets.only(top: 16, bottom: 24),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Titre de la section "Organizations"
                const TitleComponent(text: "Espaces de travail"),
                // Liste des organisations
                const OrganizationsList(),
                // Bouton pour créer un nouvel espace de travail
                Button(
                    text: 'Créer un espace ed travail',
                    iconName: Icons.add,
                    onPressed: (){
                      // Navigation vers la page de création d'un espace de travail
                      context.go('/create-workspace');
                    }
                ),
                // Titre de la section "Boards"
                const TitleComponent(text: 'Tableaux'),
                // Liste des tableaux
                const BoardsList(),
                // Bouton pour créer un nouveau tableau
                Button(
                    text: 'Créer un tableaux',
                    iconName: Icons.add,
                    onPressed: (){
                      // Navigation vers la page de création d'un tableau
                      context.go('/create-board');
                    }
                ),
              ]
          )
      ),
      // Barre de navigation en bas de l'écran
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}