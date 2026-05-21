part of 'index.dart';

Future<T?> showMPBottomSheetModal<T>(
  BuildContext context, {
  bool barrierDismissible = true,
  bool enableDrag = false,
  required List<Widget> children,
}) async {
  return await showModalBottomSheet<T>(
    context: context,
    enableDrag: !barrierDismissible ? barrierDismissible : enableDrag,
    isScrollControlled: true,
    isDismissible: barrierDismissible,
    backgroundColor: ColorStyles.dim,
    builder: (innerContext) => PopScope(
      canPop: barrierDismissible,
      child: GestureDetector(
        onTap: innerContext.unFocus,
        child: Container(
          decoration: BoxDecoration(
            color: ColorStyles.black,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: MPSafeColumn(
            maintainBottomViewPadding: true,
            bottom: true,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      ),
    ),
  );
}

class MPBottomSheetHeader extends StatelessWidget {
  const MPBottomSheetHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return MPHeight(36);
  }
}

class MPBottomSheetCloseHeader extends StatelessWidget {
  final void Function()? onTap;

  const MPBottomSheetCloseHeader({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      padding: .symmetric(horizontal: 20.w),
      alignment: .centerRight,
      child: GestureDetector(
        onTap: onTap ?? context.pop,
        child: Text(
          "닫기",
          style: Pretendard.medium.set(size: 14, color: ColorStyles.gray30),
        ),
      ),
    );
  }
}

Future<void> showBoolBottomSheetModal(
  BuildContext context, {
  bool? value,
  String title = "투표 결과",
  String trueText = "찬성",
  String falseText = "반대",
  required void Function(bool?) onChanged,
}) async {
  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetCloseHeader(),
      HookBuilder(
        builder: (context) {
          final enabled = useState(false);
          final newValue = useState(value);

          return Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  title,
                  style: Pretendard.semiBold.set(
                    size: 16,
                    height: 1.45,
                    color: ColorStyles.white,
                  ),
                ),
                MPHeight(12),
                Row(
                  spacing: 10.w,
                  children: [
                    Expanded(
                      child: MPChip(
                        height: 39,
                        textSize: 16,
                        text: "전체",
                        isActive: newValue.value == null,
                        onTap: () {
                          if (newValue.value == null) return;

                          enabled.value = true;
                          newValue.value = null;
                        },
                      ),
                    ),
                    Expanded(
                      child: MPChip(
                        height: 39,
                        textSize: 16,
                        text: trueText,
                        isActive: newValue.value == true,
                        onTap: () {
                          if (newValue.value == true) return;

                          enabled.value = true;
                          newValue.value = true;
                        },
                      ),
                    ),
                    Expanded(
                      child: MPChip(
                        height: 39,
                        textSize: 16,
                        text: falseText,
                        isActive: newValue.value == false,
                        onTap: () {
                          if (newValue.value == false) return;

                          enabled.value = true;
                          newValue.value = false;
                        },
                      ),
                    ),
                  ],
                ),
                MPHeight(50),
                Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: MPButton(
                        "초기화",
                        style: .gray,
                        onTap: () => newValue.value = value,
                      ),
                    ),
                    Expanded(
                      child: MPButton(
                        "적용",
                        enabled: enabled.value,
                        onTap: () {
                          onChanged(newValue.value);
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
                MPHeight(20),
              ],
            ),
          );
        },
      ),
    ],
  );
}

Future<void> showWrapBottomSheetModal<T>(
  BuildContext context, {
  required List<(T, String)> values,
  List<T> value = const [],
  bool multiple = true,
  String title = "주제",
  required void Function(List<T>) onChanged,
}) async {
  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetCloseHeader(),
      HookBuilder(
        builder: (context) {
          final enabled = useState(false);
          final newValue = useState(value);

          void toggleValue(T value) {
            enabled.value = true;

            if (multiple) {
              newValue.value = newValue.value.contains(value)
                  ? newValue.value.where((item) => item != value).toList()
                  : [...newValue.value, value];
              return;
            }

            newValue.value = newValue.value.contains(value) ? [] : [value];
          }

          return Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  title,
                  style: Pretendard.semiBold.set(
                    size: 16,
                    height: 1.45,
                    color: ColorStyles.white,
                  ),
                ),
                MPHeight(12),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    MPChip(
                      text: "전체",
                      isActive: newValue.value.isEmpty,
                      onTap: () {
                        if (newValue.value.isEmpty) return;

                        enabled.value = true;
                        newValue.value = [];
                      },
                    ),
                    ...values.map(
                      (item) => MPChip(
                        text: item.$2,
                        isActive: newValue.value.contains(item.$1),
                        onTap: () => toggleValue(item.$1),
                      ),
                    ),
                  ],
                ),
                MPHeight(50),
                Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: MPButton(
                        "초기화",
                        style: .gray,
                        onTap: () => newValue.value = value,
                      ),
                    ),
                    Expanded(
                      child: MPButton(
                        "적용",
                        enabled: enabled.value,
                        onTap: () {
                          onChanged(newValue.value);
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
                MPHeight(20),
              ],
            ),
          );
        },
      ),
    ],
  );
}

