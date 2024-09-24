import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime startTime() {
    return DateTime.parse(DateFormat('yyyy-MM-dd 00:00:00.000').format(this));
  }

  String get formatWeekDayMonth =>
      '${convertWeekDay(weekday)}, ngày $day tháng $month';
  String get formatWeekDay => '${convertWeekDay(weekday)}, ngày $day';

  String get formatDate => DateFormat('dd-MM-yyyy').format(this);
  String get formatDateTime =>
      DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(this);
  String get formatDayMonth => DateFormat('dd/MM').format(this);
  String get formatDayMonthWeek =>
      '${DateFormat('dd/MM').format(this)} - ${convertWeekDay1(weekday)}';
  toTime() => DateFormat('HH:mm').format(this);

  String timeStatus() {
    final minutes = DateTime.now().difference(this).inMinutes;
    if (minutes < 60) {
      return '$minutes phút trước';
    } else if ((minutes / 1440) < 1) {
      return '${minutes ~/ 60} giờ trước';
    } else if ((minutes / 1440) < 4) {
      return '${minutes ~/ 1440} ngày trước';
    }
    return DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(this);
  }
}

String timeLeft(DateTime? date) {
  if (date == null) return '';
  int minutes = DateTime.now().difference(date).inMinutes;
  if (minutes < 60) {
    if (minutes == 0) minutes = 1;
    return '$minutes phút trước';
  } else if ((minutes / 1440) < 1) {
    return '${minutes ~/ 60} giờ trước';
  } else if ((minutes / 1440) < 4) {
    return '${minutes ~/ 1440} ngày trước';
  }
  return DateFormat('dd/MM/yyyy HH:mm', 'vi_VN').format(date);
}

formatCheckTime(DateTime? date) => date != null ? date.toTime() : '--:--';

String formatHours(DateTime? date) => date != null
    ? '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}'
    : '--:--';

String formatTime(TimeOfDay? timeOfDay) => timeOfDay != null
    ? '${timeOfDay.hour.toString().padLeft(2, '0')}:${timeOfDay.minute.toString().padLeft(2, '0')}'
    : '--:--';

String totalTime(TimeOfDay? begin, TimeOfDay? end) {
  if (begin == null || end == null) {
    return '--:--';
  } else {
    final res = (end.hour * 60 + end.minute) - (begin.hour * 60 + begin.minute);
    return formatTime(TimeOfDay(hour: res ~/ 60, minute: res % 60));
  }
}

String totalTimeTwoDate(DateTime? begin, DateTime? end) {
  if (begin == null || end == null) {
    return '--:--';
  } else {
    final res = (end.hour * 60 + end.minute) - (begin.hour * 60 + begin.minute);
    return formatTime(TimeOfDay(hour: res ~/ 60, minute: res % 60));
  }
}

double parseHoursFromTwoTime(TimeOfDay begin, TimeOfDay end) {
  final res = (end.hour * 60 + end.minute) - (begin.hour * 60 + begin.minute);
  return double.parse((res / 60).toStringAsFixed(1));
}

String totalTimeText(TimeOfDay? begin, TimeOfDay? end) {
  if (begin == null || end == null) {
    return '0 tiếng 0 phút';
  } else {
    final res = (end.hour * 60 + end.minute) - (begin.hour * 60 + begin.minute);
    return '${res ~/ 60} tiếng ${res % 60} phút';
  }
}

String totalTimeTextByDate(DateTime? begin, DateTime? end) {
  if (begin == null || end == null) {
    return '0 tiếng 0 phút';
  } else {
    final res = (end.hour * 60 + end.minute) - (begin.hour * 60 + begin.minute);
    return '${res ~/ 60} tiếng ${res % 60} phút';
  }
}

int convertDateTimeFromTime(int day, TimeOfDay timeOfDay) {
  DateTime date = DateTime.fromMillisecondsSinceEpoch(day);
  return DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute)
      .millisecondsSinceEpoch;
}

String formatDateSlash(DateTime? date) =>
    date == null ? '' : DateFormat('dd-MM-yyyy').format(date);

String formatDateTimeSlash(DateTime? date) => date == null
    ? 'Chưa có'
    : DateFormat('dd-MM-yy HH:mm', 'vi_VN').format(date);

String twoOvertime(DateTime? begin, DateTime? end) {
  return '${formatHours(begin)}  =>  ${formatHours(end)}';
}

String formatPostDateTime(DateTime? date) => date != null
    ? 'Ngày ${date.day} tháng ${date.month} năm ${date.year}'
    : '--:--';

String formatNotiDate(DateTime date) {
  String prefix = convertWeekDay(date.weekday);
  int days = DateTime.now().startTime().difference(date).inDays;
  if (days == 0) {
    prefix = 'Hôm nay';
  } else if (days == 1) {
    prefix = 'Hôm qua';
  }
  return '$prefix, ngày ${date.day} tháng ${date.month} năm ${date.year}';
}

String convertWeekDay(int weekDay) {
  switch (weekDay) {
    case 1:
      return 'Thứ 2';
    case 2:
      return 'Thứ 3';
    case 3:
      return 'Thứ 4';
    case 4:
      return 'Thứ 5';
    case 5:
      return 'Thứ 6';
    case 6:
      return 'Thứ 7';
    case 7:
      return 'Chủ nhật';
    default:
      return 'Thứ 2';
  }
}

String convertWeekDay1(int weekDay) {
  switch (weekDay) {
    case 1:
      return 'T2';
    case 2:
      return 'T3';
    case 3:
      return 'T4';
    case 4:
      return 'T5';
    case 5:
      return 'T6';
    case 6:
      return 'T7';
    case 7:
      return 'CN';
    default:
      return 'T2';
  }
}

String convertBirthday(String birthday) {
  var list = birthday.split("-");
  String birthdayFormat = "${list[2]}/${list[1]}/${list[0]}";
  return birthdayFormat;
}
