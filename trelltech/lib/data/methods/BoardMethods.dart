import 'package:trelltech/data/entities/ListEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';

import '../entities/BoardEntity.dart';

class BoardMethods {
  Future<BoardEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
            BoardEntity(id: "idboard", name: "name", idOrganization: "idorga"));
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