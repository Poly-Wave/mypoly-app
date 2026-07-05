import 'package:json_annotation/json_annotation.dart';

enum Stage {
  @JsonKey(name: "RECEIVED")
  received(text: "RECEIVED", value: "접수"),
  @JsonKey(name: "REVIEW")
  review(text: "REVIEW", value: "심사"),
  @JsonKey(name: "DECISION")
  decision(text: "DECISION", value: "의결"),
  @JsonKey(name: "COMPLETED")
  completed(text: "COMPLETED", value: "완료");

  final String text;
  final String value;

  const Stage({required this.text, required this.value});
}
