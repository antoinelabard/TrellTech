import 'package:trelltech/data/entities/CardEntity.dart';

class CardMethods {
  Future<CardEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => CardEntity(
            id: "id", closed: false, dateLastActivity: DateTime.now()));
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
}
