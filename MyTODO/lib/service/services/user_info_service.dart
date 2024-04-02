import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';
import 'dart:developer';

class TokenMember with ChangeNotifier, DiagnosticableTreeMixin {
  Auth _auth;
  Member? member;

  TokenMember(this._auth);

  authUpdate(Auth auth) {
    _auth = auth;
    if (auth.apiToken != null) {
      _tokenMemberUpdate();
    } else {
      member = null;
      notifyListeners();
    }
  }

  _tokenMemberUpdate() async {
    if (_auth.apiToken == null) {
      return;
    }
    //call api to get user info
    final response = await http.get(
        Uri.parse("https://api.trello.com/1/tokens/${_auth.apiToken}/member"),
        headers: {
          HttpHeaders.authorizationHeader:
              'OAuth oauth_consumer_key="${Auth.apiKey}", oauth_token="${_auth.apiToken}"',
        });
    if (response.statusCode >= 400) {
      log(response.body);
      throw Exception(response.body);
    }
    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    log(responseJson.toString());
    member = Member.fromJson(responseJson);
    notifyListeners();
  }
}

class Member {
  final String id;
  final String avatarHash;
  final Uri avatarUrl;
  final String bio;
  final String fullName;
  final Uri url;
  final String username;
  final String? email;
  //idBoards
  final List<String> idBoards;
  //idOrganizations
  final List<String> idOrganizations;

  Member({
    required this.id,
    required this.avatarHash,
    required this.avatarUrl,
    required this.bio,
    required this.fullName,
    required this.url,
    required this.username,
    this.email,
    required this.idBoards,
    required this.idOrganizations,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      avatarHash: json['avatarHash'],
      avatarUrl: Uri.parse(json['avatarUrl'] + "/30.png"),
      bio: json['bio'],
      fullName: json['fullName'],
      url: Uri.parse(json['url']),
      username: json['username'],
      email: json['email'],
      idBoards: List<String>.from(json['idBoards']),
      idOrganizations: List<String>.from(json['idOrganizations']),
    );
  }
}
