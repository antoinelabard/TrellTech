import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'boards_services.dart';

class Cards with ChangeNotifier, DiagnosticableTreeMixin {
  final Auth _auth;
  final Boards _boards;

  List<Card> cards = [];
  Map<String, Card> cardsById = {};
  Map<String, List<Card>> cardsByListId = {};
  Map<String, List<Card>> cardsByBoardId = {};

  Cards(this._auth, this._boards) {
    update();
  }

  update() async {
    if (_auth.apiToken == null) {
      return;
    }
    // var requests = <Future>[];
    for (var board in _boards.boards) {
      // requests.add(
      await http.get(
        Uri.https("api.trello.com", "1/boards/${board.id}/cards"),
        headers: {
          'Authorization':
              'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
        },
      ).then(
        (response) {
          if (response.statusCode >= 400) {
            log(response.body);
            throw Exception(response.body);
          }

          final responseJson = jsonDecode(response.body) as List<dynamic>;

          //check if need update, create, delete
          for (var card in responseJson) {
            log(responseJson.toString());
            _updateData(card, board);
          }
        },
      );
    }
    // await Future.wait(requests);
    notifyListeners();
  }

  _updateData(Map<String, dynamic> card, Board board) {
    final index = cardsById.keys.toList().indexOf(card['id']);
    if (index == -1) {
      Card tmpCard = Card.fromJson(card, _auth, this);
      cards.add(tmpCard);
      cardsById[card['id']] = tmpCard;
      if (cardsByBoardId[board.id] == null) {
        cardsByBoardId[board.id] = [tmpCard];
      } else {
        //place in list by pos
        double pos = tmpCard.pos;
        List<Card> tmpCardList = cardsByBoardId[board.id]!;
        for (int i = 0; i < tmpCardList.length; i++) {
          if (pos < tmpCardList[i].pos) {
            tmpCardList.insert(i, tmpCard);
            break;
          }
        }
        //if not inserted, add to end
        if (!tmpCardList.contains(tmpCard)) {
          tmpCardList.add(tmpCard);
        }
      }
      if (cardsByListId[card['idList']] == null) {
        cardsByListId[card['idList']] = [tmpCard];
      } else {
        //place in list by pos
        double pos = tmpCard.pos;
        List<Card> tmpCardList = cardsByListId[card['idList']]!;
        for (int i = 0; i < tmpCardList.length; i++) {
          if (pos < tmpCardList[i].pos) {
            tmpCardList.insert(i, tmpCard);
            break;
          }
        }
        //if not inserted, add to end
        if (!tmpCardList.contains(tmpCard)) {
          tmpCardList.add(tmpCard);
        }
      }
    } else {
      //update board if needed
      if (cardsById[card['id']]?.idBoard != card['idBoard']) {
        cardsByBoardId[board.id]!.remove(cardsById[card['id']]);
        cardsByBoardId[card['idBoard']]!.add(cardsById[card['id']]!);
      }
      //update list if needed
      if (cardsById[card['id']]!.idList != card['idList']) {
        cardsByListId[cardsById[card['id']]!.idList]!
            .remove(cardsById[card['id']]!);
        cardsByListId[card['idList']]!.add(cardsById[card['id']]!);
      }
      cardsById[card['id']]!.updateData(card);
    }
  }

  createCard({
    required String idList,
    String? name,
    String? desc,
    double? pos,
    String? due,
    String? start,
    String? dueComplete,
    String? idMembers,
    String? idLabels,
    String? urlSource,
    String? fileSource,
    String? mimeType,
    String? idCardSource,
    String? keepFromSource,
    String? address,
    String? locationName,
    String? coordinates,
  }) {
    if (_auth.apiToken == null) {
      return;
    }

    Map<String, dynamic> queryParameters = {
      'idList': idList,
      'name': name,
      'desc': desc,
      'pos': pos,
      'due': due,
      'start': start,
      'dueComplete': dueComplete,
      'idMembers': idMembers,
      'idLabels': idLabels,
      'urlSource': urlSource,
      'fileSource': fileSource,
      'mimeType': mimeType,
      'idCardSource': idCardSource,
      'keepFromSource': keepFromSource,
      'address': address,
      'locationName': locationName,
      'coordinates': coordinates,
    };

    http.post(
      Uri.https("api.trello.com", "1/cards", queryParameters),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    ).then(
      (response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

        Card tmpCard = Card.fromJson(responseJson, _auth, this);
        _updateData(responseJson, _boards.boardsById[tmpCard.idBoard]!);
        notifyListeners();
      },
    );
  }
}

