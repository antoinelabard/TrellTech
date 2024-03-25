import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:trelltech/widgets/ListWidget.dart';

import '../data/entities/BoardEntity.dart';

class BoardDetailPage extends StatefulWidget {
  final BoardEntity boardEntity;

  BoardDetailPage({required this.boardEntity});

  @override
  _BoardDetailPageState createState() => _BoardDetailPageState();
}

class _BoardDetailPageState extends State<BoardDetailPage> {
  final TextEditingController _newListController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.boardEntity.name ?? "Unknown board"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: _newListController,
                  // decoration: const InputDecoration(hintText: 'New List Name'),
                ),
              ),
              ElevatedButton(
                child: Text('Add List'),
                onPressed: () {
                  Repository.List.create(ListEntity(
                      idBoard: widget.boardEntity.id!,
                      name: _newListController.text));
                },
              ),
            ],
          ),
          FutureBuilder(
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
        ],
      ),
    );
  }
}
