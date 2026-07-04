enum SimilarTopicSort {
  hotDebate(value: "HOT_DEBATE", label: "쟁쟁한"),
  trending(value: "TRENDING", label: "요즘 핫한"),
  monthlyPopular(value: "MONTHLY_POPULAR", label: "이번달 인기");

  final String value;
  final String label;

  const SimilarTopicSort({required this.value, required this.label});
}
