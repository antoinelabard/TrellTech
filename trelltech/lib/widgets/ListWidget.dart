import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trelltech/widgets/CardWidget.dart';

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
                          return CardWidget(cardEntity: card);
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
