import 'dart:io';

import 'package:dotenv/dotenv.dart';

// ignore_for_file: avoid_print

Future<void> main() async {
  try {
    // .env.script 파일 로드
    final env = DotEnv()..load(['.env.script']);

    // 환경변수 읽기
    final swaggerUrl = env['SWAGGER_URL'];

    // 필수 환경변수 확인
    if (swaggerUrl == null || swaggerUrl.isEmpty) {
      throw Exception('.env.script에서 SWAGGER_URL이 설정되지 않았습니다');
    }

    print('');
    print('OpenAPI 생성을 시작합니다...');
    print('Swagger URL: $swaggerUrl');

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
      'sourceFolder=generate',
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
      throw Exception('OpenAPI 생성에 실패했습니다\n${result.stderr}');
    }

    print('OpenAPI 생성 완료');
    print('Dart 포맷팅을 시작합니다...');

    // Dart 포맷팅 실행
    final formatResult = await Process.run('fvm', [
      'dart',
      'format',
      './lib/generate/**/*.dart',
    ]);

    if (formatResult.exitCode != 0) {
      throw Exception('Dart 포맷팅에 실패했습니다\n${formatResult.stderr}');
    }

    print('Dart 포맷팅 완료');
    print('✓ OpenAPI 생성 및 포맷팅이 완료되었습니다');
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
