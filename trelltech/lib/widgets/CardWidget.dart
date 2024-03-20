import 'package:flutter/material.dart';
import 'package:trelltech/data/Repository.dart';

import '../data/entities/CardEntity.dart';

class CardWidget extends StatelessWidget {
  final CardEntity cardEntity;
  final VoidCallback deleteCallback;

  const CardWidget(
      {super.key, required this.cardEntity, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<CardEntity>(
      data: cardEntity,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: Text(cardEntity.name!),
      child: Column(children: [
        Text(cardEntity.name!),
        ElevatedButton(
          onPressed: () async {
            await Repository.Card.delete(cardEntity);
            deleteCallback();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.yellow,
          ).copyWith(
            minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.0)),
          ),
          child: Text("Delete"),
        )
      ])
    );
  }
}
