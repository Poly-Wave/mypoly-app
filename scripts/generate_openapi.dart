import 'dart:io';

import 'package:dotenv/dotenv.dart';

// ignore_for_file: avoid_print

// MSA 서비스 목록
const List<String> services = ['users', 'bills'];

Future<void> main() async {
  try {
    // .env.script 파일 로드
    final env = DotEnv()..load(['.env.script']);

    // 환경변수 읽기
    final swaggerBaseUrl = env['SWAGGER_BASE_URL'];

    // 필수 환경변수 확인
    if (swaggerBaseUrl == null || swaggerBaseUrl.isEmpty) {
      throw Exception('.env.script에서 SWAGGER_BASE_URL이 설정되지 않았습니다');
    }

    print('');
    print('OpenAPI 생성을 시작합니다...');
    print('Swagger Base URL: $swaggerBaseUrl');

    // 각 서비스별로 OpenAPI 생성
    for (final service in services) {
      print('\n[$service] 서비스 OpenAPI 생성 중...');

      final swaggerUrl = '$swaggerBaseUrl/$service/v3/api-docs';
      print('URL: $swaggerUrl');

      // OpenAPI 생성 실행
      final result = await Process.run('fvm', [
        'dart',
        'run',
        'openapi_generator_cli:main',
        'generate',
        '-g',
        'dart-dio',
        '--global-property',
        'apis',
        '--global-property',
        'apiDocs=false',
        '--global-property',
        'apiTests=false',
        '--global-property',
        'models',
        '--global-property',
        'modelDocs=false',
        '--global-property',
        'modelTests=false',
        '--additional-properties',
        'serializationLibrary=json_serializable',
        '--additional-properties',
        'sourceFolder=generate/$service',
        '--additional-properties',
        'pubName=mypoly',
        '--additional-properties',
        'finalProperties=false',
        '-t',
        './mustaches',
        '-i',
        swaggerUrl,
      ]);

      if (result.exitCode != 0) {
        throw Exception('[$service] OpenAPI 생성에 실패했습니다\n${result.stderr}');
      }

      print('[$service] OpenAPI 생성 완료');
    }

    print('\nDart 포맷팅을 시작합니다...');

    // Dart 포맷팅 실행
    final formatResult = await Process.run('fvm', [
      'dart',
      'format',
      './lib/generate',
    ]);

    if (formatResult.exitCode != 0) {
      throw Exception('Dart 포맷팅에 실패했습니다\n${formatResult.stderr}');
    }

    print('Dart 포맷팅 완료');
    print('✓ 모든 서비스의 OpenAPI 생성 및 포맷팅이 완료되었습니다');
  } on FileSystemException catch (e) {
    stderr.writeln('오류: .env.script 파일을 찾을 수 없거나 접근할 수 없습니다');
    stderr.writeln('상세: ${e.message}');
    exit(1);
  } on Exception catch (e) {
    stderr.writeln('오류: ${e.toString()}');
    exit(1);
  } catch (e) {
    stderr.writeln('예상치 못한 오류: $e');
    exit(1);
  }
}
