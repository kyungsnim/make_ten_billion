import 'package:cloud_firestore/cloud_firestore.dart';

class NoticeModel {
  String id;
  String writer;
  String title;
  String description;
  String imgUrl;
  late int read;
  int like;
  DateTime createdAt;
  List<dynamic> likeList;

  NoticeModel(
      {required this.id,
      required this.writer,
      required this.title,
      required this.description,
      required this.imgUrl,
      required this.read,
      required this.like,
      required this.likeList,
      required this.createdAt});

  // factory NoticeModel.fromMap(Map data) {
  //   return NoticeModel(id: data['id'], writer: data['writer'], createdAt: data['createdAt'].toDate());
  // }

  Map<String, dynamic> toJson() => {
        "id": id,
        "writer": writer,
        "createdAt": createdAt,
        "title": title,
        "description": description,
        "imgUrl": imgUrl,
        "read": read,
        "like": like,
        "likeList": likeList,
      };

  NoticeModel.fromMap(var data)
      : id = data['id'],
        writer = data['writer'] ?? '',
        title = data['title'],
        description = data['description'],
        read = data['read'] ?? 0,
        like = data['like'] ?? 0,
        likeList = data['likeList'] ?? [],
        imgUrl = data['imgUrl'] ?? '',
        createdAt = data['createdAt'].toDate();

  NoticeModel.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data());
}
