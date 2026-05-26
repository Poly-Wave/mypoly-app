import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/common/topic/topic_view.dart';

@RoutePage()
class RegisterTopicView extends HookConsumerWidget {
  const RegisterTopicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);

    return TopicView(isOnboard: true);
  }
}
