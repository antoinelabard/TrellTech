import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import '../entities/BoardEntity.dart';

class BoardMethods {
  Future<dynamic> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-board/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((board) => BoardEntity.fromJson(board));
  }

  Future<List<MemberEntity>> getMembers(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          MemberEntity(id: "idmember1", username: "username1"),
          MemberEntity(id: "idmember2", username: "username2"),
          MemberEntity(id: "idmember3", username: "username3")
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
            () =>
        [
          ListEntity(id: "idlist1", idBoard: "idBoard", name: "listName1"),
          ListEntity(id: "idlist2", idBoard: "idBoard", name: "listName2"),
          ListEntity(id: "idlist3", idBoard: "idBoard", name: "listName3")
        ]);
  }
}