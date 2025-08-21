// To parse this JSON data, do
//
//     final regionModel = regionModelFromJson(jsonString);

import 'dart:convert';

RegionModel regionModelFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionModelToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  RegionModel({
    this.data,
  });

  List<Datum>? data;

  factory RegionModel.fromJson(Map<String, dynamic> json) => RegionModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.text,
    this.value,
  });

  String? text;
  String? value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}
