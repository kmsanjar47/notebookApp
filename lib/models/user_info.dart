class UserInfo{
  String? username;
  String? email;
  String? password;
  String? datecreated;
  int? id;

  UserInfo({this.id,this.username, this.email, this.password,this.datecreated});

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "email": email,
      "password": password,
      "date_created": datecreated
    };
  }
}