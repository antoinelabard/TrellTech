class ListEntity {
  String? id;
  String? address;
  List<String>? checkItemStates;
  bool? closed;
  String? coordinates;
  String? creationMethod;
  String? dateLastActivity;
  String? desc;
  String? due;
  String? dueReminder;
  String? email;
  String? idBoard;
  String? idList;
  List<String>? idMembers;
  List<String>? idMembersVoted;
  int? idShort;
  List<String>? labels;
  String? locationName;
  bool? manualCoverAttachment;
  String? name;
  int? pos;
  String? shortLink;
  String? shortUrl;
  bool? subscribed;
  String? url;

  ListEntity(
      {this.id,
      this.address,
      this.checkItemStates,
      this.closed,
      this.coordinates,
      this.creationMethod,
      this.dateLastActivity,
      this.desc,
      this.due,
      this.dueReminder,
      this.email,
      this.idBoard,
      this.idList,
      this.idMembers,
      this.idMembersVoted,
      this.idShort,
      this.labels,
      this.locationName,
      this.manualCoverAttachment,
      this.name,
      this.pos,
      this.shortLink,
      this.shortUrl,
      this.subscribed,
      this.url,
      });

  ListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    checkItemStates = json['checkItemStates'].cast<String>();
    closed = json['closed'];
    coordinates = json['coordinates'];
    creationMethod = json['creationMethod'];
    dateLastActivity = json['dateLastActivity'];
    desc = json['desc'];
    due = json['due'];
    dueReminder = json['dueReminder'];
    email = json['email'];
    idBoard = json['idBoard'];
    idList = json['idList'];
    idMembers = json['idMembers'].cast<String>();
    idMembersVoted = json['idMembersVoted'].cast<String>();
    idShort = json['idShort'];
    labels = json['labels'].cast<String>();
    locationName = json['locationName'];
    manualCoverAttachment = json['manualCoverAttachment'];
    name = json['name'];
    pos = json['pos'];
    shortLink = json['shortLink'];
    shortUrl = json['shortUrl'];
    subscribed = json['subscribed'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['checkItemStates'] = this.checkItemStates;
    data['closed'] = this.closed;
    data['coordinates'] = this.coordinates;
    data['creationMethod'] = this.creationMethod;
    data['dateLastActivity'] = this.dateLastActivity;
    data['desc'] = this.desc;
    data['due'] = this.due;
    data['dueReminder'] = this.dueReminder;
    data['email'] = this.email;
    data['idBoard'] = this.idBoard;
    data['idList'] = this.idList;
    data['idMembers'] = this.idMembers;
    data['idMembersVoted'] = this.idMembersVoted;
    data['idShort'] = this.idShort;
    data['labels'] = this.labels;
    data['locationName'] = this.locationName;
    data['manualCoverAttachment'] = this.manualCoverAttachment;
    data['name'] = this.name;
    data['pos'] = this.pos;
    data['shortLink'] = this.shortLink;
    data['shortUrl'] = this.shortUrl;
    data['subscribed'] = this.subscribed;
    data['url'] = this.url;
    return data;
  }
}
