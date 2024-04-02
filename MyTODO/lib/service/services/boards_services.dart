//list of board with provider

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'user_info_service.dart';
import 'auth_service.dart';

class Boards with ChangeNotifier, DiagnosticableTreeMixin {
  final Auth _auth;
  final TokenMember _tokenMember;

  List<String> organizationIds = [];

  List<Board> boards = [];
  Map<String, Board> boardsById = {};
  Map<String, List<Board>> boardsByOrganizationId = {};

  Boards(this._tokenMember, this._auth) {
    update();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('boards', boards));
    properties.add(IterableProperty('boardsById', boardsById.values));
    properties.add(IterableProperty(
        'boardsByOrganizationId', boardsByOrganizationId.values));
  }

  update() async {
    if (_auth.apiToken == null) {
      organizationIds = [];
      return;
    }
    if (_tokenMember.member == null) {
      return;
    }

    final response = await http.get(
        Uri.parse(
            "https://api.trello.com/1/members/${_tokenMember.member!.id}/boards"),
        headers: {
          'Authorization':
              'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
        });

    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }

    final responseJson = jsonDecode(response.body) as List<dynamic>;

    for (var board in responseJson) {
      _updateData(board);
    }

    List<Board> listCopy = List.from(boards);
    for (var board in listCopy) {
      if (!responseJson.any((element) => element['id'] == board.id) &&
          board.memberships
              .any((member) => member.idMember == _tokenMember.member!.id)) {
        log("update : remove board : ${board.name}");
        boards.remove(board);
        boardsById.remove(board.id);
        boardsByOrganizationId.remove(board.idOrganization);
      }
    }

    log("END hey");
    await _updateOrganizationBoards();

    log("NOTIFY : boards");
    notifyListeners();
  }

  _updateData(dynamic board) {
    final index = boardsById.keys.toList().indexOf(board['id']);
    if (index == -1) {
      Board tmpBoard = Board.fromJson(board, _auth, this);
      boards.add(tmpBoard);
      boardsById[board['id']] = tmpBoard;
      if (boardsByOrganizationId[board['idOrganization']] == null) {
        boardsByOrganizationId[board['idOrganization']] = [tmpBoard];
      } else {
        boardsByOrganizationId[board['idOrganization']]!.add(tmpBoard);
      }
    } else {
      boards[index]._updateJson(board);
    }
  }

  createBoard(
      {required String name,
      String? defaultLabels,
      String? defaultLists,
      String? desc,
      String? idOrganization,
      String? idBoardSource,
      String? keepFromSource,
      String? powerUps,
      String? prefsPermissionLevel,
      String? prefsVoting,
      String? prefsComments,
      String? prefsInvitations,
      String? prefsSelfJoin,
      String? prefsCardCovers,
      String? prefsBackground,
      String? prefsCardAging}) async {
    Map<String, String> queryParameters = {
      'name': name,
      if (defaultLabels != null) 'defaultLabels': defaultLabels,
      if (defaultLists != null) 'defaultLists': defaultLists,
      if (desc != null) 'desc': desc,
      if (idOrganization != null) 'idOrganization': idOrganization,
      if (idBoardSource != null) 'idBoardSource': idBoardSource,
      if (keepFromSource != null) 'keepFromSource': keepFromSource,
      if (powerUps != null) 'powerUps': powerUps,
      if (prefsPermissionLevel != null)
        'prefs_permissionLevel': prefsPermissionLevel,
      if (prefsVoting != null) 'prefs_voting': prefsVoting,
      if (prefsComments != null) 'prefs_comments': prefsComments,
      if (prefsInvitations != null) 'prefs_invitations': prefsInvitations,
      if (prefsSelfJoin != null) 'prefs_selfJoin': prefsSelfJoin,
      if (prefsCardCovers != null) 'prefs_cardCovers': prefsCardCovers,
      if (prefsBackground != null) 'prefs_background': prefsBackground,
      if (prefsCardAging != null) 'prefs_cardAging': prefsCardAging,
    };

    final response = await http.post(
      Uri.https('api.trello.com', '/1/boards', queryParameters),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    );

    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }

    final responseJson = jsonDecode(response.body);
    log(responseJson.toString());
    _updateData(responseJson);
    notifyListeners();
  }

  void addOrganizationIds(List<String> newOrganizationIds) {
    log("addOrganizationIds : $newOrganizationIds");
    bool updated = false;
    for (var id in newOrganizationIds) {
      if (!organizationIds.contains(id)) {
        organizationIds.add(id);
        updated = true;
      }
    }
    if (updated) {
      update();
    }
  }

  Future<void> _updateOrganizationBoards() async {
    if (_auth.apiToken == null) {
      return;
    }

    if (_tokenMember.member == null) {
      return;
    }
    log("hey2");
    for (var id in organizationIds) {
      final response = await http.get(
          Uri.parse("https://api.trello.com/1/organizations/$id/boards"),
          headers: {
            'Authorization':
                'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
          });

      if (response.statusCode >= 400) {
        log(response.body);
        throw Exception(response.body);
      }

      final responseJson = jsonDecode(response.body) as List<dynamic>;

      //check if need update, create, delete
      for (var board in responseJson) {
        _updateData(board);
      }

      if (boardsByOrganizationId[id] != null) {
        //for board that not in responseJson and user is not member of board
        List<Board> listCopy = List.from(boardsByOrganizationId[id]!);
        for (var board in listCopy) {
          //check if board is not in responseJson and if user is not member of board :  delete board
          if (!responseJson.any((element) => element['id'] == board.id) &&
              !board.memberships.any(
                  (member) => member.idMember == _tokenMember.member!.id)) {
            log("_updateOrganizationBoards : remove board : ${board.name}");
            boards.remove(board);
            boardsById.remove(board.id);
            boardsByOrganizationId[id]!.remove(board);
          }
        }
      }
    }
    log("END hey2");
  }
}

