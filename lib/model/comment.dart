import 'package:flutter/material.dart';

class Comment {
  final dynamic id;
  final dynamic content;
  final dynamic commentedBy;
  final dynamic commented;
  final dynamic uploadId;
  final dynamic createdAt;
 

  Comment({
    @required this.id,
    this.content,
    this.commentedBy,
    this.commented,
    this.uploadId,
    this.createdAt,
    
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        content: json['content'],
        commentedBy: json['commentedBy'],
        commented: json['commented'],
        uploadId: json['uploadId'],
        createdAt:json['createdAt'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'commented': commented,
        'commentedBy': commentedBy,
        'content': content,
        'uploadId': uploadId,
        'createdAt':createdAt,
      };
}
