import 'package:mypoly/generate/bills/model/vote_demographic_breakdown_response.dart';

enum AgeBand {
  ten(segment: "TEN", label: "10대"),
  twenty(segment: "TWENTY", label: "20대"),
  thirty(segment: "THIRTY", label: "30대"),
  forty(segment: "FORTY", label: "40대"),
  fifty(segment: "FIFTY", label: "50대"),
  sixtyPlus(segment: "SIXTY_PLUS", label: "60대 이상");

  final String segment;
  final String label;

  const AgeBand({required this.segment, required this.label});

  static AgeBand fromString(String value) => values.firstWhere(
    (e) => e.segment == value,
    orElse: () => AgeBand.ten,
  );
}

extension VoteDemographicBreakdownResponseAgeBandExtension
    on VoteDemographicBreakdownResponse {
  AgeBand get ageBand => AgeBand.fromString(segment);
}