class Card {
  final String id;
  final Auth _auth;
  final Cards _cards;

  // List<Badge> badges;
  // List<dynamic> checkItemStates;
  bool closed;
  bool dueComplete;
  String dateLastActivity;
  String? desc;
  // String? descData;
  String? due;
  int? dueReminder;
  String? email;
  String idBoard;
  List<String>? idCheckLists;
  String idList;
  List<String>? idMembers;
  List<String> idMembersVoted;
  int idShort;
  String? idAttachmentCover;
  // List<Labels> labels;
  List<String> idLabels;
  bool manualCoverAttachment;
  String name;
  double pos;
  String shortLink;
  Uri? shortUrl;
  String? start;
  bool subscribed;
  Uri? url;
  // Cover? cover;
  bool isTemplate;
  String? cardRole;

  Card({
    required this.id,
    // required this.badges,
    // required this.checkItemStates,
    required this.closed,
    required this.dueComplete,
    required this.dateLastActivity,
    this.desc,
    // this.descData,
    this.due,
    this.dueReminder,
    this.email,
    required this.idBoard,
    this.idCheckLists,
    required this.idList,
    this.idMembers,
    required this.idMembersVoted,
    required this.idShort,
    this.idAttachmentCover,
    // required this.labels,
    required this.idLabels,
    required this.manualCoverAttachment,
    required this.name,
    required this.pos,
    required this.shortLink,
    this.shortUrl,
    this.start,
    required this.subscribed,
    this.url,
    // this.cover,
    required this.isTemplate,
    this.cardRole,
    required Auth auth,
    required Cards cards,
  })  : _auth = auth,
        _cards = cards;

  updateData(Map<String, dynamic> json) {
    bool update = false;

    // if (badges != json['badges']) {
    //   badges = json['badges'];
    //   update = true;
    // }
    // if (checkItemStates != json['checkItemStates']) {
    //   checkItemStates = json['checkItemStates'];
    //   update = true;
    // }
    if (closed != json['closed']) {
      closed = json['closed'];
      update = true;
    }
    if (dueComplete != json['dueComplete']) {
      dueComplete = json['dueComplete'];
      update = true;
    }
    if (dateLastActivity != json['dateLastActivity']) {
      dateLastActivity = json['dateLastActivity'];
      update = true;
    }
    if (desc != json['desc']) {
      desc = json['desc'];
      update = true;
    }
    // if (descData != json['descData']) {
    //   descData = json['descData'];
    //   update = true;
    // }
    if (due != json['due']) {
      due = json['due'];
      update = true;
    }
    if (dueReminder != json['dueReminder']) {
      dueReminder = json['dueReminder'];
      update = true;
    }
    if (email != json['email']) {
      email = json['email'];
      update = true;
    }
    if (idBoard != json['idBoard']) {
      idBoard = json['idBoard'];
      update = true;
    }
    if (idCheckLists != json['idCheckLists']) {
      idCheckLists = json['idCheckLists'];
      update = true;
    }
    if (idList != json['idList']) {
      idList = json['idList'];
      update = true;
    }
    if (idMembers != json['idMembers']) {
      idMembers = json['idMembers'].cast<String>();
      update = true;
    }
    if (idMembersVoted != json['idMembersVoted']) {
      idMembersVoted = json['idMembersVoted'].cast<String>();
      update = true;
    }
    if (idShort != json['idShort']) {
      idShort = json['idShort'];
      update = true;
    }
    if (idAttachmentCover != json['idAttachmentCover']) {
      idAttachmentCover = json['idAttachmentCover'];
      update = true;
    }

    //!TODO labels not implemented

    if (idLabels != json['idLabels']) {
      idLabels = json['idLabels'].cast<String>();
      update = true;
    }
    if (manualCoverAttachment != json['manualCoverAttachment']) {
      manualCoverAttachment = json['manualCoverAttachment'];
      update = true;
    }
    if (name != json['name']) {
      name = json['name'];
      update = true;
    }
    if (pos != json['pos']) {
      pos = json['pos'];
      update = true;
    }
    if (shortLink != json['shortLink']) {
      shortLink = json['shortLink'];
      update = true;
    }
    if (shortUrl != json['shortUrl']) {
      shortUrl = Uri.parse(json['shortUrl'] ?? "");
      update = true;
    }
    if (start != json['start']) {
      start = json['start'];
      update = true;
    }
    if (subscribed != json['subscribed']) {
      subscribed = json['subscribed'];
      update = true;
    }
    if (url != json['url']) {
      url = Uri.parse(json['url'] ?? "");
      update = true;
    }

    //!TODO cover not implemented

    if (isTemplate != json['isTemplate']) {
      isTemplate = json['isTemplate'];
      update = true;
    }
    if (cardRole != json['cardRole']) {
      cardRole = json['cardRole'];
      update = true;
    }

    if (update) {
      _cards.notifyListeners();
    }
  }

