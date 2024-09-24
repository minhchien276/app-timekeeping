import 'dart:convert';

import 'package:e_tmsc_app/data/models/employee_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class RoomModel {
  final int roomId;
  final int employeeId;
  final String name;
  final List<EmployeeModel> participants;
  final int? tasksCompleted;
  final int? tasksPending;
  final int? tasksCanceled;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  RoomModel({
    required this.roomId,
    required this.employeeId,
    required this.name,
    required this.participants,
    this.tasksCompleted,
    this.tasksPending,
    this.tasksCanceled,
    this.createdAt,
    this.updatedAt,
  });

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      roomId: map['roomId'] as int,
      employeeId: map['employeeId'] as int,
      name: map['name'] as String,
      participants: List<EmployeeModel>.from(
          map['participants'].map((x) => EmployeeModel.fromMap(x))),
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      tasksCompleted:
          map['tasks_completed'] != null ? map['tasks_completed'] as int : null,
      tasksPending:
          map['tasks_pending'] != null ? map['tasks_pending'] as int : null,
      tasksCanceled:
          map['tasks_canceled'] != null ? map['tasks_canceled'] as int : null,
    );
  }

  factory RoomModel.fromJson(String source) =>
      RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  String twoCharName() {
    final list = name.split(' ');
    return list.first[0].toUpperCase() + list.last[0].toUpperCase();
  }
}
