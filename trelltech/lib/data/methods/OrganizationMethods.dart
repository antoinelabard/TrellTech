import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';
import 'package:trelltech/data/entities/OrganizationEntity.dart';

class OrganizationMethods {
  Future<OrganizationEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
            OrganizationEntity(id: "idorga", displayName: "displaynameorga"));
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

  Future<List<BoardEntity>> getBoards(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          BoardEntity(id: "idboard1", name: "name1", idOrganization: "idorga"),
          BoardEntity(id: "idboard2", name: "name2", idOrganization: "idorga"),
          BoardEntity(id: "idboard3", name: "name3", idOrganization: "idorga"),
        ]);
  }

  Future<void> create(OrganizationEntity) {
    return Future(() => null);
  }

  Future<void> update(OrganizationEntity) {
    return Future(() => null);
  }

  Future<void> delete(OrganizationEntity) {
    return Future(() => null);
  }
}