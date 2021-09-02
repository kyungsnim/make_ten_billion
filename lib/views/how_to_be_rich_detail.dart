import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/models/models.dart';

class HowToBeRichDetail extends StatefulWidget {
  var detailNotice;

  HowToBeRichDetail(this.detailNotice);

  @override
  _HowToBeRichDetailState createState() => _HowToBeRichDetailState();
}

class _HowToBeRichDetailState extends State<HowToBeRichDetail> {
  var _lastRow = 0;
  final FETCH_ROW = 5;
  AuthController authController = AuthController.to;
  var noticeDbRef = FirebaseFirestore.instance.collection('HowToBeRich');
  var commentStream;
  ScrollController _scrollController = ScrollController();
  TextEditingController commentController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    /// 댓글 목록 불러오기

    commentStream = newStream();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          mounted) {
        setState(() {
          commentStream = newStream();
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Stream<QuerySnapshot> newStream() {
    return noticeDbRef.doc(widget.detailNotice.id).collection('Comments')
        .orderBy("createdAt", descending: true)
        .limit(FETCH_ROW * (_lastRow + 1))
        .snapshots();
  }
  
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
            child: Scrollbar(
              child: SingleChildScrollView(
                controller: _scrollController,
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
                    authController.firestoreUser.value == null
                        ? needLogin()
                        : commentArea(),

                    Divider(),

                    /// 댓글 내용
                    _buildCommentBody(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildCommentBody(BuildContext context) {
    // print("warning");
    return StreamBuilder<QuerySnapshot>(
        stream: commentStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return _buildCommentList(context, snapshot.data!.docs);
        });
  }

  Widget _buildCommentList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: snapshot.length,
        itemBuilder: (context, i) {
          // print("i : " + i.toString());
          final currentRow = (i + 1) ~/ FETCH_ROW;
          if (_lastRow != currentRow) {
            _lastRow = currentRow;
          }
          print("lastrow : " + _lastRow.toString());
          return _buildCommentListItem(context, snapshot[i]);
        });
  }

  Widget _buildCommentListItem(BuildContext context, DocumentSnapshot data) {
    NoticeCommentModel comment = NoticeCommentModel.fromSnapshot(data);
    return Padding(
      key: ValueKey(comment.id),
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.6)),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0), blurRadius: 5, color: Colors.white10)
          ],
        ),
        child: _listCommentItem(comment),
      ),
    );
  }

  _listCommentItem(NoticeCommentModel comment) {
    return ListTile(
      title: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(5),
        ),
        width: Get.width,
        margin: EdgeInsets.symmetric(vertical: 5),
        // height: 200,
        child: comment.comment != null
            ? Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: Get.width * 0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 댓글 게시자
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          comment.writer,
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          comment.createdAt.toString().substring(0, 10),
                          softWrap: true,
                          style: TextStyle(fontWeight: FontWeight.w200, color: Colors.grey),
                        ),
                        Spacer(),
                        comment.writer == authController.firestoreUser.value!.email ?
                        InkWell(onTap: () {
                          checkDeleteCommentPopup(comment, context);
                        },child: Icon(Icons.delete, color: Colors.grey,)) : SizedBox()
                      ],
                    ),
                    /// 댓글내용
                    Text(
                      comment.comment,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
            : SizedBox(),
      ),
    );
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
                  controller: commentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(border: InputBorder.none),
            )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                var commentId = DateTime.now().millisecondsSinceEpoch.toString();
                noticeDbRef.doc(widget.detailNotice.id).collection('Comments').doc(commentId).set({
                  'id': commentId,
                  'comment': commentController.text,
                  'writer': authController.firestoreUser.value!.email,
                  'createdAt': DateTime.now()
                });

                setState(() {
                  commentController.text = '';
                });

                Get.snackbar('댓글 작성', '작성이 완료되었습니다.');
              },
              child: Text('작성'),
            )
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

  // back 버튼 클릭시 종료할건지 물어보는
  checkDeleteCommentPopup(NoticeCommentModel comment, context) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("삭제하시겠습니까?",
            style: TextStyle(fontFamily: 'Nanum', fontSize: 18)),
        actions: <Widget>[
          TextButton(
            child: Text(
              "확인",
              style: TextStyle(
                  fontFamily: 'Nanum', fontSize: 18, color: Colors.redAccent),
            ),
            onPressed: () {
              noticeDbRef.doc(widget.detailNotice.id).collection('Comments').doc(comment.id).delete();
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              "취소",
              style: TextStyle(
                  fontFamily: 'Nanum', fontSize: 18, color: Colors.grey),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
