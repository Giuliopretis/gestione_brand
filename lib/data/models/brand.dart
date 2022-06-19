// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

Brand brandFromJson(String str) => Brand.fromJson(json.decode(str));

String brandToJson(Brand data) => json.encode(data.toJson());

@JsonSerializable()
class Brand {
  Brand({
    required this.name,
    required this.id,
    required this.createdAt,
  });

  @JsonKey(name: '_id')
  final String name;
  final String id;
  final DateTime createdAt;

  factory Brand.fromJson(Map<String, dynamic> json) {
    try {
      Brand gig = Brand(
        name: json["name"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
      return gig;
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "created_at": createdAt,
      };
}
