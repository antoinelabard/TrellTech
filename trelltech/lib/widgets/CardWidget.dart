import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/entities/CardEntity.dart';

class CardWidget extends StatelessWidget {
  final CardEntity cardEntity;

  const CardWidget({super.key, required this.cardEntity});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(cardEntity.name!),
      ElevatedButton(
        onPressed: () {
          // Ajoutez le code à exécuter lorsque le bouton de la carte est pressé
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.yellow,
        ).copyWith(
          minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.0)),
        ),
        child: Text("Rename"),
      ),
      ElevatedButton(
      onPressed: () {
        // Ajoutez le code à exécuter lorsque le bouton de la carte est pressé
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow,
      ).copyWith(
        minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.0)),
      ),
      child: Text("Delete"),
    )]);
  }
}
