import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../data/models/employee_model.dart';
import '../../../../utils/color.dart';
import '../../../../utils/mocker.dart';
import '../../../../utils/network_image.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/common/common_custom_text.dart';
import '../../../widgets/common/common_kback_button.dart';

class ListEmployeeOnlineDetail extends StatefulWidget {
  const ListEmployeeOnlineDetail({super.key, required this.parms});
  final Map<String, dynamic> parms;

  @override
  State<StatefulWidget> createState() => ListEmployeeOnlineDetailState();
}

class ListEmployeeOnlineDetailState extends State<ListEmployeeOnlineDetail> {
  late String departmentName;
  late List<EmployeeModel> employees;

  @override
  void initState() {
    departmentName = widget.parms['departmentName'];
    employees = widget.parms['employee'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey25,
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Phòng $departmentName',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: Container(
        margin:
            EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h, bottom: 100.h),
        padding:
            EdgeInsets.only(top: 10.h, left: 12.w, right: 12.w, bottom: 10.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(16.h),
          border: Border.all(color: black.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: black.withOpacity(0.1),
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: const Offset(
                3.0, // Move to right 10  horizontally
                3.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: employees.length,
            itemBuilder: (context, index) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
                decoration: index != employees.length - 1
                    ? const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: grey500,
                            width: 0.5,
                          ),
                        ),
                      )
                    : const BoxDecoration(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        networkImageWithCached(
                          size: Size(40.h, 40.h),
                          url: employees[index].image!,
                          borderRadius: 100,
                          boxBorder: Border.all(color: primary900, width: 2),
                        ),
                        10.horizontalSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: employees[index].fullname!,
                              color: black,
                              textStyle: textStyle12SemiBold,
                            ),
                            TextWidget(
                              text:
                                  Mocker.getRoleById(employees[index].roleId!),
                              color: black,
                              textStyle: textStyle11,
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: 70.w,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: green)),
                      child: Center(
                        child: TextWidget(
                          text: "Đi làm",
                          color: green,
                          textStyle:
                              textStyle12.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
