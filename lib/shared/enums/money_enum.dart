import 'package:flutter/material.dart';

enum MoneyType {
  plus,
  minus,
  normal;

  Color getColor() {
    switch (this) {
      case MoneyType.plus:
        return Colors.green;
      case MoneyType.minus:
        return Colors.red;
      case MoneyType.normal:
        return Colors.black;
      default:
        return Colors.black;
    }
  }

  static parseEnum(int? value) {
    switch (value) {
      case 0:
        return MoneyType.normal;
      case 1:
        return MoneyType.plus;
      case 2:
        return MoneyType.minus;
      default:
        return MoneyType.normal;
    }
  }

  parseInt() {
    switch (this) {
      case MoneyType.normal:
        return 0;
      case MoneyType.plus:
        return 1;
      case MoneyType.minus:
        return 2;
      default:
    }
  }
}
