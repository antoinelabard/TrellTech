import 'package:trelltech/data/entities/OrganizationEntity.dart';
import 'package:trelltech/data/methods/CardMethods.dart';
import 'methods/MemberMethods.dart';
import 'methods/BoardMethods.dart';
import 'methods/ListMethods.dart';
import 'methods/OrganizationMethods.dart';

class Repository {
  static String SERVER_ADDRESS = "http://localhost:8080";
  static BoardMethods Board = BoardMethods();
  static OrganizationMethods Organization = OrganizationMethods();
  static CardMethods Card = CardMethods();
  static MemberMethods Member = MemberMethods();
  static ListMethods List = ListMethods();
}

//Todo Remove the following code before merging to dev
var exampleOrgaId = "61a4d8601bd6943d9d6296a5";
var newOrgaName = "nameeeeeeeeee";

Future<void> main() async {
  // await Repository.Organization.create("monorga");
  print(await Repository.Organization.getJoinedOrganizations());
}
