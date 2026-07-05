import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/gender.dart';
import 'package:mypoly/generate/users/model/address_info_response.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/util/valid.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'register_more_provider.g.dart';

@riverpod
class OnboardGender extends _$OnboardGender {
  @override
  Gender build() => .man;

  void update(Gender value) => state = value;
}

@riverpod
class Birth extends _$Birth {
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  String build() {
    ref.onDispose(() {
      controller.dispose();
      focusNode.dispose();
    });

    return "";
  }

  void onChanged(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');

    if (digits.length > 8) {
      final trimmed = digits.substring(0, 8);
      controller.text = trimmed.toDotBirthDate;
      state = trimmed.toDotBirthDate;
      return;
    }

    final formatted = digits.toDotBirthDate;
    controller.text = formatted;
    state = formatted;
  }

  void onReset() {
    controller.text = "";
    state = "";
  }
}

@riverpod
class Keyword extends _$Keyword {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  Timer? _debounceTimer;

  @override
  String build() {
    ref.onDispose(() {
      _debounceTimer?.cancel();
      controller.dispose();
      focusNode.dispose();
    });

    return "";
  }

  void onChanged(String value) {
    _debounceTimer?.cancel();

    if (value.isEmpty) {
      ref.read(addressesPagingProvider.notifier).onReset();
      state = "";
      return;
    }

    state = value;

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      ref.read(addressesPagingProvider.notifier).onRefresh();
    });
  }

  void onReset() {
    _debounceTimer?.cancel();
    controller.text = "";
    state = "";
    ref.read(addressesPagingProvider.notifier).onReset();
  }
}

@riverpod
class LastKeyword extends _$LastKeyword {
  @override
  String build() => "";

  void update(String value) => state = value;

  void onReset() => state = "";
}

@riverpod
class AddressesPaging extends _$AddressesPaging {
  CancelToken? _currentCancelToken;

  @override
  PagingState<int?, AddressInfoResponse>? build() => null;

  Future<void> onRefresh() async {
    _currentCancelToken?.cancel();
    _currentCancelToken = null;
    state = PagingState();
  }

  void onReset() {
    _currentCancelToken?.cancel();
    _currentCancelToken = null;
    state = null;
  }

  Future<void> fetchNextPage() async {
    final prevState = state;

    if (prevState == null) {
      return;
    }

    if (prevState.isLoading) {
      return;
    }

    state = prevState.copyWith(isLoading: true, error: null);

    try {
      final keyword = ref.read(keywordProvider);
      final lastKey = prevState.keys?.last;
      final newKey = lastKey != null ? lastKey + 1 : 1;

      ref.read(lastKeywordProvider.notifier).update(keyword);

      _currentCancelToken?.cancel();
      _currentCancelToken = CancelToken();

      final response = await ref
          .read(userServiceProvider)
          .searchAddress(
            keyword: keyword,
            page: newKey,
            cancelToken: _currentCancelToken,
          );

      final newItems = response.addresses;
      final isLastPage =
          response.totalCount == (lastKey != null ? newKey + 1 : 1);

      state = prevState.copyWith(
        isLoading: false,
        pages: [...?prevState.pages, newItems],
        keys: [...?prevState.keys, newKey],
        hasNextPage: !isLastPage,
      );
    } catch (e) {
      state = prevState.copyWith(isLoading: false, error: e);
    }
  }
}

@riverpod
class Residence extends _$Residence {
  @override
  AddressInfoResponse? build() => null;

