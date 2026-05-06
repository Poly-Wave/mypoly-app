import 'package:json_annotation/json_annotation.dart';

enum Stage {
  @JsonKey(name: "RECEIVED")
  received(text: "RECEIVED", value: "RECEIVED"),
  @JsonKey(name: "REVIEW")
  review(text: "REVIEW", value: "REVIEW"),
  @JsonKey(name: "DECISION")
  decision(text: "DECISION", value: "DECISION"),
  @JsonKey(name: "COMPLETED")
  completed(text: "COMPLETED", value: "COMPLETED");

  final String text;
  final String value;

  const Stage({required this.text, required this.value});
}
