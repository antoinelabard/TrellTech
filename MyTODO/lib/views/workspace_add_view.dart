// Dépendances
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:mytodo/service/services/organization_service.dart';
import 'package:mytodo/components/checkbox.dart';
import 'package:mytodo/components/navbar.dart';
import 'package:mytodo/components/appbar.dart';
import 'package:mytodo/components/button.dart';
import 'package:mytodo/components/titles.dart';
import 'package:mytodo/components/text_input.dart';

// Définition de la classe CreateWorkspaceScreen qui est un StatefulWidget
class CreateWorkspaceScreen extends StatefulWidget {
  const CreateWorkspaceScreen({super.key});

  // Création de l'état de l'écran
  @override
  CreateWorkspaceScreenState createState() {
    return CreateWorkspaceScreenState();
  }
}

// Définition de l'état de l'écran
class CreateWorkspaceScreenState extends State<CreateWorkspaceScreen>{
  // Déclaration des variables d'état
  bool isChecked = false;
  String name = '';
  String? workspaceDesc;
  String error = '';

  // Méthode pour valider le formulaire
  void validateForm(name, workspaceDesc){
    // Vérification des champs du formulaire
    if(name == '' || workspaceDesc == ''){
      // Mise à jour de l'état en cas d'erreur
      setState(() {
        error = 'Veuillez remplir le formulaire';
      });
      return;
    }
    // Création de l'organisation si le formulaire est valide
    context
        .read<Organizations>()
        .createOrganization(displayName: name, desc: workspaceDesc).then(
        context.go('/home')
    );
  }

  // Méthode pour construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'application personnalisée
      appBar: AppBarComponent(),
      // Corps de l'écran
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Titre de l'écran
              const TitleComponent(text: 'Créer un espace de travail'),
              // Champ de texte pour le nom
              TextComponent(
                  name: 'Name',
                  onTextChanged: (String value) => {
                    setState(() {
                      name = value;
                    })
                  }),
              // Champ de texte pour la description
              TextComponent(
                  name: 'Description',
                  onTextChanged: (String value) => {
                    setState(() {
                      workspaceDesc = value;
                    })
                  }),
              // Ligne pour le choix de la visibilité
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Public :', style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14
                  ),
                  ),
                  // Checkbox pour le choix de la visibilité
                  CheckComponent(
                      value: isChecked,
                      onChanged: (bool? value)=> {
                        setState(() {
                          isChecked = value!;
                        }),
                      })
                ],
              ),
              // Ligne pour les boutons d'action
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bouton pour créer l'espace de travail
                  Button(
                      text: 'Créer',
                      iconName: Icons.add,
                      onPressed: () => {
                        validateForm(name, workspaceDesc),
                      }
                  ),
                  // Bouton pour revenir à l'écran précédent
                  Container(
                    margin: const EdgeInsets.only(left: 16),
                    child: TextButton(
                      onPressed: () => {
                        context.go('/home'),
                      },
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 14, vertical: 18)),
                        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                        )),
                        backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.arrow_back_ios, color: Colors.white,),
                          Text('Retour',
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: Colors.white
                            ),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
              // Affichage du message d'erreur
              Text(
                error,
                style: const TextStyle(
                  fontFamily: 'Roboto',
                  color: Colors.redAccent,
                ),
              )
            ],
          ),
        ),
      ),
      // Barre de navigation en bas de l'écran
      bottomNavigationBar: const NavigationBarComponent(),
    );
  }
}
