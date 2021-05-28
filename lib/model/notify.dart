import 'package:flutter/material.dart';

class Notify {
  final int id;
  final dynamic urlLink;
  final dynamic title;
  final dynamic content;
  final dynamic type;
  final dynamic value;
  final dynamic createdAt;
 
  Notify({
    @required this.id,
    this.urlLink,
    this.content,
    this.value,
    this.type,
    this.title,
    this.createdAt,
  });

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json['id'],
        urlLink: json['urlLink'],
        content: json['content'],
        title: json['title'],
        value: json['value'],
        type: json['type'],  
        createdAt: json['createdAt'],       
      );

    Map<String, dynamic> toMap() => {
        'id': id,
        'urlLink': urlLink,
        'content': content,
        'title': title,
        'value': value,
        'type':type,
        'createdAt':createdAt,
      };
 }




















