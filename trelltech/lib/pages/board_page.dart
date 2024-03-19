import 'package:flutter/material.dart';
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:trelltech/widgets/ListWidget.dart';

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

                return ListWidget(listEntity: listEntity);
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