Future<void> showDateRangeBottomSheetModal<T extends MPDateRangeOption>(
  BuildContext context, {
  required List<T> values,
  required (T, DateTime?, DateTime?) value,
  String title = "안건 생성일",
  required void Function((T, DateTime?, DateTime?)) onChanged,
}) async {
  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetCloseHeader(),
      HookBuilder(
        builder: (context) {
          final now = useMemoized(DateTime.now);
          final firstDay = useMemoized(() => now.subtractMonths(24), [now]);
          final lastDay = now;
          final enabled = useState(false);
          final newValue = useState(value);

          bool isSameMonth(DateTime a, DateTime b) {
            return a.year == b.year && a.month == b.month;
          }

          bool isBeforeMonth(DateTime a, DateTime b) {
            return a.year < b.year || (a.year == b.year && a.month < b.month);
          }

          DateTime moveMonth(DateTime date, int months) {
            final target = date.subtractMonths(-months);

            if (isBeforeMonth(target, firstDay)) return firstDay;
            if (isBeforeMonth(lastDay, target)) return lastDay;

            return target;
          }

          DateTime clampFocusedDay(DateTime date) {
            if (isBeforeMonth(date, firstDay)) return firstDay;
            if (isBeforeMonth(lastDay, date)) return lastDay;

            return date;
          }

          final focusedDay = useState(clampFocusedDay(value.$2 ?? now));
          final canMovePrevious = !isSameMonth(focusedDay.value, firstDay);
          final canMoveNext = !isSameMonth(focusedDay.value, lastDay);

          final void Function(int) moveFocusedMonth = useCallback((months) {
            focusedDay.value = moveMonth(focusedDay.value, months);
          }, [focusedDay, firstDay, lastDay]);

          final Widget Function({
            required String assetName,
            required bool enabled,
            required VoidCallback onTap,
          })
          calendarArrow = useCallback(({
            required assetName,
            required enabled,
            required onTap,
          }) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: enabled ? onTap : null,
              child: Container(
                height: 42.h,
                width: 24.w,
                alignment: .center,
                child: MPSvgImage(
                  assetName,
                  size: 16,
                  color: enabled ? null : ColorStyles.gray60,
                ),
              ),
            );
          }, []);

          final void Function(T) selectValue = useCallback((T item) {
            if (newValue.value.$1 == item && !item.isCustom) return;

            enabled.value = true;

            if (item.isAll || item.isCustom) {
              newValue.value = (item, null, null);
              return;
            }

            final months = item.months ?? 0;

            newValue.value = (item, now.subtractMonths(months), now);
          }, [enabled, newValue]);

          final VoidCallback selectCustomValue = useCallback(() {
            for (final item in values) {
              if (!item.isCustom) continue;

              selectValue(item);
              return;
            }
          }, [values, selectValue]);

          final T? customValue = useMemoized(() {
            for (final item in values) {
              if (item.isCustom) return item;
            }

            return null;
          }, [values]);

          final void Function(DateTime?, DateTime?, DateTime) selectDateRange =
              useCallback((start, end, focused) {
                final item = customValue;
                if (item == null) return;

                enabled.value = true;
                focusedDay.value = focused;
                newValue.value = (item, start, end);
              }, [customValue, enabled, focusedDay, newValue]);

          final Widget Function(DateTime?) dateRangeText = useCallback((date) {
            final hasDate = date != null;

            return Text(
              hasDate ? date.formatDotDate() : "날짜선택",
              style: Pretendard.medium.set(
                size: 14,
                color: hasDate ? ColorStyles.white : ColorStyles.gray60,
              ),
            );
          }, []);

          final canApply =
              enabled.value &&
              (!newValue.value.$1.isCustom ||
                  (newValue.value.$2 != null && newValue.value.$3 != null));

          return Padding(
            padding: .symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  title,
                  style: Pretendard.semiBold.set(
                    size: 16,
                    height: 1.45,
                    color: ColorStyles.white,
                  ),
                ),
                MPHeight(12),
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 74.w / 32.h,
                  ),
                  padding: .zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: values.length,
                  itemBuilder: (_, index) {
                    final item = values[index];

                    return MPChip(
                      height: 32,
                      padding: EdgeInsets.zero,
                      text: item.text,
                      isActive: newValue.value.$1 == item,
                      onTap: () => selectValue(item),
                    );
                  },
                ),
                MPHeight(10),
                MPChip(
                  height: 40,
                  widget: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: 8.w,
                          children: [
                            dateRangeText(newValue.value.$2),
                            MPSvgImage(SvgImage.icCalender, size: 16),
                          ],
                        ),
                      ),
                      MPSvgImage(SvgImage.icDateRange, size: 16),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: .center,
                          spacing: 8.w,
                          children: [
                            dateRangeText(newValue.value.$3),
                            MPSvgImage(SvgImage.icCalender, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  isActive: newValue.value.$1.isCustom,
                  onTap: selectCustomValue,
                ),
                AnimatedCrossFade(
                  firstChild: Container(),
                  secondChild: Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      MPHeight(12),
                      Container(
                        padding: .symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          color: ColorStyles.gray80,
                          borderRadius: .circular(8.r),
                        ),
                        child: Column(
                          crossAxisAlignment: .stretch,
                          children: [
                            MPHeight(10),
                            Row(
                              mainAxisAlignment: .center,
                              children: [
                                calendarArrow(
                                  assetName: SvgImage.arrowLeftCalender,
                                  enabled: canMovePrevious,
                                  onTap: () => moveFocusedMonth(-1),
                                ),
                                MPWidth(6),
                                Container(
                                  height: 42.h,
                                  padding: .symmetric(horizontal: 10.w),
                                  alignment: .center,
                                  child: Text(
                                    focusedDay.value.year.toString(),
                                    style: Pretendard.semiBold.set(
                                      size: 16,
                                      color: ColorStyles.white,
                                    ),
                                  ),
                                ),
                                MPWidth(4),
                                Container(
                                  height: 42.h,
                                  padding: .symmetric(horizontal: 10.w),
                                  alignment: .center,
                                  child: Text(
                                    "${focusedDay.value.month}월",
                                    style: Pretendard.semiBold.set(
                                      size: 16,
                                      color: ColorStyles.white,
                                    ),
                                  ),
                                ),
                                MPWidth(6),
                                calendarArrow(
                                  assetName: SvgImage.arrowRightCalender,
                                  enabled: canMoveNext,
                                  onTap: () => moveFocusedMonth(1),
                                ),
                              ],
                            ),
                            MPHeight(6),
                            Container(
                              height: 38.r,
                              margin: .symmetric(horizontal: 10.w),
                              child: Row(
                                mainAxisAlignment: .spaceBetween,
                                children: ["일", "월", "화", "수", "목", "금", "토"]
                                    .map(
                                      (text) => AspectRatio(
                                        aspectRatio: 1 / 1,
                                        child: Center(
                                          child: Text(
                                            text,
                                            style: Pretendard.medium.set(
                                              size: 13,
                                              color: ColorStyles.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            MPHeight(4),
                            TableCalendar(
                              headerVisible: false,
                              daysOfWeekVisible: false,
                              firstDay: firstDay,
                              lastDay: lastDay,
                              focusedDay: focusedDay.value,
                              calendarFormat: .month,
                              rangeSelectionMode: .toggledOn,
                              rangeStartDay: newValue.value.$2,
                              rangeEndDay: newValue.value.$3,
                              onPageChanged: (focused) {
                                focusedDay.value = focused;
                              },
                              onRangeSelected: selectDateRange,
                              onDaySelected: (selectedDay, focused) {
                                selectDateRange(
                                  selectedDay,
                                  selectedDay,
                                  focused,
                                );
                              },
                              rowHeight: 38.r,
                              calendarStyle: CalendarStyle(
                                isTodayHighlighted: false,
                                outsideDaysVisible: false,
                                tablePadding: .symmetric(horizontal: 5.67.w),
                                cellMargin: .symmetric(vertical: 2.h),
                                cellPadding: .zero,
                                rangeHighlightColor: ColorStyles.primary70,
                                rangeStartDecoration: BoxDecoration(
                                  color: ColorStyles.primary50,
                                  shape: BoxShape.circle,
                                ),
                                rangeEndDecoration: BoxDecoration(
                                  color: ColorStyles.primary50,
                                  shape: BoxShape.circle,
                                ),
                                todayDecoration: BoxDecoration(),
                                selectedDecoration: BoxDecoration(),
                                defaultTextStyle: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.white,
                                ),
                                weekendTextStyle: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.white,
                                ),
                                withinRangeTextStyle: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.white,
                                ),
                                rangeStartTextStyle: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.black,
                                ),
                                rangeEndTextStyle: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.black,
                                ),
                              ),
                            ),
                            MPHeight(8),
                          ],
                        ),
                      ),
                    ],
                  ),
                  sizeCurve: Curves.fastOutSlowIn,
                  crossFadeState: newValue.value.$1.isCustom
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),
                MPHeight(50),
                Row(
                  spacing: 20.w,
                  children: [
                    Expanded(
                      child: MPButton(
                        "초기화",
                        style: .gray,
                        onTap: () {
                          enabled.value = false;
                          newValue.value = value;
                        },
                      ),
                    ),
                    Expanded(
                      child: MPButton(
                        "적용",
                        enabled: canApply,
                        onTap: () {
                          onChanged((
                            newValue.value.$1,
                            newValue.value.$2,
                            newValue.value.$3,
                          ));
                          context.pop();
                        },
                      ),
                    ),
                  ],
                ),
                MPHeight(20),
              ],
            ),
          );
        },
      ),
    ],
  );
}