  void onShowBottomSheet(BuildContext context) {
    showMPBottomSheetModal(
      context,
      children: [
        MPBottomSheetCloseHeader(),
        SizedBox(
          height: 620.h,
          child: Consumer(
            builder: (_, ref, _) {
              final keyword = ref.watch(keywordProvider);
              final lastKeyword = ref.watch(lastKeywordProvider);
              final addressesPaging = ref.watch(addressesPagingProvider);

              return Column(
                crossAxisAlignment: .stretch,
                children: [
                  Padding(
                    padding: .symmetric(horizontal: 20.w),
                    child: MPInput(
                      controller: ref.read(keywordProvider.notifier).controller,
                      focusNode: ref.read(keywordProvider.notifier).focusNode,
                      onChanged: ref.read(keywordProvider.notifier).onChanged,
                      hintText: "지역(읍/면/동)을 입력해 주세요.",
                      innerRight: Row(
                        mainAxisSize: .min,
                        mainAxisAlignment: .end,
                        children: [
                          if (keyword.isNotEmpty) ...[
                            GestureDetector(
                              onTap: ref.read(keywordProvider.notifier).onReset,
                              child: MPSvgImage(SvgImage.icReset, size: 24),
                            ),
                          ],
                          MPWidth(16),
                        ],
                      ),
                      innerRightConstraints: .tightForFinite(
                        width: (keyword.isNotEmpty ? 24.r : 0) + 16.w,
                      ),
                    ),
                  ),
                  Expanded(
                    child: MPCustomScroll(
                      slivers: [
                        if (addressesPaging != null)
                          SliverPadding(
                            padding: .symmetric(horizontal: 20.w),
                            sliver: PagedSliverList(
                              state: addressesPaging,
                              fetchNextPage: ref
                                  .read(addressesPagingProvider.notifier)
                                  .fetchNextPage,
                              builderDelegate:
                                  PagedChildBuilderDelegate<
                                    AddressInfoResponse
                                  >(
                                    itemBuilder: (context, item, index) {
                                      if (index == 0) {
                                        return Column(
                                          crossAxisAlignment: .stretch,
                                          children: [
                                            MPHeight(10),
                                            Text(
                                              "‘$lastKeyword' 검색 결과",
                                              style: Pretendard.medium.set(
                                                size: 14,
                                                height: 1.45,
                                                color: ColorStyles.gray30,
                                              ),
                                            ),
                                            MPHeight(2),
                                            RegisterMoreAddressItem(
                                              item: item,
                                              onTap: () {
                                                state = item;
                                                context.pop();
                                              },
                                            ),
                                          ],
                                        );
                                      }

                                      return RegisterMoreAddressItem(
                                        item: item,
                                        onTap: () {
                                          state = item;
                                          context.pop();
                                        },
                                      );
                                    },
                                    firstPageProgressIndicatorBuilder: (_) =>
                                        Column(
                                          children: [
                                            MPHeight(120),
                                            MPLoading(),
                                          ],
                                        ),
                                    firstPageErrorIndicatorBuilder: (_) =>
                                        RegisterMoreAddressNoItemsFoundIndicator(
                                          lastKeyword: lastKeyword,
                                          onRefreshTap: ref
                                              .read(
                                                addressesPagingProvider
                                                    .notifier,
                                              )
                                              .onRefresh,
                                        ),
                                    newPageProgressIndicatorBuilder: (_) =>
                                        MPSafeBox(
                                          bottom: true,
                                          child: Center(
                                            child: MPLoading(size: 18),
                                          ),
                                        ),
                                    newPageErrorIndicatorBuilder: (_) =>
                                        const SizedBox.shrink(),
                                    noItemsFoundIndicatorBuilder: (_) =>
                                        RegisterMoreAddressNoItemsFoundIndicator(
                                          lastKeyword: lastKeyword,
                                          onRefreshTap: ref
                                              .read(
                                                addressesPagingProvider
                                                    .notifier,
                                              )
                                              .onRefresh,
                                        ),
                                    noMoreItemsIndicatorBuilder: (_) =>
                                        MPSafeBox(bottom: true),
                                  ),
                            ),
                          )
                        else
                          SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: .stretch,
                              children: [
                                MPHeight(110),
                                Text(
                                  "현재 거주 중인 지역을\n검색해 주세요",
                                  textAlign: .center,
                                  style: Pretendard.semiBold.set(
                                    size: 18,
                                    height: 1.4,
                                    color: ColorStyles.white,
                                  ),
                                ),
                                MPHeight(8),
                                Text(
                                  "예: 시/도를 제외한 강동구, 암사동 등",
                                  textAlign: .center,
                                  style: Pretendard.medium.set(
                                    size: 15,
                                    height: 1.45,
                                    color: ColorStyles.gray30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class RegisterMoreAddressNoItemsFoundIndicator extends StatelessWidget {
  final String lastKeyword;
  final void Function() onRefreshTap;

  const RegisterMoreAddressNoItemsFoundIndicator({
    super.key,
    required this.lastKeyword,
    required this.onRefreshTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .stretch,
      children: [
        MPHeight(10),
        Text(
          "‘$lastKeyword' 검색 결과",
          style: Pretendard.medium.set(
            size: 14,
            height: 1.45,
            color: ColorStyles.gray30,
          ),
        ),
        MPHeight(75),
        Text(
          "검색 결과가 없어요\n동네 이름을 다시 확인해 주세요",
          textAlign: .center,
          style: Pretendard.semiBold.set(
            size: 18,
            height: 1.4,
            color: ColorStyles.white,
          ),
        ),
        MPHeight(8),
        Text(
          "예: 시/도를 제외한 강동구, 암사동 등",
          textAlign: .center,
          style: Pretendard.medium.set(
            size: 15,
            height: 1.45,
            color: ColorStyles.gray30,
          ),
        ),
        MPHeight(20),
        Center(
          child: GestureDetector(
            onTap: onRefreshTap,
            child: Container(
              height: 38.h,
              padding: .symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                borderRadius: .circular(8.r),
                border: .all(width: 1.r, color: ColorStyles.gray60),
                color: ColorStyles.gray70,
              ),
              child: Row(
                mainAxisSize: .min,
                children: [
                  Text(
                    "다시 검색하기",
                    style: Pretendard.semiBold.set(
                      size: 14,
                      color: ColorStyles.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RegisterMoreAddressItem extends StatelessWidget {
  final AddressInfoResponse item;
  final void Function() onTap;

  const RegisterMoreAddressItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 47.h,
        alignment: .centerLeft,
        child: Text(
          "${item.sido} ${item.sigungu} ${item.emdName}",
          style: Pretendard.medium.set(size: 16, color: ColorStyles.white),
        ),
      ),
    );
  }
}

@riverpod
bool onMoreEnabled(Ref ref) {
  final birth = ref.watch(birthProvider);
  final residence = ref.watch(residenceProvider);

  if (residence == null) return false;
  if (!Valid.isBirthDate(birth)) return false;

  return true;
}

Future<void> onMore(WidgetRef ref) async {
  final context = ref.context;

  context.unFocus();

  final gender = ref.read(onboardGenderProvider);
  final birthDate = ref.read(birthProvider).replaceAll(".", "");
  final residence = ref.read(residenceProvider);

  if (residence == null) {
    return;
  }

  context.loaderOverlay.show();

  try {
    await ref
        .read(appUserProvider.notifier)
        .updateProfile(
          gender: gender,
          birthDate: birthDate,
          sido: residence.sido,
          sigungu: residence.sigungu,
          emdName: residence.emdName,
          isOnboard: true,
        );

    if (!context.mounted) return;
    context.loaderOverlay.hide();
    context.replaceRoute(RegisterCompleteRoute());
  } catch (e) {
    context.loaderOverlay.hide();
    showMPAlertModal(context, title: "추가 정보 입력에 실패하였습니다.\n잠시 후 다시 시도해 주세요.");
  }
}
