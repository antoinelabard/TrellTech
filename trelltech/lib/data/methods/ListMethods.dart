import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trelltech/data/Repository.dart';
import 'package:trelltech/data/entities/CardEntity.dart';
import 'package:trelltech/data/entities/ListEntity.dart';

class ListMethods {
  Future<dynamic> get(String id) {
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-list/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then((list) => ListEntity.fromJson(list));
  }

  Future<List<dynamic>> getCards(ListEntity listEntity) {
    var id = listEntity.id ?? "";
    return http
        .get(Uri.parse(Repository.SERVER_ADDRESS + '/get-cards/' + id))
        .then((res) => res.body)
        .then((data) => json.decode(data))
        .then(
            (cards) => cards.map((card) => CardEntity.fromJson(card)).toList());
  }

  Future<void> create(ListEntity listEntity) {
    return http.post(Uri.parse(Repository.SERVER_ADDRESS + '/create-list'),
        body: listEntity.toJson());
  }

  Future<void> update(ListEntity listEntity) {
    var id = listEntity.id ?? "";
    return http.put(
        Uri.parse(Repository.SERVER_ADDRESS + '/update-list/' + id),
        body: listEntity.toJson());
  }

  Future<void> delete(ListEntity listEntity) {
    var id = listEntity.id ?? "";
    return http.delete(
        Uri.parse(Repository.SERVER_ADDRESS + '/delete-list/' + id),
        body: listEntity.toJson());
  }
}
