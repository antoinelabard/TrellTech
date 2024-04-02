import 'package:flutter/material.dart';

// Définition de la classe Button qui hérite de TextButton
class Button extends TextButton {
  // Constructeur de la classe Button
  Button({
    super.key,
    required String text, // Texte à afficher sur le bouton
    required IconData? iconName, // Icône à afficher sur le bouton
    required VoidCallback super.onPressed, // Action à effectuer lors du clic sur le bouton
  }) : super(
    // Style du bouton
      style: ButtonStyle(
        // Couleur de fond du bouton
        backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(
            95, 150, 253, 1.0)),
        // Padding du bouton
        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 16, vertical: 20)),
        // Forme du bouton
        shape: MaterialStateProperty.all(const RoundedRectangleBorder(
        )),
      ),
      // Contenu du bouton
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Icône du bouton
          Icon(iconName, size: 20, color: const Color.fromRGBO(20, 25, 70, 1),),
          // Espace entre l'icône et le texte
          const SizedBox(width: 8),
          // Texte du bouton
          Text(text.toLowerCase(),
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
              )
          ),
        ],
      ));
}