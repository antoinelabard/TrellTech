import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';
import 'package:trelltech/data/entities/OrganizationEntity.dart';

class OrganizationMethods {
  Future<OrganizationEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
            OrganizationEntity(id: "idorga1", displayName: "displaynameorga1"));
  }

  Future<List<MemberEntity>> getMembers(OrganizationEntity organizationEntity) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          MemberEntity(id: "idmember1", username: "username1"),
          MemberEntity(id: "idmember2", username: "username2"),
          MemberEntity(id: "idmember3", username: "username3")
        ]);
  }

  Future<List<BoardEntity>> getBoards(OrganizationEntity organizationEntity) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          BoardEntity(id: "idboard1", name: "name122", idOrganization: "idorga1"),
          BoardEntity(id: "idboard2", name: "name2", idOrganization: "idorga1"),
          BoardEntity(id: "idboard3", name: "name3", idOrganization: "idorga1"),
        ]);
  }

  Future<List<OrganizationEntity>> getJoinedOrganizations(MemberEntity memberEntity) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          OrganizationEntity(id: "idorga1", displayName: "displaynameorga1"),
        ]);
  }

  Future<void> create(OrganizationEntity organizationEntity) {
    return Future(() => null);
  }

  Future<void> update(OrganizationEntity organizationEntity) {
    return Future(() => null);
  }

  Future<void> delete(OrganizationEntity organizationEntity) {
    return Future(() => null);
  }
}