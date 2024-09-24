import 'package:e_tmsc_app/logic/controllers/work/work_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/presentation/widgets/room/employee_item.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkCreateGroup extends StatefulWidget {
  const WorkCreateGroup({super.key});

  @override
  State<WorkCreateGroup> createState() => _WorkCreateGroupState();
}

class _WorkCreateGroupState extends State<WorkCreateGroup> {
  final WorkController workController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      workController.fetchEmployees();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: primary900,
            leading: KBackButton(
              onTap: () => controller.handleBackPressed(context),
            ),
            centerTitle: true,
            title: TextWidget(
              text: 'Tạo nhóm giao việc',
              color: white,
              textStyle: textStyle17Bold,
            ),
            actions: [
              TextButton(
                onPressed: () => controller.handleCreateRoomPressed(context),
                child: TextWidget(
                  text: 'Tạo',
                  color: white,
                  textStyle:
                      textStyle15SemiBold.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  focusNode: controller.groupNameFocusNode,
                  controller: controller.groupNameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    hintText: 'Nhập tên nhóm (bắt buộc)',
                    hintStyle: textStyle14SemiBold,
                    suffixIcon: controller.canRemoveGroupName
                        ? IconButton(
                            onPressed: () =>
                                controller.groupNameController.clear(),
                            icon: const Icon(Icons.close),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: white)),
                  ),
                  style: textStyle14SemiBold,
                ),
              ),
              15.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  focusNode: controller.searchFocusNode,
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.zero,
                    fillColor: grey200,
                    hintText: 'Tìm kiếm',
                    hintStyle: textStyle14SemiBold.copyWith(color: grey500),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: controller.canRemoveSearchName
                        ? IconButton(
                            onPressed: () =>
                                controller.searchController.clear(),
                            icon: const Icon(Icons.close),
                          )
                        : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: white)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: white)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100),
                        borderSide: const BorderSide(color: white)),
                  ),
                  style: textStyle14SemiBold,
                ),
              ),
              10.verticalSpace,
              if (controller.employeesAdded.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TextWidget(
                    text: '${controller.employeesAdded.length} thành viên',
                    color: grey500,
                    textStyle: textStyle12,
                  ),
                ),
                8.verticalSpace,
                Container(
                  height: 80.h,
                  margin: EdgeInsets.symmetric(horizontal: 10.w),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    itemCount: controller.employeesAdded.length,
                    itemBuilder: (context, index) {
                      final employee = controller.employeesAdded[index];
                      return buildEmployeeSelected(
                        onRemove: () => controller.handleAddEmployee(employee),
                        employee: employee,
                      );
                    },
                  ),
                ),
              ],
              10.verticalSpace,
              Expanded(
                child: controller.isLoading
                    ? const Center(child: LoadingCircle(color: primary900))
                    : ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        itemCount: controller.employeesQuery.length,
                        itemBuilder: (context, index) {
                          final employee = controller.employeesQuery[index];
                          return buildEmployeeCheckbox(
                              onAdd: () => controller
                                  .handleAddEmployee(employee.employee),
                              employee: employee.employee,
                              checked: employee.hasSelect);
                        },
                      ),
              ),
              50.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