class Board with ChangeNotifier, DiagnosticableTreeMixin {
  final Auth _auth;
  final Boards boards;

  final String id;
  String name;
  String desc;
  bool closed;
  String? idOrganization;
  String? idEnterprise;
  bool pinned;
  Uri url;
  Uri shortUrl;
  Map labelNames;
  List<Membership> memberships = [];

  Board(
    this._auth,
    this.boards, {
    required this.id,
    required this.name,
    required this.desc,
    required this.closed,
    this.idOrganization,
    this.idEnterprise,
    required this.pinned,
    required this.url,
    required this.shortUrl,
    required this.labelNames,
    required this.memberships,
  });

  factory Board.fromJson(Map<String, dynamic> json, Auth auth, Boards boards) {
    return Board(
      auth,
      boards,
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      closed: json['closed'],
      idOrganization: json['idOrganization'],
      idEnterprise: json['idEnterprise'],
      pinned: json['pinned'],
      url: Uri.parse(json['url']),
      shortUrl: Uri.parse(json['shortUrl']),
      labelNames: json['labelNames'],
      memberships: ((json['memberships'] ?? []) as List<dynamic>)
          .map((e) => Membership.fromJson(e))
          .toList(),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('id', id));
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('desc', desc));
    properties.add(FlagProperty('closed', value: closed, ifTrue: 'closed'));
    properties.add(StringProperty('idOrganization', idOrganization));
    properties.add(StringProperty('idEnterprise', idEnterprise));
    properties.add(FlagProperty('pinned', value: pinned, ifTrue: 'pinned'));
    properties.add(DiagnosticsProperty('url', url));
    properties.add(DiagnosticsProperty('shortUrl', shortUrl));
    properties.add(DiagnosticsProperty('labelNames', labelNames));
  }

  update({
    String? name,
    String? desc,
    bool? closed,
    String? subscribed,
    String? idOrganization,
    String? prefsPermissionLevel,
    String? prefsSelfJoin,
    String? prefsCardCovers,
    String? prefsHideVotes,
    String? prefsInvitations,
    String? prefsVoting,
    String? prefsComments,
    String? prefsBackground,
    String? prefsCardAging,
    String? prefsCalendarFeedEnabled,
    String? labelNamesGreen,
    String? labelNamesYellow,
    String? labelNamesOrange,
    String? labelNamesRed,
    String? labelNamesPurple,
    String? labelNamesBlue,
  }) async {
    Map<String, String> queryParameters = {
      if (name != null) 'name': name,
      if (desc != null) 'desc': desc,
      if (closed != null) 'closed': closed.toString(),
      if (subscribed != null) 'subscribed': subscribed,
      if (idOrganization != null) 'idOrganization': idOrganization,
      if (prefsPermissionLevel != null)
        'prefs_permissionLevel': prefsPermissionLevel,
      if (prefsSelfJoin != null) 'prefs_selfJoin': prefsSelfJoin,
      if (prefsCardCovers != null) 'prefs_cardCovers': prefsCardCovers,
      if (prefsHideVotes != null) 'prefs_hideVotes': prefsHideVotes,
      if (prefsInvitations != null) 'prefs_invitations': prefsInvitations,
      if (prefsVoting != null) 'prefs_voting': prefsVoting,
      if (prefsComments != null) 'prefs_comments': prefsComments,
      if (prefsBackground != null) 'prefs_background': prefsBackground,
      if (prefsCardAging != null) 'prefs_cardAging': prefsCardAging,
      if (prefsCalendarFeedEnabled != null)
        'prefs_calendarFeedEnabled': prefsCalendarFeedEnabled,
      if (labelNamesGreen != null) 'labelNames/green': labelNamesGreen,
      if (labelNamesYellow != null) 'labelNames/yellow': labelNamesYellow,
      if (labelNamesOrange != null) 'labelNames/orange': labelNamesOrange,
      if (labelNamesRed != null) 'labelNames/red': labelNamesRed,
      if (labelNamesPurple != null) 'labelNames/purple': labelNamesPurple,
      if (labelNamesBlue != null) 'labelNames/blue': labelNamesBlue,
    };

    final response = await http.put(
      Uri.https('api.trello.com', '/1/boards/$id', queryParameters),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    );

    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }

    final responseJson = jsonDecode(response.body);
    log(responseJson.toString());
    _updateJson(responseJson);
    boards.notifyListeners();
    _update();
  }

  _update() async {
    final response = await http.get(
      Uri.parse('https://api.trello.com/1/boards/$id'),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    );

    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }

    final responseJson = jsonDecode(response.body);
    log(responseJson.toString());
    _updateJson(responseJson);

    notifyListeners();

    boards.update();
  }

  _updateJson(Map<String, dynamic> json) {
    //check if need update. if need (update and notify)
    bool update = false;

    if (json['name'] != name) {
      name = json['name'];
      update = true;
    }
    if (json['desc'] != desc) {
      desc = json['desc'];
      update = true;
    }
    if (json['closed'] != closed) {
      closed = json['closed'];
      update = true;
    }
    if (json['idOrganization'] != idOrganization) {
      idOrganization = json['idOrganization'];
      update = true;
    }
    if (json['idEnterprise'] != idEnterprise) {
      idEnterprise = json['idEnterprise'];
      update = true;
    }
    if (json['pinned'] != pinned) {
      pinned = json['pinned'];
      update = true;
    }
    if (json['url'] != url) {
      url = Uri.parse(json['url']);
      update = true;
    }
    if (json['shortUrl'] != shortUrl) {
      shortUrl = Uri.parse(json['shortUrl']);
      update = true;
    }
    if (json['labelNames'] != labelNames) {
      labelNames = json['labelNames'];
      update = true;
    }

    if (update) {
      notifyListeners();
    }
  }

  delete() async {
    if (_auth.apiToken == null) {
      return;
    }

    final response = await http.delete(
      Uri.https('api.trello.com', '/1/boards/$id'),
      headers: {
        'Authorization':
            'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
      },
    );

    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }

    final responseJson = jsonDecode(response.body);
    log(responseJson.toString());

    notifyListeners();

    boards.update();
  }
}

class Membership {
  final String idMember;
  final String memberType;
  final bool unconfirmed;
  final bool deactivated;
  final String id;

  Membership({
    required this.idMember,
    required this.memberType,
    required this.unconfirmed,
    required this.deactivated,
    required this.id,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      idMember: json['idMember'],
      memberType: json['memberType'],
      unconfirmed: json['unconfirmed'],
      deactivated: json['deactivated'],
      id: json['id'],
    );
  }
}
