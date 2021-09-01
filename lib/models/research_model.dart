import 'package:cloud_firestore/cloud_firestore.dart';

class ResearchModel {
  final String id;
  final String writer;
  final String title;
  final String description;
  final int read;
  final DateTime createdAt;

  ResearchModel(
      {required this.id, required this.writer,
        required this.title,
        required this.description,
        required this.read,
        required this.createdAt});

  // factory ResearchModel.fromMap(Map data) {
  //   return ResearchModel(id: data['id'], writer: data['writer'], createdAt: data['createdAt'].toDate());
  // }

  Map<String, dynamic> toJson() => {
    "id": id,
    "writer": writer,
    "createdAt": createdAt,
    "title": title,
    "description": description,
    "read": read,
  };

  ResearchModel.fromMap(var data)
      : id = data['id'],
        writer = data['writer'],
        title = data['title'],
        description = data['description'],
        read = data['read'],
        createdAt = data['createdAt'].toDate();

  ResearchModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
