import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_ten_billion/controller/controllers.dart';
import 'package:make_ten_billion/models/notice_model.dart';

class HowToBeRichDetail extends StatelessWidget {
  NoticeController noticeController = NoticeController.to;
  var detailNotice;
  HowToBeRichDetail(this.detailNotice);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NoticeController>(builder: (_) {
      return detailNotice == null
          ? Container(child: CircularProgressIndicator())
          : Scaffold(
              appBar: AppBar(
                title: Text(detailNotice.title,
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CachedNetworkImage(
                            imageUrl: detailNotice.imgUrl),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              summaryArea(
                                  Icons.check,
                                  noticeController.notice.value!.createdAt
                                      .toString()
                                      .substring(0, 10)),
                              Spacer(),
                              // Text('${_.count}'),
                              InkWell(
                                onTap: () {
                                  noticeController.addLikeCount();
                                },
                                child: summaryArea(
                                  Icons.favorite_border,
                                  noticeController.notice.value!.like
                                      .toString(),
                                ),
                              ),
                              Spacer(),
                              summaryArea(
                                  Icons.remove_red_eye,
                                  (noticeController.notice.value!.read)
                                      .toString()),
                              Spacer(),
                              summaryArea(
                                  Icons.comment_rounded,
                                  (noticeController.notice.value!.read)
                                      .toString()),
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
                                child: Text(
                                    noticeController.notice.value!.description,
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
                        Divider(),

                        /// 본문 내용
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    noticeController.notice.value!.description,
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

  summaryArea(icon, text) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.grey,
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
