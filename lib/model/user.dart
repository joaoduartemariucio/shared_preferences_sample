class User {
  String email;
  String token;

  User();

  User.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        token = json['token'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'token': token,
      };
}
