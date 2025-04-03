class MyNotesModel {
  String? cpfno, text, attach, createdon;
  double? id;

  MyNotesModel({
    required this.cpfno,
    required this.text,
    required this.attach,
    required this.id,
    required this.createdon,
  });

  factory MyNotesModel.fromJson(Map<String, dynamic> _mynotesJson) =>
      MyNotesModel(
        id: _mynotesJson["ID"],
        cpfno: _mynotesJson["CPF_NO"],
        text: _mynotesJson["TEXT"],
        attach: _mynotesJson["ATTACH"],
        createdon: _mynotesJson["CREATED_ON"],
      );
}


// "ID": 21.0,
//       "CPF_NO": "18327",
//       "TEXT": "Good morning",
//       "ATTACH": "183276KB8P3A4JIRCCRMCQFSFMEPE45YR1XLTTI9OEX7F.JPG",
//       "CREATED_ON": "2023-05-26T11:55:17"