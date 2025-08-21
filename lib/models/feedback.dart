// Created By Amit Jangid 09/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class FeedbackData {
  String message;
  int statusCode;
  List<MFeedback> feedbackList;

  FeedbackData({required this.message, required this.statusCode, required this.feedbackList});

  factory FeedbackData.fromJson(Map<String, dynamic> _feedbackDataJson) => FeedbackData(
        message: _feedbackDataJson[kJsonMessage],
        statusCode: _feedbackDataJson[kJsonStatusCode],
        feedbackList: (_feedbackDataJson[kJsonData] != null && _feedbackDataJson[kJsonData].isNotEmpty)
            ? _feedbackDataJson[kJsonData].map<MFeedback>((_feedbackJson) => MFeedback.fromJson(_feedbackJson)).toList()
            : [],
      );
}

class MFeedback {
  String? questionId;
  String? questionText;
  String? questionType;
  String? surveyId;
  String? surveyTitle;
  String ansText;
  List<QuestOption> questOptionList;

  MFeedback({
    required this.questionId,
    required this.questionText,
    required this.questionType,
    required this.surveyId,
    required this.surveyTitle,
    required this.questOptionList,
    this.ansText = '',
  });

  factory MFeedback.fromJson(Map<String, dynamic> _feedbackJson) => MFeedback(
        questionId: _feedbackJson[kJsonQuestionId],
        questionText: _feedbackJson[kJsonQuestionText],
        questionType: _feedbackJson[kJsonQuestionType],
        surveyId: _feedbackJson[kJsonSurveyId],
        surveyTitle: _feedbackJson[kJsonSurveyTitle],
        questOptionList: _feedbackJson[kJsonQuestionOptions]
            .map<QuestOption>((_questOptionJson) => QuestOption.fromJson(_questOptionJson))
            .toList(),
      );
}

class QuestOption {
  String? value;
  bool isAnsSelected;

  QuestOption({required this.value, this.isAnsSelected = false});

  factory QuestOption.fromJson(Map<String, dynamic> _questOptionJson) =>
      QuestOption(value: _questOptionJson[kJsonValue]);
}
