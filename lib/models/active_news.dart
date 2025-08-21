class ActiveNews {
  String? title, file, image, date ;

  ActiveNews({
    required this.title,
    required this.file,
    required this.image,
    required this.date,
  });

  factory ActiveNews.fromJson(Map<String, dynamic> _activeNewsJson) =>
      ActiveNews(
        title: _activeNewsJson["TITLE"],
        file: _activeNewsJson["UPLOAD_PDF"],
        image: _activeNewsJson["UPLOAD_IMG"],
        date: _activeNewsJson["EVENT_DATE"],


      );
}
