import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class BookingModel {
  final String? id;
  final String customersName;
  final int startDate;
  final int endDate;
  final String roomId;
  BookingModel({
    this.id,
    required this.customersName,
    required this.startDate,
    required this.endDate,
    required this.roomId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'customersName': customersName,
      'startDate': startDate,
      'endDate': endDate,
      'roomId': roomId,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic> map) {
    return BookingModel(
      id: map['id'] != null ? map['id'] as String : null,
      customersName: map['customersName'] as String,
      startDate: map['startDate'] as int,
      endDate: map['endDate'] as int,
      roomId: map['roomId'] as String,
    );
  }
  factory BookingModel.fromDocumentSnapshot(DocumentSnapshot map) {
    return BookingModel(
      id: map.id,
      customersName: (map.data() as Map)['customersName'] ?? "",
      startDate: (map.data() as Map)['startDate'] ?? 0,
      endDate: (map.data() as Map)['endDate'] ?? "",
      roomId: (map.data() as Map)['roomId'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
