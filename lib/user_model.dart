class User {
  final int id;
  final String name;
  final String email;
  int priority = 0;
  User(
      {required this.id,
      required this.name,
      required this.email,
      this.priority = 0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      name: json['firstName'] ?? 'no_name',
      email: json['email'] ?? 'no_email',
    );
  }

  List<Object> get props => [id, name, email];
}
