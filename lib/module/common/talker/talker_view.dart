import 'package:auto_route/auto_route.dart';
import 'package:mypoly/util/logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class TalkerView extends TalkerScreen {
  TalkerView({super.key}) : super(talker: AppLogger.instance.talker);
}
