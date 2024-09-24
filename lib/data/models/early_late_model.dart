import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class EarlyLateModel {
  final int id;
  final DateTime? hours;
  final int? type;
  final int? employeeId;
  final int? applicationId;
  final DateTime? dayOffDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  EarlyLateModel({
    required this.id,
    this.hours,
    this.type,
    this.employeeId,
    this.applicationId,
    this.dayOffDate,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'hours': hours?.millisecondsSinceEpoch,
      'type': type,
      'employeeId': employeeId,
      'applicationId': applicationId,
      'dayOffDate': dayOffDate?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory EarlyLateModel.fromMap(Map<String, dynamic> map) {
    return EarlyLateModel(
      id: map['id'] as int,
      hours: map['hours'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['hours'] as int)
          : null,
      type: map['type'] != null ? map['type'] as int : null,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      applicationId:
          map['applicationId'] != null ? map['applicationId'] as int : null,
      dayOffDate: map['dayOffDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dayOffDate'] as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EarlyLateModel.fromJson(String source) =>
      EarlyLateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
