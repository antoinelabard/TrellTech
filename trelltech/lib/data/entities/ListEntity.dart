class ListEntity {
  String? id;
  String? idBoard;
  String? name;

  ListEntity(
      {this.id,
      this.idBoard,
      this.name,
      });

  ListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBoard = json['idBoard'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idBoard'] = this.idBoard;
    data['name'] = this.name;
    return data;
  }
}
