import 'package:flutter/material.dart';

class Home {
  final dynamic id;
  final dynamic contentUrl;
  final dynamic uploadedBy;
  final dynamic type;
  final dynamic week;
  final dynamic createdAt;

  Home({
    @required this.id,
    this.contentUrl,
    this.uploadedBy,
    this.type,
    this.week,
    this.createdAt,
    
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        id: json['id'],
        contentUrl: json['contentUrl'],
        uploadedBy: json['uploadedBy'],
        type: json['type'],
        week: json['week'],
        createdAt:json['createdAt'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'uploadedBy': uploadedBy,
        'contentUrl': contentUrl,
         'week': week,
         'createdAt':createdAt,
      };
}
