class UserModel {
  final String uid;
  final String profileName;
  final String email;

  UserModel({required this.uid, required this.profileName, required this.email});

  factory UserModel.fromMap(Map data) {
    return UserModel(uid: data['uid'], profileName: data['profileName'], email: data['email']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "profileName": profileName,
        "email": email,
      };
}
