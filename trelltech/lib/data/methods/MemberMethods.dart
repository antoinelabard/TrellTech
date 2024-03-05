import 'package:trelltech/data/entities/MemberEntity.dart';

class MemberMethods {
  Future<MemberEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => MemberEntity(id: "idmember", username: "username"));
  }

  Future<void> create(String id, String username) {
    return Future(() => null);
  }

  Future<void> update(String id, String username) {
    return Future(() => null);
  }

  Future<void> delete(String id) {
    return Future(() => null);
  }
}
