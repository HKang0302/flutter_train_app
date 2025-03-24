# Flutter Train App

기차 예매를 위한 Flutter 애플리케이션입니다.

## 주요 기능

- 출발역/도착역 선택
- 좌석 선택 (A1~D20)
- 다크모드/라이트모드 지원
- 역 정보 스왑 기능

## 개발 환경 설정

1. Flutter SDK 설치
2. 프로젝트 클론
3. 의존성 설치:

```bash
flutter pub get
```

4. 앱 실행:

```bash
flutter run
```

## 기술 스택

- Flutter
- Dart
- Material Design
- Cupertino Design

## 화면 구성

1. 홈 화면

   - 출발역/도착역 선택
   - 다크모드 토글
   - 좌석 선택 페이지 이동

2. 역 선택 화면

   - 역 목록 표시
   - 현재 선택된 역 표시
   - 역 검색 기능
   - 선택 시 홈 화면으로 자동 이동

3. 좌석 선택 화면
   - 좌석 선택 (A1~D20)
   - 예매 확인 다이얼로그
   - 선택한 좌석 표시
