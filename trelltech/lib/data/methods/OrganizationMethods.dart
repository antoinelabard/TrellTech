import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';
import 'package:trelltech/data/entities/OrganizationEntity.dart';

class OrganizationMethods {
  Future<OrganizationEntity> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-organization/' + id))
        .then((res) => res.body)
        .then((organization) =>
            OrganizationEntity.fromJson(json.decode(organization)));
  }

  Future<List<dynamic>> getBoards(OrganizationEntity organizationEntity) {
    var id = organizationEntity.id ?? "";
    return http
        .get(Uri.parse(
            Repository.SERVER_ADDRESS + '/get-organization-boards/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((boards) =>
            boards.map((board) => BoardEntity.fromJson(board)).toList());
  }

  Future<List<dynamic>> getJoinedOrganizations() {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-all-organizations'))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((organizations) => organizations
            .map((organization) => OrganizationEntity.fromJson(organization))
            .toList());
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

// List<dynamic> getJoinedOrganizations() async {
//   var res = await http
//       .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-all-organizations'))
//       .then((res) => res.body)
//       .then((organizations) => json
//       .decode(organizations));
//   res.map((organization) => OrganizationEntity.fromJson(organization)).toList();
//   return res;
// }
