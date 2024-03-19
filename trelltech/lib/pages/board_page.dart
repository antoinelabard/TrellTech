import 'package:flutter/material.dart';
import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:trelltech/data/entities/CardEntity.dart';
import 'package:trelltech/data/methods/ListMethods.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BoardDetailPage extends StatefulWidget {
  final String boardName;
  final ListMethods listMethods = ListMethods();

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
        future: widget.listMethods.getLists("boardId"),
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
                  future: widget.listMethods.getCards(listEntity.id!),
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
                                      minimumSize: MaterialStateProperty.all(Size(double.infinity, 48.0)),
                                    ),
                                    child: Text(card.name!),
                                  );
                                }).toList() ?? [],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _addCardToList(listEntity.id!);
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

  Future<void> _addCardToList(String listId) async {
    List<CardEntity> cards = await widget.listMethods.getCards(listId);
  }
}
