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

  Future<void> create(String id) {
    return Future(() => null);
  }

  Future<void> update(String id) {
    return Future(() => null);
  }

  Future<void> delete(String id) {
    return Future(() => null);
  }
