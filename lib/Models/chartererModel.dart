// To parse this JSON data, do
//
//     final chartererModel = chartererModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ChartererModel chartererModelFromJson(String str) =>
    ChartererModel.fromJson(json.decode(str));

String chartererModelToJson(ChartererModel data) => json.encode(data.toJson());

class ChartererModel {
  ChartererModel({
    required this.data,
    required this.errorFlag,
    required this.message,
  });

  List<Datum> data;
  String errorFlag;
  String message;

  factory ChartererModel.fromJson(Map<String, dynamic> json) => ChartererModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        errorFlag: json["error_flag"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error_flag": errorFlag,
        "message": message,
      };
}

class Datum {
  Datum({
    required this.chartererId,
    required this.chartererName,
    required this.tier,
  });

  String chartererId;
  String chartererName;
  String tier;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        chartererId: json["chartererId"],
        chartererName: json["chartererName"],
        tier: json["Tier"],
      );

  Map<String, dynamic> toJson() => {
        "chartererId": chartererId,
        "chartererName": chartererName,
        "Tier": tier,
      };
}
