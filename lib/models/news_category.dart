// Created By Amit Jangid 02/09/21

import 'package:gail_connect/utils/constants/http_constants.dart';

class NewsCategory {
  String body;
  String title;
  String eventDate;
  String url;

  NewsCategory(
      {required this.body,
        required this.title,
        required this.eventDate,
        required this.url});

  factory NewsCategory.fromJson(Map<String, dynamic> _newsCategoryJson) =>
      NewsCategory(
          body: _newsCategoryJson[kJsonBody],
          title: _newsCategoryJson[kJsonTitle],
          eventDate: _newsCategoryJson[kJsonEventDate],
          url: _newsCategoryJson["image_url"]);
}
