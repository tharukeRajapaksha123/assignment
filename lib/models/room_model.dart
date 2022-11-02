import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  RoomModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
      price: map['price'] as double,
    );
  }
  factory RoomModel.fromDocumentSnapshot(DocumentSnapshot map) {
    return RoomModel(
      id: map.id,
      name: (map.data() as Map)["name"] ?? "",
      description: (map.data() as Map)['description'] ?? "",
      imageUrl: (map.data() as Map)['imageUrl'] ?? "",
      price: (map.data() as Map)['price'] * 1.0 ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
