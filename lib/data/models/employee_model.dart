import 'dart:convert';

class EmployeeModel {
  final int? id;
  final int? participantId;
  final String? employeeCode;
  final String? fullname;
  final String? birthday;
  final String? identification;
  final String? email;
  final String? phone;
  final String? image;
  final num? salary;
  final num? dayOff;
  final int? status;
  final int? departmentId;
  final String? departmentName;
  final int? roleId;
  final String? roleName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? hasLogout;
  final DateTime? dayOffDate;

  EmployeeModel(
      {this.id,
      this.participantId,
      this.employeeCode,
      this.fullname,
      this.birthday,
      this.identification,
      this.email,
      this.phone,
      this.image,
      this.salary,
      this.dayOff,
      this.status,
      this.departmentId,
      this.departmentName,
      this.roleId,
      this.roleName,
      this.createdAt,
      this.updatedAt,
      this.hasLogout,
      this.dayOffDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'participantId': participantId,
      'employeeCode': employeeCode,
      'fullname': fullname,
      'birthday': birthday,
      'identification': identification,
      'email': email,
      'phone': phone,
      'image': image,
      'salary': salary,
      'dayOff': dayOff,
      'status': status,
      'departmentId': departmentId,
      'departmentName': departmentName,
      'roleId': roleId,
      'roleName': roleName,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'hasLogout': hasLogout,
      'dayOffDate': dayOffDate
    };
  }

  factory EmployeeModel.fromMap(Map<String, dynamic> map) {
    return EmployeeModel(
      id: map['id'] != null ? map['id'] as int : null,
      participantId:
          map['participantId'] != null ? map['participantId'] as int : null,
      employeeCode:
          map['employeeCode'] != null ? map['employeeCode'] as String : null,
      fullname: map['fullname'] != null ? map['fullname'] as String : null,
      birthday: map['birthday'] != null ? map['birthday'] as String : null,
      identification: map['identification'] != null
          ? map['identification'] as String
          : null,
      email: map['email'] != null ? map['email'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      salary: map['salary'] != null ? map['salary'] as num : null,
      dayOff: map['dayOff'] != null ? map['dayOff'] as num : null,
      status: map['status'] != null ? map['status'] as int : null,
      departmentId:
          map['departmentId'] != null ? map['departmentId'] as int : null,
      departmentName: map['departmentName'] != null
          ? map['departmentName'] as String
          : null,
      roleId: map['roleId'] != null ? map['roleId'] as int : null,
      roleName: map['roleName'] != null ? map['roleName'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      dayOffDate: map['dayOffDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dayOffDate'] as int)
          : null,
      hasLogout: map['hasLogout'] != null ? map['hasLogout'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EmployeeModel.fromJson(String source) =>
      EmployeeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  bool get isBirthday {
    if (birthday != null) {
      DateTime now = DateTime.now();
      var list = birthday!.split('-');
      if (int.tryParse(list[2]) == now.day &&
          int.tryParse(list[1]) == now.month) {
        return true;
      }
    }
    return false;
  }

  String get age {
    if (birthday != null) {
      DateTime now = DateTime.now();
      var list = birthday!.split('-');
      if (int.tryParse(list[2]) == now.day &&
          int.tryParse(list[1]) == now.month) {
        int? year = int.tryParse(list[0]);
        if (year != null) {
          return '${now.year - year} tuổi';
        }
      }
    }
    return '';
  }

  String get lastName {
    final tmp = fullname!.split(' ');
    return tmp[tmp.length - 1];
  }
}
