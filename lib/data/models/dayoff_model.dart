import 'dart:convert';

import 'package:e_tmsc_app/shared/enums/session_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class DayoffModel {
  final int id;
  final int? employeeId;
  final int? applicationId;
  final DateTime? dayOffDate;
  final SessionEnum? session;
  final int? type;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  DayoffModel({
    required this.id,
    this.employeeId,
    this.applicationId,
    this.dayOffDate,
    this.session,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'employeeId': employeeId,
      'applicationId': applicationId,
      'dayOffDate': dayOffDate?.millisecondsSinceEpoch,
      'session': SessionEnum.parseId(session!),
      'type': type,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory DayoffModel.fromMap(Map<String, dynamic> map) {
    return DayoffModel(
      id: map['id'] as int,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      applicationId:
          map['applicationId'] != null ? map['applicationId'] as int : null,
      dayOffDate: map['dayOffDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dayOffDate'] as int)
          : null,
      session:
          map['session'] != null ? SessionEnum.parseEnum(map['session']) : null,
      type: map['type'] != null ? map['type'] as int : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DayoffModel.fromJson(String source) =>
      DayoffModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
