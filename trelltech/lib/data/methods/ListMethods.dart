import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/CardEntity.dart';
import 'package:trelltech/data/entities/ListEntity.dart';

import '../entities/BoardEntity.dart';

class ListMethods {
  Future<dynamic> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-list/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((list) => ListEntity.fromJson(list));
  }

  Future<List<dynamic>> getCards(ListEntity listEntity) {
    var id = listEntity.id ?? "";
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-cards/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then(
            (cards) => cards.map((card) => CardEntity.fromJson(card)).toList());
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
