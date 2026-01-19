import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';

@RoutePage()
class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.replaceRoute(OnboardRoute());
      });

      return null;
    }, []);

    return Scaffold();
  }
}
