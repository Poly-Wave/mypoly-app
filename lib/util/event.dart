import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mypoly/util/logger.dart';

class Event {
  Event._();

  static Future<void> send({
    required String name,
    Map<String, Object>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    try {
      await FirebaseAnalytics.instance.logEvent(
        name: name,
        parameters: parameters,
        callOptions: callOptions,
      );
    } catch (e) {
      AppLogger.instance.talker.handle(e);
    }
  }
}
