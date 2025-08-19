class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? confirmpassword;
  final String? role;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.confirmpassword,
    this.role,
  });

  // Convert JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      username: json['username'],
      password: json['password'],
      confirmpassword: json['confirmpassword'],
      role: json['role'],
    );
  }

  // Convert User object to JSON (for registration or login)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'confirmpassword': confirmpassword,
      'role': role,
    };
  }
}
