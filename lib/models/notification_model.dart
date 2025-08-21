class NotificationModel {
  String? title, subtitle, message, imageUrl, launchUrl, CREATED_ON;

  NotificationModel(
      {required this.title,
      required this.subtitle,
      required this.imageUrl,
      required this.message,
      required this.launchUrl,
      required this.CREATED_ON});

  factory NotificationModel.fromJson(
          Map<String, dynamic> _notificationDataJson) =>
      NotificationModel(
          title: _notificationDataJson["TITLE"],
          subtitle: _notificationDataJson["SUBTITLE"],
          message: _notificationDataJson["CONTENT"],
          imageUrl: _notificationDataJson["IMAGEURL"],
          launchUrl: _notificationDataJson["LAUNCHURL"],
          CREATED_ON: _notificationDataJson["CREATED_ON"]);
}
