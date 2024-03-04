import '../entities/BoardEntity.dart';

class BoardMethods {
  Future<BoardEntity> getBoard(String id) {
    return Future.delayed(
        Duration(seconds: 1),
            () =>
            BoardEntity(id: "idboard", name: "name", idOrganization: "idorga"));
  }
}