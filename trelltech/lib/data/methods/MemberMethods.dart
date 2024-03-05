import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/entities/MemberEntity.dart';

class MemberMethods {
  Future<MemberEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => MemberEntity(id: "idmember", username: "username"));
  }

  Future<void> update(MemberEntity memberEntity) {
    return Future(() => null);
  }

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
