import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/ListEntity.dart';

import '../entities/BoardEntity.dart';

class BoardMethods {
  Future<dynamic> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-board/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((board) => BoardEntity.fromJson(board));
  }

  Future<List<dynamic>> getMembers(BoardEntity boardEntity) {
    var id = boardEntity.id ?? "";
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-members/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((members) =>
            members.map((member) => BoardEntity.fromJson(member)).toList());
  }

  Future<void> create(BoardEntity boardEntity) {
    return http.post(
        Uri.parse(Repository.SERVER_ADDRESS + '/create-board'),
        body: boardEntity.toJson());
  }

  Future<void> update(BoardEntity boardEntity) {
    var id = boardEntity.id ?? "";
    return http.put(
        Uri.parse(Repository.SERVER_ADDRESS + '/update-board/' + id),
        body: boardEntity.toJson());
  }

  Future<void> delete(BoardEntity boardEntity) {
    var id = boardEntity.id ?? "";
    return http.delete(
        Uri.parse(Repository.SERVER_ADDRESS + '/delete-board/' + id),
        body: boardEntity.toJson());
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
