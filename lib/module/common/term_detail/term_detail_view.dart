import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/module/common/term_detail/term_detail_provider.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class TermDetailProviderView extends StatelessWidget {
  final TermsResponse data;

  const TermDetailProviderView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        termProvider.overrideWithValue(data),
        termHtmlProvider.overrideWith(TermHtml.new),
      ],
      child: TermDetailView(),
    );
  }
}

class TermDetailView extends HookConsumerWidget {
  const TermDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final term = ref.watch(termProvider);
    final termHtml = ref.watch(termHtmlProvider);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        ref.read(termHtmlProvider.notifier).fetch(context);
      });

      return null;
    }, []);

    if (termHtml == null) {
      return Scaffold(
        appBar: MPAppBar(context, text: term.title),
        body: MPSafeBox(bottom: true, child: Center(child: MPLoading())),
      );
    }

    return Scaffold(
      appBar: MPAppBar(context, text: term.title),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: MPSafeBox(
                bottom: true,
                child: Padding(
                  padding: .symmetric(horizontal: 20.w),
                  child: Html(data: termHtml),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
