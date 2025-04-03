class FeedbackQuestionsModel {
  double? id;
  String? questions, answer, validFrom, validTo;

  FeedbackQuestionsModel(
      {required this.id,
      required this.questions,
      required this.answer,
      required this.validFrom,
      required this.validTo});

  factory FeedbackQuestionsModel.fromJson(Map<String, dynamic> _queJson) =>
      FeedbackQuestionsModel(
        id: _queJson["ID"],
        questions: _queJson["QUESTION"],
        answer: _queJson["ANSWER"],
        validFrom: _queJson["VALID_FROM"],
        validTo: _queJson["VALID_TO"],
      );
}


// "lstInfo": [
//     {
//       "ID": 1.0,
//       "QUESTION": "How would you rate the overall user interface of the app?",
//       "ANSWER": "Excellent, Good, Average, Needs improvement",
//       "VALID_FROM": "2023-05-01T00:00:00",
//       "VALID_TO": "2023-05-18T00:00:00"
//     },