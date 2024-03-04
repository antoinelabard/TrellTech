class BoardEntity {
  String? id;
  String? name;
  bool? closed;
  String? idMemberCreator;
  String? idOrganization;
  String? dateLastActivity;
  String? dateLastView;

  BoardEntity(
      {this.id,
      this.name,
      this.closed,
      this.idMemberCreator,
      this.idOrganization,
      this.dateLastActivity,
      this.dateLastView});

  BoardEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    closed = json['closed'];
    idMemberCreator = json['idMemberCreator'];
    idOrganization = json['idOrganization'];
    dateLastActivity = json['dateLastActivity'];
    dateLastView = json['dateLastView'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['closed'] = this.closed;
    data['idMemberCreator'] = this.idMemberCreator;
    data['idOrganization'] = this.idOrganization;
    data['dateLastActivity'] = this.dateLastActivity;
    data['dateLastView'] = this.dateLastView;
    return data;
  }
}