  factory Card.fromJson(Map<String, dynamic> json, Auth auth, Cards cards) {
    log("pls");
    log(json.toString());
    return Card(
      id: json['id'],
      // badges: json['badges'],
      // checkItemStates: json['checkItemStates'],
      closed: json['closed'],
      dueComplete: json['dueComplete'],
      dateLastActivity: json['dateLastActivity'],
      desc: json['desc'],
      // descData: json['descData'],
      due: json['due'],
      dueReminder: json['dueReminder'],
      email: json['email'],
      idBoard: json['idBoard'],
      idCheckLists: json['idCheckLists'],
      idList: json['idList'],
      idMembers: json['idMembers'].cast<String>(),
      // idMembers: [],
      idMembersVoted: json['idMembersVoted'].cast<String>(),
      idShort: json['idShort'],
      idAttachmentCover: json['idAttachmentCover'],
      idLabels: json['idLabels'].cast<String>(),
      manualCoverAttachment: json['manualCoverAttachment'],
      name: json['name'],
      pos: (json['pos'] ?? 0.0).toDouble(),
      shortLink: json['shortLink'],
      shortUrl: Uri.parse(json['shortUrl'] ?? ""),
      start: json['start'],
      subscribed: json['subscribed'],
      url: Uri.parse(json['url'] ?? ""),
      isTemplate: json['isTemplate'],
      cardRole: json['cardRole'],
      auth: auth,
      cards: cards,
    );
  }

  update({
    String? name,
    String? desc,
    bool? closed,
    String? idMembers,
    String? idAttachmentCover,
    String? idList,
    String? idLabels,
    String? idBoard,
    double? pos,
    String? due,
    String? start,
    String? dueComplete,
    String? subscribed,
    String? address,
    String? locationName,
    String? coordinates,
    String? cover,
  }) {
    if (_auth.apiToken == null) {
      return;
    }

    Map<String, dynamic> queryParameters = {
      if (name != null) 'name': name,
      if (desc != null) 'desc': desc,
      if (closed != null) 'closed': closed.toString(),
      if (idMembers != null) 'idMembers': idMembers,
      if (idAttachmentCover != null) 'idAttachmentCover': idAttachmentCover,
      if (idList != null) 'idList': idList,
      if (idLabels != null) 'idLabels': idLabels,
      if (idBoard != null) 'idBoard': idBoard,
      if (pos != null) 'pos': pos,
      if (due != null) 'due': due,
      if (start != null) 'start': start,
      if (dueComplete != null) 'dueComplete': dueComplete,
      if (subscribed != null) 'subscribed': subscribed,
      if (address != null) 'address': address,
      if (locationName != null) 'locationName': locationName,
      if (coordinates != null) 'coordinates': coordinates,
      if (cover != null) 'cover': cover,
    };

    http.put(
      Uri.https("api.trello.com", "1/cards/$id", queryParameters),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    ).then(
      (response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        final responseJson = jsonDecode(response.body) as Map<String, dynamic>;

        updateData(responseJson);

        _cards.update();
      },
    );
  }

  delete() {
    if (_auth.apiToken == null) {
      return;
    }

    http.delete(
      Uri.https("api.trello.com", "1/cards/$id"),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    ).then(
      (response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        _cards.cards.remove(this);
        _cards.cardsById.remove(id);
        _cards.cardsByListId[idList]!.remove(this);
        _cards.cardsByBoardId[idBoard]!.remove(this);
        _cards.notifyListeners();
        _cards.update();
      },
    );
  }

  addMember(String memberId) {
    if (_auth.apiToken == null) {
      return;
    }

    // {{protocol}}://{{host}}/{{basePath}}cards/:id/idMembers
    http.post(
      Uri.https("api.trello.com", "1/cards/$id/idMembers"),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
      body: {
        'value': memberId,
      },
    ).then(
      (response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        final responseJson = jsonDecode(response.body) as List<dynamic>;

        _cards.update();
      },
    );
  }
}
