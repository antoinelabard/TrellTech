import 'package:trelltech/data/methods/CardMethods.dart';
import 'package:trelltech/data/methods/ListMethods.dart';
import 'package:trelltech/data/methods/MemberMethods.dart';

import 'methods/BoardMethods.dart';
import 'methods/OrganizationMethods.dart';

class Repository {
  static String SERVER_ADDRESS = "http://localhost:8080";
  static BoardMethods Board = BoardMethods();
  static OrganizationMethods Organization = OrganizationMethods();
  static CardMethods Card = CardMethods();
  static MemberMethods Member = MemberMethods();
  static ListMethods listMethods = ListMethods();
}

Future<void> main() async {
  print((await Repository.Organization.get("65e6f53467498554d19a6215")).displayName);
}