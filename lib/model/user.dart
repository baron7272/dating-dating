import 'package:flutter/material.dart';

class User {
  final dynamic email;
  final dynamic id;
    final dynamic horoscope;

  final dynamic username;
  final dynamic photoUrl;
  final dynamic status;
  final dynamic about;
  final dynamic age;
  final dynamic childrenAge;
  final dynamic club;
  final dynamic color;
  final dynamic country;
  final dynamic firebaseId;
  final dynamic drink;
  final dynamic education;
  final dynamic smoke;
  final dynamic type;
  final dynamic religion;
  final dynamic relationshipType;
  final dynamic politics;
  final dynamic pets;
  final dynamic occupation;
  final dynamic location;
  final dynamic isCode;
  final dynamic kids;
  final dynamic zodiac;
  final dynamic gender;

  User(
      {this.horoscope,
      this.gender,
      this.photoUrl,
      this.childrenAge,
      this.club,
      this.color,
      this.drink,
      this.education,
      this.smoke,
      this.type,
      this.religion,
      this.relationshipType,
      this.politics,
      this.pets,
      this.location,
      this.isCode,
      this.kids,
      this.zodiac,
      @required this.id,
      this.email,
      this.occupation,
      this.username,
      this.country,
      this.age,
      this.about,
      this.status,this.firebaseId});

  factory User.fromJson(Map<String, dynamic> json) => User(
      horoscope:json['horoscope'],
      id: json['id'],
      photoUrl: json['photoUrl'],
      childrenAge: json['childrenAge'],
      club: json['club'],
      color: json['color'],
      drink: json['drink'],
      education: json['education'],
      smoke: json['smoke'],
      email: json['email'],
      username: json['username'],
      age: json['age'],
      gender: json['gender'],
      type: json['type'],
      religion: json['religion'],
      occupation: json['occupation'],
      relationshipType: json['relationshipType'],
      country: json['country'],
      about: json['about'],
      politics: json['politics'],
      status: json['status'],
      kids: json['kids'],
      pets: json['pets'],
      location: json['location'],
      zodiac: json['zodiac'],
      isCode: json['isCode'],
      firebaseId:json['firebaseId']);

  Map<String, dynamic> toMap() => {
        'horoscope':horoscope,
        'id': id,
        'childrenAge': childrenAge,
        'location': location,
        'kids': kids,
        'status': status,
        'pets': pets,
        'isCode': isCode,
        'photoUrl': photoUrl,
        'club': club,
        'username': username,
        'age': age,
        'email': email,
        'gender': gender,
        'color': color,
        'drink': drink,
        'education': education,
        'occupation': occupation,
        'smoke': smoke,
        'country': country,
        'about': about,
        'type': type,
        'religion': religion,
        'relationshipType': relationshipType,
        'politics': politics,
        'zodiac': zodiac,
        'firebaseId':firebaseId,
      };
}
