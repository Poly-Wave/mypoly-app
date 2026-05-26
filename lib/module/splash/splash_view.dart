import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/generate/users/model/user_me_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/widget/modal/index.dart';

@RoutePage()
class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final startTime = useState(DateTime.now());

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        _handleSplashFlow(context, ref, startTime.value);
      });

      return null;
    }, []);

    return Scaffold();
  }

  Future<void> _handleSplashFlow(
    BuildContext context,
    WidgetRef ref,
    DateTime startTime,
  ) async {
    const minDuration = Duration(milliseconds: 2500);

    final initResult = await _initializeApp(context, ref, startTime);

    if (context.mounted && initResult.success) {
      final elapsed = DateTime.now().difference(startTime);

      if (elapsed < minDuration) {
        await Future.delayed(minDuration - elapsed);
      }

      final router = ref.read(routerProvider);
      if (context.mounted) {
        final user = initResult.user;

        if (user != null) {
          switch (user.onboardingStatus) {
            case .signup:
              router.replace(RegisterOnboardRoute());
              break;
            case .onboarding:
              router.replace(RegisterTopicRoute());
              break;
            case .category:
              router.replace(RegisterMoreRoute());
              break;
            default:
              router.replace(MainRoute());
              break;
          }
        } else {
          router.replace(OnboardRoute());
        }
      }
    }
  }

  Future<InitResult> _initializeApp(
    BuildContext context,
    WidgetRef ref,
    DateTime startTime,
  ) async {
    try {
      // 네트워크 연결 상태 확인
      final connectivityResult = await Connectivity().checkConnectivity();

      // 네트워크 연결 없음 (모든 결과가 none일 때만)
      if (connectivityResult.every((result) => result == .none)) {
        debugPrint('No network connection');

        if (context.mounted) {
          FlutterNativeSplash.remove();
          await showMPConfirmModal(
            context,
            barrierDismissible: false,
            title: "네트워크 연결 오류",
            content: "인터넷 연결을 확인해 주시기 바랍니다.",
            cancelText: "종료",
            okText: "재시도",
            onCancelTap: () {
              if (Platform.isIOS) {
                exit(0);
              } else {
                SystemNavigator.pop();
              }
            },
            onOkTap: () {
              context.pop();
              _handleSplashFlow(context, ref, startTime);
            },
          );
        }

        return InitResult(success: false, errorType: .network);
      }

      await Future.wait([
        ref.read(appAccessTokenProvider.notifier).init(),
        ref.read(appRefreshTokenProvider.notifier).init(),
      ]);

      await Future.wait([
        ref.read(appCategoriesProvider.notifier).fetch(),
        ref.read(appTermsProvider.notifier).fetch(),
      ]);

      UserMeResponse? user;

      try {
        user = await ref.read(appUserProvider.notifier).fetch();
      } catch (e) {
        debugPrint("$e");
      }

      return InitResult(success: true, user: user);
    } catch (e) {
      debugPrint('Initialization error: $e');

      if (context.mounted) {
        FlutterNativeSplash.remove();
        await showMPAlertModal(
          context,
          barrierDismissible: false,
          title: "오류",
          content: "초기화 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.",
          buttonText: "재시도",
          onTap: () {
            context.pop();
            _handleSplashFlow(context, ref, startTime);
          },
        );
      }

      return InitResult(success: false, errorType: .unknown);
    }
  }
}

class InitResult {
  final bool success;
  final UserMeResponse? user;
  final ErrorType? errorType;

  InitResult({required this.success, this.user, this.errorType});
}

enum ErrorType { network, unknown }
