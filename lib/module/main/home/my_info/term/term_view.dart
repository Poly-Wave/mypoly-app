import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/module/main/home/my_info/my_info_view.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class TermView extends HookConsumerWidget {
  const TermView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final terms = ref.watch(appTermsProvider);

    return Scaffold(
      appBar: MPAppBar(context, text: "약관"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: Padding(
                padding: .symmetric(horizontal: 20.w),
                child: MPSafeColumn(
                  bottom: true,
                  crossAxisAlignment: .stretch,
                  children: terms
                      .map(
                        (term) => MyInfoGroupItem(
                          term.title,
                          onTap: () =>
                              context.pushRoute(TermDetailRoute(data: term)),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
