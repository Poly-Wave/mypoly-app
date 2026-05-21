abstract interface class MPDateRangeOption {
  String get text;
  bool get isAll;
  bool get isCustom;
  int? get months;

  List<MPDateRangeOption> get options;
}

enum MPDateRange implements MPDateRangeOption {
  all(text: "전체", isAll: true),
  oneMonth(text: "1개월", months: 1),
  threeMonths(text: "3개월", months: 3),
  custom(text: "직접입력", isCustom: true);

  @override
  final String text;

  @override
  final bool isAll;

  @override
  final bool isCustom;

  @override
  final int? months;

  @override
  List<MPDateRange> get options => values;

  const MPDateRange({
    required this.text,
    this.isAll = false,
    this.isCustom = false,
    this.months,
  });
}
