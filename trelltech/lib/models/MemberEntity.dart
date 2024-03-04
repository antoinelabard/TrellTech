class MemberEntity {
  String id;
  String fullName;
  String username;

  MemberEntity({this.id, this.fullName, this.username});

  MemberEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    return data;
  }
}
