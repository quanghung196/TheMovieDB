class AccountInfoModel {
  final int id;
  final String? name;
  final String? username;

  AccountInfoModel({this.id = 0, this.name, this.username});

  factory AccountInfoModel.fromJson(Map<String, dynamic> json) {
    return AccountInfoModel(
        id: json['id'], username: json['username'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    return data;
  }
}
