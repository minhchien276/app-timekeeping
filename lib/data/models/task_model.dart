// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:flutter/material.dart';

class TaskModel {
  final int taskId;
  final String? title;
  final String? content;
  final int? roomId;
  final int commentCount;
  final List<EmployeeModel> participants;
  final DateTime? expired;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  TaskModel({
    required this.taskId,
    this.title,
    this.content,
    this.roomId,
    required this.commentCount,
    required this.participants,
    this.expired,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'taskId': taskId,
      'title': title,
      'content': content,
      'roomId': roomId,
      'participants': participants.map((x) => x.toMap()).toList(),
      'expired': expired?.millisecondsSinceEpoch,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      taskId: map['taskId'] as int,
      title: map['title'] != null ? map['title'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
      roomId: map['roomId'] != null ? map['roomId'] as int : null,
      commentCount:
          map['commentCount'] != null ? map['commentCount'] as int : 0,
      participants: List<EmployeeModel>.from((map['participants'])
          .map<EmployeeModel>((x) => EmployeeModel.fromMap(x))),
      expired: map['expired'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['expired'] as int)
          : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
    );
  }

  Color expiredColor() {
    int tmp = expired!.difference(DateTime.now()).inHours;
    if (tmp > 24) {
      return Colors.green[300]!;
    } else if (tmp > 0) {
      return Colors.yellow[300]!;
    } else {
      return Colors.red[300]!;
    }
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
