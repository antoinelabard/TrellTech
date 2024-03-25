import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';

import '../Repository.dart';
import 'package:http/http.dart' as http;

class MemberMethods {
  Future<MemberEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => MemberEntity(id: "idmember", username: "username"));
  }

  Future<void> update(MemberEntity memberEntity) {
    var id = memberEntity.id ?? "";
    return http.put(
        Uri.parse(Repository.SERVER_ADDRESS + '/update-board/' + id),
        body: memberEntity.toJson());  }

  Future<List<BoardEntity>> getBoards(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
        [
          BoardEntity(id: "idBoard1", name: "nameBoard1", idOrganization: "idOrga"),
          BoardEntity(id: "idBoard2", name: "nameBoard2", idOrganization: "idOrga"),
          BoardEntity(id: "idBoard3", name: "nameBoard3", idOrganization: "idOrga")
        ]);
  }

  Future<void> removeFromOrganisation(String id) {
    return Future(() => null);
  }
}
