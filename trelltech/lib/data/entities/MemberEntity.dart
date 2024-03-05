class MemberEntity {
  String? id;
  String? username;
  List<String>? idOrganizations;
  List<String>? idBoards;

  MemberEntity({this.id, this.username, this.idOrganizations, this.idBoards});

  MemberEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    idOrganizations = json['idOrganizations'];
    idBoards = json['idBoards'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['idOrganizations'] = this.idOrganizations;
    data['idBoards'] = this.idBoards;
    return data;
  }
}
