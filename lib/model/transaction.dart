import 'package:flutter/material.dart';

class Transaction {
  final int id;
  final dynamic type;
  final dynamic source;
  final dynamic oldBalance;
  final dynamic newBalance;
  final dynamic amount;
  final dynamic createdAt;
 

  Transaction({
  @required this.id,
   this.amount,
   this.newBalance,
   this.oldBalance, 
   this.source,
   this.type,
   this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json['id'],
        amount: json['amount'],
        newBalance: json['newBalance'],
        source: json['source'],
        oldBalance: json['oldBalance'],
        type: json['type'],
        createdAt:json['createdAt'],
        );

  Map<String, dynamic> toMap() => {
        'id': id,
        'amount': amount,
        'oldBalance': oldBalance,
        'newBalance': newBalance,
        'source': source,
        'type': type,
        'createdAt':createdAt,
      };
}