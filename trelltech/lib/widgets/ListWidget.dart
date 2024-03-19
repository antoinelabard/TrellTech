import 'package:flutter/material.dart';
import 'package:trelltech/widgets/CardWidget.dart';

import '../data/Repository.dart';
import '../data/entities/CardEntity.dart';
import '../data/entities/ListEntity.dart';

/*
create a list of CardWidget that can expand vertically to fit the content
 */

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
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                    title: Text(listEntity.name! +
                        cardSnapshot.data!.length.toString() +
                        " cards")),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      itemCount: cardSnapshot.data?.length ?? 0,
                      shrinkWrap: true,
                      // physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) =>
                          CardWidget(cardEntity: cardSnapshot.data![index])),
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
          );
        }
      },
    );
  }
}
