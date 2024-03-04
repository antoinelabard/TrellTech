class BoardEntity {
  String? id;
  String? name;
  String? idOrganization;

  BoardEntity(
      {this.id,
      this.name,
      this.idOrganization,
      });

  BoardEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    idOrganization = json['idOrganization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['idOrganization'] = this.idOrganization;
    return data;
  }
}
