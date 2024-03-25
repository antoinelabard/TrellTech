import 'package:flutter/material.dart';
import 'package:trelltech/widgets/CardWidget.dart';

import '../data/Repository.dart';
import '../data/entities/CardEntity.dart';
import '../data/entities/ListEntity.dart';

class ListWidget extends StatefulWidget {
  final ListEntity listEntity;

  ListWidget({super.key, required this.listEntity});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<CardEntity> cards = [];
  final TextEditingController _newCardController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Repository.List.getCards(widget.listEntity.id!),
      builder: (context, AsyncSnapshot<List<CardEntity>> cardSnapshot) {
        if (cardSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (cardSnapshot.hasError) {
          return Text('Erreur de chargement des cartes');
        } else {
          cardSnapshot.data?.forEach((element) {
            cards.add(element);
          });
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(title: Text(widget.listEntity.name!)),
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      itemCount: cards.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => CardWidget(
                          cardEntity: cards[index],
                          deleteCallback: () => removeCard(cards[index]))),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: _newCardController,
                        // decoration: const InputDecoration(hintText: 'New List Name'),
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Add List'),
                      onPressed: () {
                        Repository.Card.create(CardEntity(
                            idBoard: widget.listEntity.idBoard!,
                            idList: widget.listEntity.id!,
                            name: _newCardController.text));
                        _newCardController.clear();
                      },
                    ),
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }

  void removeCard(CardEntity card) {
    setState(() {
      cards.remove(card);
    });
  }
}
