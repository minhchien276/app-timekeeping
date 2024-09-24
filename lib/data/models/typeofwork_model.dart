import 'dart:convert';
import 'package:flutter/material.dart';

class TypeOfWork {
  final TimeOfDay? timeIn;
  final TimeOfDay? timeOut;

  TypeOfWork({
    this.timeIn,
    this.timeOut,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'timeIn': timeIn != null ? '${timeIn!.hour}:${timeIn!.minute}' : null,
      'timeOut': timeOut != null ? '${timeOut!.hour}:${timeOut!.minute}' : null,
    };
  }

  factory TypeOfWork.fromMap(Map<String, dynamic> map) {
    return TypeOfWork(
      timeIn: map['timeIn'] != null
          ? _parseTimeOfDay(map['timeIn'] as String)
          : null,
      timeOut: map['timeOut'] != null
          ? _parseTimeOfDay(map['timeOut'] as String)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TypeOfWork.fromJson(String source) =>
      TypeOfWork.fromMap(json.decode(source) as Map<String, dynamic>);

  static TimeOfDay _parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    return TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }
}
