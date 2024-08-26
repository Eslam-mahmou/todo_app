class UserModel {
  static const String collectionName = "users";
  String? id;
  String? name;
  String? email;

  UserModel({required this.id, required this.name, required this.email});

  factory UserModel.fromUsersFireStore(Map<String, dynamic> data) {
    return UserModel(
        id: data['id'],
        name: data['name'] ,
        email: data['email']);
  }

  Map<String, dynamic> toUsersFireStore() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
