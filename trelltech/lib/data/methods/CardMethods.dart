import 'package:trelltech/data/entities/CardEntity.dart';

class CardMethods {
  Future<CardEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => CardEntity(
            id: "id", closed: false, dateLastActivity: DateTime.now()));
  }

  Future<void> create(CardEntity cardEntity) {
    return Future(() => null);
  }

  Future<void> update(CardEntity cardEntity) {
    return Future(() => null);
  }

  Future<void> delete(CardEntity cardEntity) {
    return Future(() => null);
  }
}
