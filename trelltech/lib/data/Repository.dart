import 'package:trelltech/data/entities/BoardEntity.dart';
import 'package:trelltech/data/methods/BoardMethods.dart';

import 'methods/BoardMethods.dart';

class Repository {
  static BoardMethods Board = BoardMethods();
}

Future<void> main() async {
  var repo = Repository();
  print(await Repository.Board.getBoard("lqkjsdf").then((res) => res));
}
