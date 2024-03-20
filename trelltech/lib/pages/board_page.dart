import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:trelltech/widgets/ListWidget.dart';

import '../data/entities/CardEntity.dart';

class BoardDetailPage extends StatefulWidget {
  final String boardName;

  BoardDetailPage({required this.boardName});

  @override
  _BoardDetailPageState createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardName),
      ),
      body: FutureBuilder(
        future: Repository.List.getLists("boardId"),
        builder: (context, AsyncSnapshot<List<ListEntity>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erreur de chargement des listes');
          } else {
            return CarouselSlider.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index, realIndex) {
                ListEntity listEntity = snapshot.data![index];
                return FutureBuilder(
                  future: Repository.List.getCards(listEntity.id!),
                  builder:
                      (context, AsyncSnapshot<List<CardEntity>> cardSnapshot) {
                    if (cardSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (cardSnapshot.hasError) {
                      return Text('Erreur de chargement des cartes');
                    } else {
                      return ListWidget(
                        listEntity: listEntity,
                        cards: cardSnapshot.data ?? [],
                      );
                    }
                  },
                );
                ;
              },
              options: CarouselOptions(
                height: null,
                enableInfiniteScroll: false,
              ),
            );
          }
        },
      ),
    );
  }
}
