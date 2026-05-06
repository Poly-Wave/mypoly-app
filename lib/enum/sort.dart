abstract interface class MPSortOption {
  String get text;
  List<MPSortOption> get options;
}

enum MPSort implements MPSortOption {
  popular(text: "인기순", value: "POPULAR"),
  latest(text: "최신순", value: "LATEST");

  @override
  final String text;

  final String value;

  @override
  List<MPSort> get options => values;

  const MPSort({required this.text, required this.value});
}
