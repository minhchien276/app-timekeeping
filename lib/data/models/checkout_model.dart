import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckOutModel {
  final int? id;
  final int? employeeId;
  final DateTime? checkout;
  final String? location;
  final String? latitude;
  final String? longtitude;
  final int? meter;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CheckOutModel({
    this.id,
    this.employeeId,
    this.checkout,
    this.location,
    this.latitude,
    this.longtitude,
    this.meter,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeId': employeeId,
      'checkout': checkout?.millisecondsSinceEpoch,
      'location': location,
      'latitude': latitude,
      'longtitude': longtitude,
      'meter': meter,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CheckOutModel.fromMap(Map<String, dynamic> map) {
    return CheckOutModel(
      id: map['id'] != null ? map['id'] as int : null,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      checkout: map['checkout'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkout'] as int)
          : null,
      location: map['location'] != null ? map['location'] as String : null,
      latitude: map['latitude'] != null ? map['latitude'] as String : null,
      longtitude:
          map['longtitude'] != null ? map['longtitude'] as String : null,
      meter: map['meter'] != null ? map['meter'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckOutModel.fromJson(String source) =>
      CheckOutModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
