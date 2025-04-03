// To parse this JSON data, do
//
//     final feedbackAnswer = feedbackAnswerFromJson(jsonString);

import 'dart:convert';

class FeedbackAnswer {
  List<QueAnss> queAnss;

  FeedbackAnswer({
    required this.queAnss,
  });

  factory FeedbackAnswer.fromRawJson(String str) =>
      FeedbackAnswer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FeedbackAnswer.fromJson(Map<String, dynamic> json) => FeedbackAnswer(
        queAnss: List<QueAnss>.from(
            json["Que_Anss"].map((x) => QueAnss.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ans_list": List<dynamic>.from(queAnss.map((x) => x.toJson())),
      };
}

class QueAnss {
  String que;
  String ans;
  String position;

  QueAnss({required this.que, required this.ans, required this.position});

  factory QueAnss.fromRawJson(String str) => QueAnss.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QueAnss.fromJson(Map<String, dynamic> json) => QueAnss(
        que: json["QUE"],
        ans: json["ANS"],
        position: json["INDEX"],
      );

  Map<String, dynamic> toJson() => {
        "QUE": que,
        "ANS": ans,
      };
}
