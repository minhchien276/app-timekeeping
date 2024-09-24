import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class OvertimeModel {
  final int id;
  final int? employeeId;
  final int? applicationId;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime? dayOffDate;
  final num? hours;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  OvertimeModel({
    required this.id,
    this.employeeId,
    this.applicationId,
    this.startTime,
    this.endTime,
    this.dayOffDate,
    this.hours,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeId': employeeId,
      'applicationId': applicationId,
      'startTime': startTime?.millisecondsSinceEpoch,
      'endTime': endTime?.millisecondsSinceEpoch,
      'dayOffDate': dayOffDate?.millisecondsSinceEpoch,
      'hours': hours,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory OvertimeModel.fromMap(Map<String, dynamic> map) {
    return OvertimeModel(
      id: map['id'] as int,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      applicationId:
          map['applicationId'] != null ? map['applicationId'] as int : null,
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'] as int)
          : null,
      endTime: map['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endTime'] as int)
          : null,
      dayOffDate: map['dayOffDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dayOffDate'] as int)
          : null,
      hours: map['hours'] != null ? map['hours'] as num : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OvertimeModel.fromJson(String source) =>
      OvertimeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
