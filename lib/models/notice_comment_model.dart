import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeCommentModel {
  String id;
  String writer;
  String comment;
  DateTime createdAt;

  NoticeCommentModel(
      {required this.id,
      required this.writer,
      required this.comment,
      required this.createdAt});

  // factory NoticeModel.fromMap(Map data) {
  //   return NoticeModel(id: data['id'], writer: data['writer'], createdAt: data['createdAt'].toDate());
  // }

  Map<String, dynamic> toJson() => {
        "id": id,
        "writer": writer,
        "comment": comment,
        "createdAt": createdAt,
      };

  NoticeCommentModel.fromMap(var data)
      : id = data['id'],
        writer = data['writer'] ?? '',
        comment = data['comment'] ?? '',
        createdAt = data['createdAt'].toDate();

  NoticeCommentModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
