import 'package:trelltech/data/entities/CardEntity.dart';
import 'package:trelltech/data/entities/ListEntity.dart';

import '../entities/BoardEntity.dart';

class ListMethods {
  Future<ListEntity> get(String id) {
    return Future.delayed(Duration(seconds: 1),
        () => ListEntity(id: "idEntity", idBoard: "idBoard", name: "listName"));
  }

  Future<List<CardEntity>> getCards(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => [
              CardEntity(
                  id: "idCard1",
                  closed: false,
                  dateLastActivity: DateTime.now(),
                  due: DateTime.now(),
                  idBoard: "idBoard",
                  idList: "idList",
                  name: "CardName1"),
              CardEntity(
                  id: "idCard2",
                  closed: false,
                  dateLastActivity: DateTime.now(),
                  due: DateTime.now(),
                  idBoard: "idBoard",
                  idList: "idList",
                  name: "CardName2"),
              CardEntity(
                  id: "idCard3",
                  closed: false,
                  dateLastActivity: DateTime.now(),
                  due: DateTime.now(),
                  idBoard: "idBoard",
                  idList: "idList",
                  name: "CardName3")
            ]);
  }

  Future<void> create(BoardEntity boardEntity) {
    return Future(() => null);
  }

  Future<void> update(BoardEntity boardEntity) {
    return Future(() => null);
  }

  Future<void> delete(BoardEntity boardEntity) {
    return Future(() => null);
  }

  Future<List<ListEntity>> getLists(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => [
              ListEntity(id: "idlist1", idBoard: "idBoard", name: "listName1"),
              ListEntity(id: "idlist2", idBoard: "idBoard", name: "listName2"),
              ListEntity(id: "idlist3", idBoard: "idBoard", name: "listName3")
            ]);
  }
}
