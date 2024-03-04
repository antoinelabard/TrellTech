import 'methods/BoardMethods.dart';
import 'methods/OrganizationMethods.dart';

class Repository {
  static BoardMethods Board = BoardMethods();
  static OrganizationMethods Organization = OrganizationMethods();
}

Future<void> main() async {
  var repo = Repository();
  print(await Repository.Board.get("lqkjsdf").then((res) => res));
}
