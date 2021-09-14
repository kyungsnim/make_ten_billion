import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/link.dart';
import 'package:make_ten_billion/models/models.dart';

class KakaoShareManager {
  static final KakaoShareManager _manager = KakaoShareManager._internal();

  factory KakaoShareManager() {
    return _manager;
  }

  KakaoShareManager._internal() {
    // 초기화 코드
  }

  void initializeKakaoSDK() {
    String kakaoAppKey = "b6cb50231a2306a68657a2a6e07a1d3b";
    KakaoContext.clientId = kakaoAppKey;
  }

  Future<bool> isKakaotalkInstalled() async {
    bool installed = await isKakaoTalkInstalled();
    return installed;
  }

  void shareMyCode(NoticeModel notice) async {
    try {
      var template = _getTemplate(notice);
      var uri = await LinkClient.instance.defaultWithTalk(template);
      await LinkClient.instance.launchKakaoTalk(uri);
    } catch (error) {
      print(error.toString());
    }
  }

  DefaultTemplate _getTemplate(NoticeModel notice) {
    print('>>> ${notice.id}');
    Content content = Content(
        notice.title,
        Uri.parse(notice.imgUrl),
        Link(
          mobileWebUrl: Uri.parse('https://maketenbillion.page.link/?route=HowToBeRichDetail?id=${notice.id}'),
        ),
        description: notice.description);

    FeedTemplate template = FeedTemplate(content, buttons: [
      Button("웹으로 보기",
          Link(webUrl: Uri.parse("https://maketenbillion.page.link"))),
      Button("앱으로 보기",
          Link(webUrl: Uri.parse("https://maketenbillion.page.link"))),
    ]);

    return template;
  }
}
