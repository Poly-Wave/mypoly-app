class PopularSubsidy {
  final String status;          // 진행상태
  final String applyPeriod;     // 접수기간
  final String remainingPeriod; // 남은기간
  final String title;           // 제목
  final String description;     // 내용
  final String subsidyAmount;   // 지급금액 (단위: 만원)

  PopularSubsidy({
    required this.status,
    required this.applyPeriod,
    required this.remainingPeriod,
    required this.title,
    required this.description,
    required this.subsidyAmount,
  });
}