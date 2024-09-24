import 'package:e_tmsc_app/logic/controllers/home/home_admin_controller.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/widgets/calendar_department.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileAllEmployee extends StatefulWidget {
  const ProfileAllEmployee({super.key});

  @override
  State<ProfileAllEmployee> createState() => _ProfileAllEmployeeState();
}

class _ProfileAllEmployeeState extends State<ProfileAllEmployee> {
  final HomeAdminController controller = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.fetchAllEmployee();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Danh sách nhân viên',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<HomeAdminController>(
        builder: (controller) {
          final keys = controller.employeeAll.keys.toList();
          final values = controller.employeeAll.values.toList();
          return controller.isLoading
              ? const Center(child: LoadingCircle(color: primary900))
              : controller.employeeAll.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        backgroundColor: primary900,
                        strokeWidth: 5,
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.only(
                          left: 24.w, right: 24.w, bottom: 10.h, top: 10.h),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.employeeAll.length,
                        itemBuilder: (context, index) {
                          return CalendarDepartment(
                            department: keys[index],
                            employees: values[index],
                            detail: 'nhân sự',
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
