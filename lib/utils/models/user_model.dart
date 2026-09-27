class UserModel {
  String? name;
  String? email;
  String? id;
  String? phone;

  UserModel({
    required  this.name,
    required this.email,
    required this.id,
    required   this.phone,
  });

  // Factory constructor to create a UserModel instance from a JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  // Method to convert a UserModel instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}