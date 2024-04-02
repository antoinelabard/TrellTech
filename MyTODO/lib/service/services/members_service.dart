import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'boards_services.dart';
import 'organization_service.dart';

class Members with ChangeNotifier, DiagnosticableTreeMixin {
  final Auth _auth;
  final Organizations _organizations;
  final Boards _boards;

  List<Member> members = [];
  Map<String, Member> membersById = {};

  Map<String, List<Member>> membersByOrganizationId = {};
  Map<String, List<Member>> membersByBoardId = {};

  Members(this._auth, this._organizations, this._boards) {
    update();
  }

  update() async {
    if (_auth.apiToken == null) {
      return;
    }

    for (var organization in _organizations.organizations) {
      log(organization.id);
      await http.get(
        Uri.parse(
            "https://api.trello.com/1/organizations/${organization.id}/members"),
        headers: {
          'Authorization':
              'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
        },
      ).then((response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        final responseJson = jsonDecode(response.body) as List<dynamic>;

        //check if need update, create, delete
        //show id fo each member
        for (var member in responseJson) {
          log(member['id']);
          _updateData(member, organization: organization);
        }

        //! delete member that are not in response and in organization
        for (var member in membersByOrganizationId[organization.id] ?? []) {
          if (responseJson
                  .indexWhere((element) => element['id'] == member.id) ==
              -1) {
            membersByOrganizationId[organization.id]?.remove(member);
            //! check if member is in other organization and other board
            if (membersByOrganizationId[organization.id]?.contains(member) ==
                    false &&
                membersByBoardId[organization.id]?.contains(member) == false) {
              members.remove(member);
              membersById.remove(member.id);
            }
          }
        }
      });
    }

    for (var board in _boards.boards) {
      log(board.id);
      await http.get(
        Uri.parse("https://api.trello.com/1/boards/${board.id}/members"),
        headers: {
          'Authorization':
              'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
        },
      ).then((response) {
        if (response.statusCode >= 400) {
          log(response.body);
          throw Exception(response.body);
        }

        final responseJson = jsonDecode(response.body) as List<dynamic>;

        //check if need update, create, delete
        //show id fo each member
        for (var member in responseJson) {
          log(member['id']);
          _updateData(member, board: board);
        }

        //! delete member that are not in response and in board
        for (var member in membersByBoardId[board.id] ?? []) {
          if (responseJson
                  .indexWhere((element) => element['id'] == member.id) ==
              -1) {
            membersByBoardId[board.id]?.remove(member);
            //! check if member is in other organization and other board
            if (membersByOrganizationId[board.id]?.contains(member) == false &&
                membersByBoardId[board.id]?.contains(member) == false) {
              members.remove(member);
              membersById.remove(member.id);
            }
          }
        }
      });
    }
    notifyListeners();
  }

  _updateData(Map<String, dynamic> member,
      {Organization? organization, Board? board}) {
    if (membersById.containsKey(member['id'])) {
      membersById[member['id']]?.update(member);
    } else {
      final Member newMember = Member.fromJson(member, this);
      members.add(newMember);
      membersById[newMember.id] = newMember;
    }

    final Member actualMember = membersById[member['id']]!;

    if (organization != null) {
      if (membersByOrganizationId[organization.id] == null) {
        membersByOrganizationId[organization.id] = [actualMember];
      }
      //check is already in list
      if (membersByOrganizationId[organization.id]?.contains(actualMember) ==
          false) {
        membersByOrganizationId[organization.id]?.add(actualMember);
      }
    }

    if (board != null) {
      if (membersByBoardId[board.id] == null) {
        membersByBoardId[board.id] = [actualMember];
      }
      //check is already in list
      if (membersByBoardId[board.id]?.contains(actualMember) == false) {
        membersByBoardId[board.id]?.add(actualMember);
      }
    }
  }
}

class Member {
  final Members _members;
  final String id;

  String fullName;
  String username;

  Member({
    required this.id,
    required this.fullName,
    required this.username,
    required members,
  }) : _members = members;

  factory Member.fromJson(Map<String, dynamic> json, Members members) {
    return Member(
      id: json['id'],
      fullName: json['fullName'],
      username: json['username'],
      members: members,
    );
  }

  update(Map<String, dynamic> member) {
    fullName = member['fullName'];
    username = member['username'];
    _members.notifyListeners();
  }
}
