import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

enum ApplicationEnum {
  pending,
  approved,
  refuse;

  ApplicationStatus buildData() {
    switch (this) {
      case ApplicationEnum.pending:
        return ApplicationStatus(
            textColor: primary900,
            bgColor: white,
            borderColor: black,
            text: 'Chờ duyệt');
      case ApplicationEnum.approved:
        return ApplicationStatus(
            textColor: const Color(0xff12AC3D),
            bgColor: Colors.green,
            borderColor: Colors.green,
            text: 'Đã duyệt');
      case ApplicationEnum.refuse:
        return ApplicationStatus(
            textColor: const Color(0xffD55142),
            bgColor: Colors.red,
            borderColor: Colors.red,
            text: 'Từ chối');
      default:
        return ApplicationStatus(
            textColor: Colors.lightBlueAccent,
            bgColor: white,
            borderColor: black,
            text: 'Chờ duyệt');
    }
  }

  static int? parseId(ApplicationEnum value) {
    switch (value) {
      case ApplicationEnum.refuse:
        return 0;
      case ApplicationEnum.approved:
        return 1;
      default:
        return null;
    }
  }

  static ApplicationEnum parseEnum(int? id) {
    switch (id) {
      case 0:
        return ApplicationEnum.refuse;
      case 1:
        return ApplicationEnum.approved;
      default:
        return ApplicationEnum.pending;
    }
  }
}

class ApplicationStatus {
  final Color textColor;
  final Color bgColor;
  final Color borderColor;
  final String text;
  ApplicationStatus({
    required this.textColor,
    required this.bgColor,
    required this.borderColor,
    required this.text,
  });
}
