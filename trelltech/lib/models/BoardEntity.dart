class BoardEntity {
  String id;
  String name;
  String desc;
  String descData;
  bool closed;
  String idMemberCreator;
  String idOrganization;
  bool pinned;
  String url;
  String shortUrl;
  bool starred;
  String memberships;
  String shortLink;
  bool subscribed;
  String powerUps;
  String dateLastActivity;
  String dateLastView;
  String idTags;
  String datePluginDisable;
  String creationMethod;
  int ixUpdate;
  String templateGallery;
  bool enterpriseOwned;

  BoardEntity(
      {this.id,
      this.name,
      this.desc,
      this.descData,
      this.closed,
      this.idMemberCreator,
      this.idOrganization,
      this.pinned,
      this.url,
      this.shortUrl,
      this.prefs,
      this.labelNames,
      this.limits,
      this.starred,
      this.memberships,
      this.shortLink,
      this.subscribed,
      this.powerUps,
      this.dateLastActivity,
      this.dateLastView,
      this.idTags,
      this.datePluginDisable,
      this.creationMethod,
      this.ixUpdate,
      this.templateGallery,
      this.enterpriseOwned});

  BoardEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    descData = json['descData'];
    closed = json['closed'];
    idMemberCreator = json['idMemberCreator'];
    idOrganization = json['idOrganization'];
    pinned = json['pinned'];
    url = json['url'];
    shortUrl = json['shortUrl'];
    starred = json['starred'];
    memberships = json['memberships'];
    shortLink = json['shortLink'];
    subscribed = json['subscribed'];
    powerUps = json['powerUps'];
    dateLastActivity = json['dateLastActivity'];
    dateLastView = json['dateLastView'];
    idTags = json['idTags'];
    datePluginDisable = json['datePluginDisable'];
    creationMethod = json['creationMethod'];
    ixUpdate = json['ixUpdate'];
    templateGallery = json['templateGallery'];
    enterpriseOwned = json['enterpriseOwned'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['descData'] = this.descData;
    data['closed'] = this.closed;
    data['idMemberCreator'] = this.idMemberCreator;
    data['idOrganization'] = this.idOrganization;
    data['pinned'] = this.pinned;
    data['url'] = this.url;
    data['shortUrl'] = this.shortUrl;
    data['starred'] = this.starred;
    data['memberships'] = this.memberships;
    data['shortLink'] = this.shortLink;
    data['subscribed'] = this.subscribed;
    data['powerUps'] = this.powerUps;
    data['dateLastActivity'] = this.dateLastActivity;
    data['dateLastView'] = this.dateLastView;
    data['idTags'] = this.idTags;
    data['datePluginDisable'] = this.datePluginDisable;
    data['creationMethod'] = this.creationMethod;
    data['ixUpdate'] = this.ixUpdate;
    data['templateGallery'] = this.templateGallery;
    data['enterpriseOwned'] = this.enterpriseOwned;
    return data;
  }
}
