class AuthenticateModel {
  String? email;
  String? name;
  String? authToken;

  AuthenticateModel({this.email, this.name, this.authToken});

  AuthenticateModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    authToken = json['authToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['authToken'] = this.authToken;
    return data;
  }
}