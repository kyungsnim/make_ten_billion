import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String writer;
  final String comment;
  final DateTime createdAt;

  CommentModel(
      {required this.id, required this.writer,
        required this.comment,
        required this.createdAt});

  // factory NoticeModel.fromMap(Map data) {
  //   return NoticeModel(id: data['id'], writer: data['writer'], createdAt: data['createdAt'].toDate());
  // }

  Map<String, dynamic> toJson() => {
    "id": id,
    "writer": writer,
    "createdAt": createdAt,
    "comment": comment,
  };

  CommentModel.fromMap(var data)
      : id = data['id'],
        writer = data['writer'],
        comment = data['comment'],
        createdAt = data['createdAt'].toDate();

  CommentModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
