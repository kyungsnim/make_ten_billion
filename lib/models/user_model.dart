class UserModel {
  final String uid;
  final String profileName;
  final String email;
  final String role;

  UserModel({required this.uid, required this.profileName, required this.email, required this.role});

  factory UserModel.fromMap(Map data) {
    return UserModel(uid: data['uid'], profileName: data['profileName'], email: data['email'], role: data['role']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "profileName": profileName,
        "email": email,
        "role": role,
      };
}
