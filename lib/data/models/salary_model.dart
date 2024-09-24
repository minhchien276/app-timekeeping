// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:e_tmsc_app/shared/enums/money_enum.dart';

class SalaryItem {
  final String? name;
  final String? subTitle;
  final String? number;
  final MoneyType type;
  SalaryItem({
    this.name,
    this.subTitle,
    this.number,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'subTitle': subTitle,
      'number': number,
      'type': type.parseInt(),
    };
  }

  factory SalaryItem.fromMap(Map<String, dynamic> map) {
    return SalaryItem(
      name: map['name'] != null ? map['name'] as String : null,
      subTitle: map['subTitle'] != null ? map['subTitle'] as String : null,
      number: map['number'] != null ? map['number'] as String : null,
      type: MoneyType.parseEnum(map['type']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryItem.fromJson(String source) =>
      SalaryItem.fromMap(json.decode(source) as Map<String, dynamic>);
}

class SalaryModel {
  final String? month;
  final List<SalaryItem> items;
  SalaryModel({
    this.month,
    required this.items,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'month': month,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory SalaryModel.fromMap(Map<String, dynamic> map) {
    return SalaryModel(
      month: map['month'] != null ? map['month'] as String : null,
      items: List<SalaryItem>.from(
        map['items'].map<SalaryItem>((e) => SalaryItem.fromMap(e)),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryModel.fromJson(String source) =>
      SalaryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  get formatDate => month?.split('-').reversed.skip(1).join('/');
  get mm => int.tryParse(month?.split('-')[1] ?? '');
  get yyyy => int.tryParse(month?.split('-')[0] ?? '');

  get range {
    if (mm == 1 ||
        mm == 3 ||
        mm == 5 ||
        mm == 7 ||
        mm == 8 ||
        mm == 10 ||
        mm == 12) {
      // String m = '12';
      // String y = (yyyy - 1).toString();
      return '01/$mm/$yyyy - 31/$mm/$yyyy';
    } else if (mm == 4 || mm == 6 || mm == 9 || mm == 11) {
      // String m = (mm - 1).toString();
      return '01/$mm/$yyyy - 30/$mm/$yyyy';
    } else {
      return '01/$mm/$yyyy - 28/$mm/$yyyy';
    }
  }
}
