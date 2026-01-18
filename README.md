# MyPOLY

## 세팅 방법

### 1. FVM 설정

```bash
fvm use
```

### 2. Melos 설치

```bash
dart pub global activate melos
```

### 3. 비공개 파일 추가

프로젝트 루트에 배치해주세요:
- `.env` - Production 환경 설정
- `.env.dev` - Development 환경 설정
- `.env.script` - 스크립트 환경 설정
- `service-account.json` - Firebase Distribution 용 키

`android/` 경로에 배치해주세요:
- `MPDebug.jks` - Android 서명 키
- `MPRelease.jks` - Android 서명 키

## 주요 명령어

```bash
# 프로젝트 초기화
melos bootstrap

# 클린 빌드
melos run clean
```
