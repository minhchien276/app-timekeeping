// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/logic/controllers/application/application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_submit_button.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_text_field.dart';
import 'package:e_tmsc_app/presentation/widgets/room/employee_item.dart';
import 'package:e_tmsc_app/shared/extensions/string_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:go_router/go_router.dart';

void searchEmployeeModal(
  BuildContext context, {
  required List<EmployeeModel> employees,
  List<EmployeeModel>? employeesAdded,
  required Function(List<EmployeeModel>) onConfirm,
}) {
  showModalBottomSheet(
    elevation: 0,
    useRootNavigator: true,
    backgroundColor: Colors.white.withOpacity(0),
    barrierColor: Colors.black.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16.r),
      ),
    ),
    context: context,
    builder: (context) {
      return SearchEmployee(
        employees: employees,
        employeesAdded: employeesAdded ?? [],
        onConfirm: onConfirm,
      );
    },
  ).then((e) => onConfirm);
}

class SearchEmployee extends StatefulWidget {
  final List<EmployeeModel> employees;
  final List<EmployeeModel> employeesAdded;
  final Function(List<EmployeeModel>) onConfirm;
  const SearchEmployee({
    Key? key,
    required this.employees,
    required this.employeesAdded,
    required this.onConfirm,
  }) : super(key: key);

  @override
  State<SearchEmployee> createState() => _SearchEmployeeState();
}

class _SearchEmployeeState extends State<SearchEmployee> {
  late TextEditingController searchController;
  late FocusNode searchFocusNode;
  List<SelectedReceiver> employees = [];
  List<SelectedReceiver> data = [];

  @override
  void initState() {
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void initialize() {
    data = widget.employees.map((e) {
      bool selected = widget.employeesAdded.contains(e);
      return SelectedReceiver(employee: e, hasSelect: selected);
    }).toList();
    employees = data;
    setState(() {});
  }

  void onChangeSearch(String value) {
    setState(() {
      employees = data
          .where((e) => (e.employee.fullname ?? '')
              .toLowerCase()
              .toEnglish()
              .contains(value.trim().toLowerCase().toEnglish()))
          .toList();
    });
  }

  void handleAdd(int index) {
    setState(() {
      employees[index].hasSelect = !employees[index].hasSelect;
    });
  }

  int get total => data.where((e) => e.hasSelect).length;

  List<EmployeeModel> result() {
    List<EmployeeModel> res = [];
    for (var e in data) {
      if (e.hasSelect) {
        res.add(e.employee);
      }
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: CustomTextField(
                  controller: searchController,
                  focusNode: searchFocusNode,
                  borderRadius: 100.r,
                  fillColor: grey200,
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Nhập tên tìm kiếm...',
                  onChanged: onChangeSearch,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return buildEmployeeCheckbox(
                      onAdd: () => handleAdd(index),
                      employee: employee.employee,
                      checked: employee.hasSelect,
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: SubmitButton(
              onTap: () {
                widget.onConfirm(result());
                context.pop();
              },
              text: 'Xác nhận${total != 0 ? ' ($total)' : ''}',
              border: 40.r,
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }
}
