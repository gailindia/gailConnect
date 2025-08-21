class WhatsNewIsClickedModel {
  String? is_clicked;
  double? cpfNo;

  WhatsNewIsClickedModel({
    required this.is_clicked,
    required this.cpfNo,
  });

  factory WhatsNewIsClickedModel.fromJson(
          Map<String, dynamic> _insertWhatsNewJson) =>
      WhatsNewIsClickedModel(
        cpfNo: _insertWhatsNewJson["CPF_NO"],
        is_clicked: _insertWhatsNewJson["IS_CLICKED"],
      );
}
