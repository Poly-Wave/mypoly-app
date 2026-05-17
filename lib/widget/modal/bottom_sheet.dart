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
                        enabled: newValue.value != null,
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

Future<void> showDateTimeBottomSheetModal<T extends MPDateRangeOption>(
  BuildContext context, {
  required List<T> values,
  required (T, DateTime?, DateTime?) value,
  String title = "안건 생성일",
  required void Function(T, DateTime?, DateTime?) onChanged,
}) async {
  showMPBottomSheetModal(
    context,
    children: [
      MPBottomSheetCloseHeader(),
      HookBuilder(
        builder: (context) {
          final enabled = useState(false);
          final newValue = useState(value);

          void selectValue(T value) {
            if (newValue.value.$1 == value) return;

            enabled.value = true;
            newValue.value = (value, null, null);
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
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.w,
                    mainAxisSpacing: 8.h,
                    childAspectRatio: 74.w / 32.h,
                  ),
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
                        enabled: enabled.value,
                        onTap: () {
                          onChanged(
                            newValue.value.$1,
                            newValue.value.$2,
                            newValue.value.$3,
                          );
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
