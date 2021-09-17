import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:make_ten_billion/models/models.dart';

class KakaoLinkWithDynamicLink {
  static final KakaoLinkWithDynamicLink _manager =
      KakaoLinkWithDynamicLink._internal();

  factory KakaoLinkWithDynamicLink() {
    return _manager;
  }

  KakaoLinkWithDynamicLink._internal() {
    // 초기화 코드
  }

  Future<bool> isKakaotalkInstalled() async {
    bool installed = await isKakaoTalkInstalled();
    return installed;
  }

  void shareMyCode(NoticeModel notice, String link) async {
    try {
      /// 카카오톡 FeedTemplate으로 공유메시지 만들기
      print(2);
      var template = getTemplate(notice, link);
      print(3);
      var uri = await LinkClient.instance.defaultWithTalk(template);
      print(4);
      /// 카카오톡 링크 공유
      await LinkClient.instance.launchKakaoTalk(uri);
    } catch (error) {
      print(error.toString());
    }
  }

  FeedTemplate getTemplate(NoticeModel notice, String link) {
    /// 카카오톡 공유를 위한 콘텐츠 구성
    Content content = Content(
        // title
        notice.title,
        // image url
        Uri.parse(notice.imgUrl),
        // 메시지 클릭시 이동되는 link
        Link(
          mobileWebUrl: Uri.parse(link),
        ),
        // description
        description: notice.description);

    /// 위에서 만든 콘텐츠를 이용해 카카오톡 공유 FeedTemplate 만들기
    FeedTemplate template = FeedTemplate(content, buttons: [
      Button("앱에서보기", Link(mobileWebUrl: Uri.parse(link))),
    ]);

    return template;
  }

  Future<String> buildDynamicLink(String whereNotice, String noticeId) async {
    /// Dynamic Links 에서 만든 URL Prefix
    String url = "https://maketenbillion.page.link";

    /// Dynamic Links 소스를 이용해 만들기
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: url,
        /// 딥링크 사용을 위한 특정 게시판-게시글ID 구성
        link: Uri.parse('$url/$whereNotice/$noticeId'),
        /// 안드로이드의 경우 packageName 추가
        androidParameters: AndroidParameters(
          packageName: "com.kyungsnim.make_ten_billion",
        ),
        /// iOS의 경우 bundleId 추가 (appStoreId와 TeamID가 필요)
        iosParameters: IosParameters(
            bundleId: "com.kyungsnim.makeTenBillion",
            appStoreId: '1554807824'));

    final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
    return dynamicUrl.shortUrl.toString();
  }
}
