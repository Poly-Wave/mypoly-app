abstract interface class MPDateRangeOption {
  String get text;
  bool get isCustom;

  List<MPDateRangeOption> get options;
}

enum MPDateRange implements MPDateRangeOption {
  all(text: "전체"),
  oneMonth(text: "1개월"),
  threeMonths(text: "3개월"),
  custom(text: "직접입력", isCustom: true);

  @override
  final String text;

  @override
  final bool isCustom;

  @override
  List<MPDateRange> get options => values;

  const MPDateRange({required this.text, this.isCustom = false});
}
