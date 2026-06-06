class User {
  final String name;
  final String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    // Ajustar según la estructura real de la API
    return User(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }
}
