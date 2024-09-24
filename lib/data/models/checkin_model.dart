import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CheckInModel {
  final int? id;
  final int? employeeId;
  final DateTime? checkin;
  final String? location;
  final String? latitude;
  final String? longtitude;
  final int? meter;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  CheckInModel({
    this.id,
    this.employeeId,
    this.checkin,
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
      'checkin': checkin?.millisecondsSinceEpoch,
      'location': location,
      'latitude': latitude,
      'longtitude': longtitude,
      'meter': meter,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory CheckInModel.fromMap(Map<String, dynamic> map) {
    return CheckInModel(
      id: map['id'] != null ? map['id'] as int : null,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      checkin: map['checkin'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['checkin'] as int)
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

  factory CheckInModel.fromJson(String source) =>
      CheckInModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
