// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  DataModel({
    required this.status,
    required this.message,
    required this.data,
    required this.errorCode,
    required this.errorMsg,
    required this.meta,
  });

  bool status;
  String message;
  List<UserData> data;
  String errorCode;
  String errorMsg;
  Meta meta;

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        status: json["status"],
        message: json["message"],
        data:
            List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
        errorCode: json["error_code"],
        errorMsg: json["error_msg"],
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error_code": errorCode,
        "error_msg": errorMsg,
        "meta": meta.toJson(),
      };
}

class UserData {
  UserData({
    required this.id,
    required this.name,
    required this.location,
    required this.occupation,
    required this.age,
    required this.image,
  });

  String id;
  String name;
  String location;
  String occupation;
  int age;
  String image;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        occupation: json["occupation"],
        age: json["age"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "occupation": occupation,
        "age": age,
        "image": image,
      };
}

class Meta {
  Meta({
    required this.pagination,
  });

  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    required this.count,
    required this.totalCount,
    required this.perPage,
    required this.prevPage,
    required this.currentPage,
    required this.nextPage,
  });

  String count;
  int totalCount;
  String perPage;
  int prevPage;
  String currentPage;
  int nextPage;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        count: json["count"],
        totalCount: json["total_count"],
        perPage: json["per_page"],
        prevPage: json["prev_page"],
        currentPage: json["current_page"],
        nextPage: json["next_page"],
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "total_count": totalCount,
        "per_page": perPage,
        "prev_page": prevPage,
        "current_page": currentPage,
        "next_page": nextPage,
      };
}
