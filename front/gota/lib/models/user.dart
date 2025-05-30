class User {
  String id;
  String name;
  String email;
  String password;
  bool loggged;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.loggged = false,
  });

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      email = json['email'],
      password = json['password'],
      loggged = json['loggged'] ?? false;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'password': password,
    'loggged': loggged,
  };
}
