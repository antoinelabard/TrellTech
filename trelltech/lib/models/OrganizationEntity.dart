class OrganizationEntity {
  String id;
  String name;
  String displayName;
  String desc;
  String url;
  Null website;
  Null teamType;
  Null logoHash;
  Null logoUrl;
  String offering;
  List<Null> products;
  List<Null> powerUps;
  String idMemberCreator;

  OrganizationEntity(
      {this.id,
      this.name,
      this.displayName,
      this.desc,
      this.url,
      this.website,
      this.teamType,
      this.logoHash,
      this.logoUrl,
      this.offering,
      this.products,
      this.powerUps,
      this.idMemberCreator});

  OrganizationEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    desc = json['desc'];
    url = json['url'];
    website = json['website'];
    teamType = json['teamType'];
    logoHash = json['logoHash'];
    logoUrl = json['logoUrl'];
    offering = json['offering'];
    idMemberCreator = json['idMemberCreator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['displayName'] = this.displayName;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data['website'] = this.website;
    data['teamType'] = this.teamType;
    data['logoHash'] = this.logoHash;
    data['logoUrl'] = this.logoUrl;
    data['offering'] = this.offering;
    data['idMemberCreator'] = this.idMemberCreator;
    return data;
  }
}
