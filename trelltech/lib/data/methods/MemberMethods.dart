import 'package:trelltech/data/entities/MemberEntity.dart';

class MemberMethods {
  Future<MemberEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => MemberEntity(id: "idmember", username: "username"));
  }

  Future<void> create(MemberEntity memberEntity) {
    return Future(() => null);
  }

  Future<void> update(MemberEntity memberEntity) {
    return Future(() => null);
  }

  Future<void> delete(MemberEntity memberEntity) {
    return Future(() => null);
  }
}
