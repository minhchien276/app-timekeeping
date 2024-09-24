import 'dart:convert';

import 'package:e_tmsc_app/shared/enums/notification_enum.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class NotificationModel {
  final int id;
  final int? receiverId;
  final int? senderId;
  final int? employeeId;
  final int? applicationId;
  final String? text;
  final String? notiTitle;
  final String? notiContent;
  int? seen;
  final String? senderName;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final NotificationType type;
  NotificationModel({
    required this.id,
    this.receiverId,
    this.senderId,
    this.employeeId,
    this.applicationId,
    this.text,
    this.notiTitle,
    this.notiContent,
    this.seen,
    this.senderName,
    this.image,
    this.createdAt,
    this.updatedAt,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'receiverId': receiverId,
      'senderId': senderId,
      'employeeId': employeeId,
      'applicationId': applicationId,
      'text': text,
      'seen': seen,
      'senderName': senderName,
      'image': image,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] as int,
      receiverId: map['receiverId'] != null ? map['receiverId'] as int : null,
      senderId: map['senderId'] != null ? map['senderId'] as int : null,
      employeeId: map['employeeId'] != null ? map['employeeId'] as int : null,
      applicationId:
          map['applicationId'] != null ? map['applicationId'] as int : null,
      text: map['text'] != null ? map['text'] as String : null,
      notiTitle: map['notiTitle'] != null ? map['notiTitle'] as String : null,
      notiContent:
          map['notiContent'] != null ? map['notiContent'] as String : null,
      seen: map['seen'] != null ? map['seen'] as int : null,
      senderName:
          map['senderName'] != null ? map['senderName'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      type: NotificationType.parseType(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
