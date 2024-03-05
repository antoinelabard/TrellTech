import 'package:trelltech/data/methods/CardMethods.dart';
import 'package:trelltech/data/methods/MemberMethods.dart';

import 'methods/BoardMethods.dart';
import 'methods/OrganizationMethods.dart';

class Repository {
  static BoardMethods Board = BoardMethods();
  static OrganizationMethods Organization = OrganizationMethods();
  static CardMethods Card = CardMethods();
  static MemberMethods Member = MemberMethods();
}

Future<void> main() async {
  var repo = Repository();
  print(await Repository.Board.get("lqkjsdf").then((res) => res));
}
