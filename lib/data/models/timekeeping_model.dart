// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_tmsc_app/data/models/checkin_model.dart';
import 'package:e_tmsc_app/data/models/checkout_model.dart';
import 'package:e_tmsc_app/shared/enums/day_enum.dart';

class TimeKeeping {
  final DateTime? date;
  final CheckInModel? checkin;
  final CheckOutModel? checkout;
  final DayEnum? status;
  final num? daywork;
  final num? dayoff;
  final String? lated;
  TimeKeeping({
    this.date,
    this.checkin,
    this.checkout,
    this.status,
    this.daywork,
    this.dayoff,
    this.lated,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date?.millisecondsSinceEpoch,
      'checkin': checkin?.toMap(),
      'checkout': checkout?.toMap(),
      'status': DayEnum.fromEnum(status),
      'daywork': daywork,
      'dayoff': dayoff,
      'lated': lated,
    };
  }

  factory TimeKeeping.fromMap(Map<String, dynamic> map) {
    return TimeKeeping(
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'] as int)
          : null,
      checkin: map['checkin'] != null
          ? CheckInModel.fromMap(map['checkin'] as Map<String, dynamic>)
          : null,
      checkout: map['checkout'] != null
          ? CheckOutModel.fromMap(map['checkout'] as Map<String, dynamic>)
          : null,
      status: map['status'] != null ? DayEnum.parseInt(map['status']) : null,
      daywork: map['daywork'] != null ? map['daywork'] as num : 0,
      dayoff: map['dayoff'] != null ? map['dayoff'] as num : 0,
      lated: map['lated'] != null ? map['lated'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TimeKeeping.fromJson(String source) =>
      TimeKeeping.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Calendar {
  List<TimeKeeping> daysOfWork;
  List<TimeKeeping> daysOfLate;
  List<TimeKeeping> daysOff;
  List<TimeKeeping> daysOfMissing;
  List<TimeKeeping> daysOfPending;
  List<TimeKeeping> daysHoliday;
  Calendar({
    this.daysOfWork = const [],
    this.daysOfLate = const [],
    this.daysOff = const [],
    this.daysOfMissing = const [],
    this.daysOfPending = const [],
    this.daysHoliday = const [],
  });
}
