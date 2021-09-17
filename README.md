# 100억 부자 되기
- 컨셉 : "부자생각" 어플처럼 재테크 관련 정보를 올리면 댓글달고 조회수가 카운팅되는 어플 (회원가입시 댓글 가능)

# 화면구성 : UI는 고급유머 개드립 정도 참고할 것
- 부자되는 방법
- 부자 동기 부여
- 투자에 대한 생각

# 수익구조
- 배너광고, 전면광고

# To do list
- 댓글 달기 위한 로그인 페이지
- 로그인 안해도 컨텐츠들 보이도록 해야 함
- 공유하기 기능
- 수정 기능

# 진행사항
## 2021.09.01(수)
- 3개 페이지 만들기
- 부자되는 방법, 글 상세목록 확인 페이지 구현 중
- 로그인 안해도 컨텐츠 보이도록 구현하는 중 오류 상태 (상세 페이지로 넘어갈 때 오류남)

## 2021.09.02(목)
- 댓글 목록 조회, 댓글 작성, 본인댓글 삭제
- 게시글 등록 페이지 디자인 수정, 이미지 첨부 가능토록 구현 완료

## 2021.09.04(토)
- 공유하기 기능 추가
- 불필요한 코드 정리

## 2021.09.07(화)
- 배너광고 추가
- 짝수 초에 앱 실행시 전면광고 보이는 로직 추가

## 2021.09.08(수)
- 기존 게시글 수정 기능 추가
- 앱 아이콘 생성
- 앱 스플래쉬 스크린 생성
- 로그인 안하면 댓글은 보이나 로그인해야 댓글 남길 수 있도록 구현 완료
- 스플래쉬 스크린 크기 조정 필요
- 관리자 아니면 글작성 안되도록 설정 필요
- 3페이지 모두 구성 완료

## 2021.09.09(목)
- 스플래쉬 스크린 크기 조정 완료
- 관리자 아니면 글작성 안되도록 설정 완료
- 알림 메시지 구현 중

## 2021.09.10(금)
- 공지사항 게시판 추가
- apk 초안 설치파일 생성

## 2021.09.11(토)
- 글씨체 빙그레싸만코체로 변경
- 게시글 삭제시 Storage image 삭제 로직 추가
- 관리자는 광고 안나오도록 변경

## 2021.09.13(월)
- 동적링크 이용해서 카톡에 표현되게 만들어야 함

## 2021.09.14(화)
- 동적링크 생성은 되고 카톡 공유는 되지만, 링크타고 앱 실행시 문제 있음
- 초안 출시 검토 보냄 (광고 코드 바꿔야 함)

## 2021.09.15(수)
- 동적링크 생성 및 카카오톡 공유 완료

## 2021.09.16(목)
- 푸시 알림 소스 추가
- 푸시 알림 구현 80% 완료
- 알림메시지 발송페이지 별도 생성

## 2021.09.17(금)
- 설정 페이지 추가 (알림설정 및 로그인/로그아웃)

# Complete list
- 3개 페이지 만들기
- 게시글 작성 화면 UI 변경 및 사진첨부 기능 추가

# 필요사항
- 앱 아이콘
- 폰트

# DB 접속 방법
1. 해당 계정으로 로그인
2. firebase.google.com 접속
3. Make ten billion 프로젝트 클릭
4. Firestore Database 클릭 (DB에 해당하는 영역)

# Google Cloud Platform 결제
1. Firebase.google.com 접속
2. Storage > Usage > 우측 하단 사용량 및 결제에서 보기 > 세부정보 및 설정 탭
3. 요금제 수 > 종량제 (Blaze) 요금제 선택 > 결제정보 등록

# Dynamic link 구현하기
- 처음에 main.dart 쪽에 하려고 했는데, MyApp initState 쪽에서 getDynamicLink를 처리하니 GetMaterialApp을 빌드하지 않아서 핫리로드시 오류가 생김
- 때문에 home.dart에서 처리하는 걸로 방식 변경
    - WidgetsBindingObserver 셋팅해주기 : Background 있을 때 Foreground 처리해주는..
    - initState, dispose에 addObserver, removeObserver 추가
    - getDynamicLink() 함수 추가

# trouble shooting
- android 출시하려면 appbundle이 필요 => flutter build appbundle