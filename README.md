# MyPOLY

## 세팅 방법

### 1. FVM 설정

```bash
fvm use
```

### 2. Melos 설치

```bash
dart pub global activate melos
dart pub global activate flutterfire_cli
```

### 3. 비공개 파일 추가

프로젝트 루트에 배치해주세요:
- `.env` - App 환경 설정
- `.env.prod` - Production 환경 설정
- `.env.dev` - Development 환경 설정
- `.env.script` - 스크립트 환경 설정
- `service-account.json` - Firebase Distribution 용 키

`lib/` 경로에 배치해주세요:
- `firebase_options_dev.dart` - Firebase 개발 환경 설정
- `firebase_options_prod.dart` - Firebase 프로덕션 환경 설정

`android/` 경로에 배치해주세요:
- `MPDebug.jks` - Android 서명 키
- `MPRelease.jks` - Android 서명 키

`android/app` 경로에 배치해주세요:
- `google-services.json` - Firebase Google Services 설정

`ios/Runner/Dev` 경로에 배치해주세요:
- `GoogleService-Info.plist` - Firebase Google Services 설정

`ios/Runner/Prod` 경로에 배치해주세요:
- `GoogleService-Info.plist` - Firebase Google Services 설정

## 프로젝트 구조

```
lib/
├── module/          # 페이지 및 기능 모듈 (splash, onboard, main 등)
├── provider/        # 전역 상태 관리 (Riverpod 프로바이더, 라우팅 등)
├── widget/          # 재사용 가능한 커스텀 위젯
├── style/           # 색상, 폰트 등 스타일 정의
├── asset/           # 생성된 자산 (svg, webp 등)
├── enum/            # 열거형 정의
└── main.dart        # 앱 진입점
```

## 주요 명령어

```bash
# 프로젝트 초기화
melos bootstrap

# 클린 빌드
melos run clean

# Build Runner Watch
melos run watch

# Spider Build Watch
melos run spider

# OpenAPI 기반 코드 생성
melos run gen

# lib/firebase_options_{flavor} 파일 생성
melos run flutterfire:configure

# 개발 배포
melos run deploy:dev
```
