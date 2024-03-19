import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/Repository.dart';
import '../data/entities/CardEntity.dart';
import '../data/entities/ListEntity.dart';

class ListWidget extends StatelessWidget {
  final ListEntity listEntity;

  ListWidget({super.key, required this.listEntity});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.List.getCards(listEntity.id!),
      builder: (context, AsyncSnapshot<List<CardEntity>> cardSnapshot) {
        if (cardSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (cardSnapshot.hasError) {
          return Text('Erreur de chargement des cartes');
        } else {
          return Expanded(
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: Text(listEntity.name!),
                  ),
                  Column(
                    children: cardSnapshot.data?.map((card) {
                          return ElevatedButton(
                            onPressed: () {
                              // Ajoutez le code à exécuter lorsque le bouton de la carte est pressé
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                            ).copyWith(
                              minimumSize: MaterialStateProperty.all(
                                  Size(double.infinity, 48.0)),
                            ),
                            child: Text(card.name!),
                          );
                        }).toList() ??
                        [],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Repository.List.getCards(listEntity.id!);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text('Add Card'),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
