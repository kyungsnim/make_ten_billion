import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/controller/controllers.dart';

class HowToBeRichDetail extends StatefulWidget {
  var detailNotice;

  HowToBeRichDetail(this.detailNotice);

  @override
  _HowToBeRichDetailState createState() => _HowToBeRichDetailState();
}

class _HowToBeRichDetailState extends State<HowToBeRichDetail> {
  AuthController authController = AuthController.to;
  var noticeDbRef = FirebaseFirestore.instance.collection('HowToBeRich');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.detailNotice.title,
              style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: Get.width,
            height: Get.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  widget.detailNotice.imgUrl == '' ? Placeholder() : CachedNetworkImage(imageUrl: widget.detailNotice.imgUrl),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        summaryArea(
                            Icons.check,
                            widget.detailNotice.createdAt
                                .toString()
                                .substring(0, 10),
                            Colors.grey),
                        Spacer(),
                        // Text('${_.count}'),
                        InkWell(
                          onTap: () {
                            // addLikeCount(widget.detailNotice);
                            addLikeList();
                          },
                          child: summaryArea(
                            widget.detailNotice.likeList.contains(
                                    authController.firestoreUser.value!.email)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            widget.detailNotice.like.toString(),
                            widget.detailNotice.likeList.contains(
                                    authController.firestoreUser.value!.email)
                                ? Colors.redAccent
                                : Colors.grey,
                          ),
                        ),
                        Spacer(),
                        summaryArea(Icons.remove_red_eye,
                            (widget.detailNotice.read).toString(), Colors.grey),
                        Spacer(),
                        summaryArea(Icons.comment_rounded,
                            (widget.detailNotice.read).toString(), Colors.grey),
                      ],
                    ),
                  ),
                  Divider(),

                  /// 본문 내용
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(widget.detailNotice.description,
                              textAlign: TextAlign.start,
                              style: mediumTextStyle(FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            '댓글',
                            style: mediumTextStyle(FontWeight.bold),
                          ),
                        ],
                      )),

                  /// 로그인 안했으면 로그인을 하셔야 댓글을 남기실 수 있습니다.
                  authController.firestoreUser.value != null
                      ? needLogin()
                      : commentArea(),

                  /// 댓글 내용
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(widget.detailNotice.description,
                              textAlign: TextAlign.start,
                              style: mediumTextStyle(FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget needLogin() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('로그인을 하셔야 댓글을 남기실 수 있습니다.'),
            SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                Get.toNamed('sign_in');
              },
              child: Text('로그인'),
            )
          ],
        ),
      ),
    );
  }

  Widget commentArea() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(border: InputBorder.none),
            )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () { },
              child: Text('로그인'),
            )
            // TextButton(
            //   child: Text('작성'),
            //   onPressed: () {},
            //   style: TextButton.styleFrom(
            //     primary: Colors.red, // foreground
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void addLikeCount(notice) {
    // 좋아요 1 증가
    FirebaseFirestore.instance
        .collection('HowToBeRich')
        .doc(notice.id)
        .update(({'like': notice.like + 1}));
    setState(() {
      notice.like++;
    });
  }

  void addLikeList() {
    // 좋아요 누르지 않은 경우 빨간 하트로 바꾸고 좋아요+1 해줘야 함
    // 좋아요 리스트에 내가 없는 경우
    if (widget.detailNotice.likeList != null &&
        !widget.detailNotice.likeList
            .contains(authController.firestoreUser.value!.email)) {
      FirebaseFirestore.instance.runTransaction((transaction) {
        var ref = noticeDbRef.doc(widget.detailNotice.id);
        Future<DocumentSnapshot> doc = transaction.get(ref);
        // transaction.update(ref, {'like' : widget.detailNotice.like + 1});

        var addLikeList = [];
        // 좋아요 수는 0보다 큰데 내가 아직 좋아요 안눌렀을 때
        if (widget.detailNotice.likeList != null &&
            !widget.detailNotice.likeList
                .contains(authController.firestoreUser.value!.email)) {
          widget.detailNotice.likeList
              .add(authController.firestoreUser.value!.email);
          addLikeList = widget.detailNotice.likeList;
        } // 좋아요 클릭이 최초인 경우
        else {
          addLikeList.add(authController.firestoreUser.value!.email);
          print(addLikeList);
        }
        transaction.update(
            ref, {'like': widget.detailNotice.like, 'likeList': addLikeList});
        return doc;
      });

      setState(() {
        widget.detailNotice.like++;
      });
    }
    // 이미 좋아요 누른 경우 또 누르면 빈 하트로 바꾸고 좋아요-1 해줘야 함
    else {
      FirebaseFirestore.instance.runTransaction((transaction) {
        var ref = noticeDbRef.doc(widget.detailNotice.id);
        Future<DocumentSnapshot> doc = transaction.get(ref);
        // transaction.update(ref, {});
        var deletedLikeList = [];
        if (widget.detailNotice.likeList != null &&
            widget.detailNotice.likeList
                .contains(authController.firestoreUser.value!.email)) {
          int index = widget.detailNotice.likeList
              .indexOf(authController.firestoreUser.value!.email);
          widget.detailNotice.likeList.removeAt(index);
          deletedLikeList = widget.detailNotice.likeList;

          transaction.update(ref,
              {'like': widget.detailNotice.like, 'likeList': deletedLikeList});
        }
        return doc;
      });

      setState(() {
        widget.detailNotice.like--;
      });
    }
  }

  summaryArea(icon, text, color) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
        ),
        SizedBox(width: 5),
        Text(text),
      ],
    );
  }

  mediumTextStyle(fontWeight) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 16,
    );
  }

  smallTextStyle(fontWeight) {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: 12,
    );
  }
}
