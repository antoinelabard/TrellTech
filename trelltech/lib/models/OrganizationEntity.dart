class OrganizationEntity {
  String? id;
  String? name;
  String? displayName;
  String? url;
  String? idMemberCreator;

  OrganizationEntity(
      {this.id, this.name, this.displayName, this.url, this.idMemberCreator});

  OrganizationEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    url = json['url'];
    idMemberCreator = json['idMemberCreator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['url'] = this.url;
    data['idMemberCreator'] = this.idMemberCreator;
    return data;
  }
}
