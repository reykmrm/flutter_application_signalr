class Users {
  int? id;
  String? name;
  String? users;
  String? pass;

  Users({
    this.id,
    this.name,
    this.users,
    this.pass,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
      users: json['users'],
      pass: json['pass'],
    );
  }
}
