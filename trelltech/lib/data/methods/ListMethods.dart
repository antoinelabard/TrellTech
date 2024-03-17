import 'package:trelltech/data/entities/CardEntity.dart';
import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import 'dart:convert';
import '../entities/BoardEntity.dart';

class ListMethods {
  Future<ListEntity> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-list/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((list) => ListEntity.fromJson(list));
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
