import 'dart:convert';

import 'package:e_tmsc_app/data/models/dayoff_model.dart';
import 'package:e_tmsc_app/data/models/early_late_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/overtime_model.dart';
import 'package:e_tmsc_app/shared/enums/application_enum.dart';
import 'package:e_tmsc_app/shared/enums/type_day_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApplicationModel {
  final int id;
  final String? title;
  final String? content;
  final String? image;
  final int? employeeId;
  final int? approverId;
  final TypeDayEnum? type;
  ApplicationEnum? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<DayoffModel> dayOff;
  final List<OvertimeModel> overTime;
  final List<EarlyLateModel> earlyLate;
  final EmployeeModel? employee;
  final String? approveName;
  ApplicationModel({
    required this.id,
    this.title,
    this.approveName,
    this.content,
    this.image,
    this.employeeId,
    this.approverId,
    this.type,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.dayOff = const [],
    this.overTime = const [],
    this.earlyLate = const [],
    this.employee,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'image': image,
      'employeeId': employeeId,
      'approverId': approverId,
      'type': type!.getId(),
      'status': ApplicationEnum.parseId(status!),
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'dayOff': dayOff.map((e) => e.toJson()).toList(),
      'overtime': overTime.map((e) => e.toJson()).toList(),
      'earlyLate': earlyLate.map((e) => e.toJson()).toList(),
      'employee': employee?.toMap(),
      'approveName': approveName
    };
  }

  factory ApplicationModel.fromMap(Map<String, dynamic> map) {
    return ApplicationModel(
      id: map['id'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      approverId: map['approverId'] != null ? map['approverId'] as int : null,
      type: map['type'] != null ? TypeDayEnum.parseEnum(map['type']) : null,
      status: ApplicationEnum.parseEnum(map['status']),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      approveName:
          map['approverName'] != null ? map['approverName'] as String : null,
      dayOff: map['dayOff'] == null
          ? []
          : List<DayoffModel>.from(
              map['dayOff'].map((x) => DayoffModel.fromJson(jsonEncode(x)))),
      overTime: map['overtime'] == null
          ? []
          : List<OvertimeModel>.from(map['overtime']
              .map((x) => OvertimeModel.fromJson(jsonEncode(x)))),
      earlyLate: map['earlyLate'] == null
          ? []
          : List<EarlyLateModel>.from(map['earlyLate']
              .map((x) => EarlyLateModel.fromJson(jsonEncode(x)))),
      employee: map['employee'] == null
          ? null
          : EmployeeModel.fromJson(jsonEncode(map['employee'])),
    );
  }

  String toJson() => json.encode(toMap());

  factory ApplicationModel.fromJson(String source) =>
      ApplicationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  changeStatus(ApplicationEnum status) => this.status = status;
}
