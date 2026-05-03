import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/agenda/main_agenda_view.dart';
import 'package:mypoly/module/main/home/main_home_view.dart';
import 'package:mypoly/module/main/main_provider.dart';
import 'package:mypoly/module/main/subsidy/main_subsidy_view.dart';
import 'main_bottom_bar.dart';
import 'main_app_bar.dart';

@RoutePage()
class MainView extends HookConsumerWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        FlutterNativeSplash.remove();
      });

      return null;
    }, []);

    final mainPage = ref.watch(mainPageProvider);

    return Scaffold(
      appBar: MainAppBar(currentIndex: mainPage),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: IndexedStack(
              index: mainPage,
              children: [MainAgendaView(), MainHomeView(), MainSubsidyView()],
            ),
          ),
        ],
      ),
      bottomNavigationBar: MainBottomBar(
        currentIndex: mainPage,
        onTap: ref.read(mainPageProvider.notifier).update,
      ),
    );
  }
}
