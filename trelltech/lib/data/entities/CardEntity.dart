class CardEntity {
  String? id;
  bool? closed;
  String? dateLastActivity;
  String? due;
  String? idBoard;
  String? idList;
  String? name;

  CardEntity(
      {this.id,
      this.closed,
      this.dateLastActivity,
      this.due,
      this.idBoard,
      this.idList,
      this.name});

  CardEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    closed = json['closed'];
    dateLastActivity = json['dateLastActivity'];
    due = json['due'];
    idBoard = json['idBoard'];
    idList = json['idList'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['closed'] = this.closed;
    data['dateLastActivity'] = this.dateLastActivity;
    data['due'] = this.due;
    data['idBoard'] = this.idBoard;
    data['idList'] = this.idList;
    data['name'] = this.name;
    return data;
  }
}
