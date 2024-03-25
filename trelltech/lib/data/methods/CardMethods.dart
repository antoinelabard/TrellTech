import 'package:http/http.dart' as http;
import 'package:trelltech/data/entities/CardEntity.dart';

import '../Repository.dart';

class CardMethods {
  Future<CardEntity> get(String id) {
    return Future.delayed(
        Duration(seconds: 1),
        () => CardEntity(
            id: "id", closed: false, dateLastActivity: DateTime.now()));
  }

  Future<void> create(CardEntity cardEntity) {
    return http.post(Uri.parse(Repository.SERVER_ADDRESS + '/create-card'),
        body: cardEntity.toJson());
  }

  Future<void> update(CardEntity cardEntity) {
    var id = cardEntity.id ?? "";
    return http.put(
        Uri.parse(Repository.SERVER_ADDRESS + '/update-card/' + id),
        body: cardEntity.toJson());
  }

  Future<void> delete(CardEntity cardEntity) {
    var id = cardEntity.id ?? "";
    return http.delete(
        Uri.parse(Repository.SERVER_ADDRESS + '/delete-card/' + id),
        body: cardEntity.toJson());
  }
}
