class OrganizationEntity {
  String? id;
  String? displayName;

  OrganizationEntity(
      {this.id, this.displayName});

  OrganizationEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    displayName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['displayName'] = this.displayName;
    return data;
  }
}
