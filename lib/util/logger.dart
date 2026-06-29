import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_riverpod_logger/talker_riverpod_logger.dart';

final class AppLogger {
  AppLogger._() {
    final flavor = Flavor.fromString(appFlavor ?? 'prod');
    final enabled = flavor != Flavor.prod || !kReleaseMode;

    talker = TalkerFlutter.init(settings: TalkerSettings(enabled: enabled));
    dioLogger = TalkerDioLogger(
      talker: talker,
      settings: TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printErrorHeaders: false,
        responseFilter: (response) =>
            !response.requestOptions.path.startsWith("/sseusaems/v4"),
      ),
    );
    providerObserver = TalkerRiverpodObserver(talker: talker);
    routeObserver = TalkerRouteObserver(talker);
  }

  static final AppLogger instance = AppLogger._();

  late final Talker talker;
  late final TalkerDioLogger dioLogger;
  late final TalkerRiverpodObserver providerObserver;
  late final TalkerRouteObserver routeObserver;
}
