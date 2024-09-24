// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_text_field.dart';
import 'package:e_tmsc_app/presentation/widgets/dialog/datetime_picker_dialog.dart';
import 'package:e_tmsc_app/presentation/widgets/modal/modal_search_employee.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/room/employee_item.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_cancel.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_done.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_todo.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_working.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';

class WorkGroupDetailScreen extends StatefulWidget {
  final RoomModel room;
  const WorkGroupDetailScreen({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  State<WorkGroupDetailScreen> createState() => _WorkGroupDetailScreenState();
}

class _WorkGroupDetailScreenState extends State<WorkGroupDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: tabs.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: primary900,
            leading: const KBackButton(),
            centerTitle: true,
            title: TextWidget(
              text: widget.room.name,
              color: white,
              textStyle: textStyle17Bold,
              maxLines: 1,
            ),
            actions: [
              IconButton(
                onPressed: () => context.pushNamed(AppRoute.workSearch.name),
                icon: const Icon(Icons.search, color: white),
              ),
              IconButton(
                onPressed: () => context.pushNamed(AppRoute.workCreateTask.name,
                    extra: widget.room),
                icon: const Icon(Icons.add, color: white),
              ),
            ],
            bottom: _buildTabbar(),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              WorkTodo(),
              WorkWorking(),
              WorkDone(),
              WorkCancel(),
            ],
          ),
        );
      },
    );
  }

  List<Widget> tabs = [
    Tab(
      child: TextWidget(
        text: 'Todo',
        color: white,
        textStyle: textStyle15SemiBold,
      ),
    ),
    Tab(
      child: TextWidget(
        text: 'Working',
        color: white,
        textStyle: textStyle15SemiBold,
      ),
    ),
    Tab(
      child: TextWidget(
        text: 'Done',
        color: white,
        textStyle: textStyle15SemiBold,
      ),
    ),
    Tab(
      child: TextWidget(
        text: 'Cancel',
        color: white,
        textStyle: textStyle15SemiBold,
      ),
    ),
  ];

  PreferredSize _buildTabbar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 48.h),
      child: TabBar(
        controller: _tabController,
        tabs: tabs,
        indicatorWeight: 2,
        indicatorColor: white,
        dividerColor: primary900,
        dividerHeight: 2,
      ),
    );
  }
}

class WorkCreateTask extends StatefulWidget {
  final RoomModel room;
  const WorkCreateTask({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  State<WorkCreateTask> createState() => _WorkCreateTaskState();
}

class _WorkCreateTaskState extends State<WorkCreateTask> {
  final WorkDetailController controller = Get.find();
  List<EmployeeModel> employeesAdded = [];
  DateTime? dateTimePicker;

  @override
  void initState() {
    super.initState();
  }

  void handleRemove(int index) {
    setState(() {
      employeesAdded.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: primary900,
            leading: KBackButton(
              onTap: () => context.pop(),
            ),
            centerTitle: true,
            title: TextWidget(
              text: 'Tạo nhóm giao việc',
              color: white,
              textStyle: textStyle17Bold,
            ),
            actions: [
              TextButton(
                onPressed: () => controller.handleCreateTaskPressed(
                  context,
                  room: widget.room,
                  employees: employeesAdded,
                  expired: dateTimePicker,
                ),
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
                child: CustomTextField(
                  controller: controller.taskTitleController,
                  focusNode: controller.taskTitleFocusNode,
                  hintText: 'Nhập tiêu đề (bắt buộc)',
                  canRemove: controller.canRemoveGroupName,
                  onRemove: () => controller.taskTitleController.clear(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomTextField(
                  controller: controller.taskContentController,
                  focusNode: controller.taskContentFocusNode,
                  hintText: 'Nhập mô tả',
                  borderColor: primary900,
                  minLines: 3,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: IconButton(
                  onPressed: () => showDateTimePicker(
                    context,
                    onChange: (date) {
                      setState(() {
                        dateTimePicker = date;
                      });
                    },
                  ),
                  icon: Row(
                    children: [
                      const Icon(Icons.access_time, color: primary900),
                      4.horizontalSpace,
                      Expanded(
                        child: TextWidget(
                          text: dateTimePicker == null
                              ? 'thêm thời hạn (không bắt buộc)'
                              : dateTimePicker!.formatDateTime,
                          color: grey700,
                          textStyle: textStyle14SemiBold,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: IconButton(
                  onPressed: () => searchEmployeeModal(
                    context,
                    employees: widget.room.participants,
                    employeesAdded: employeesAdded,
                    onConfirm: (value) {
                      setState(() {
                        employeesAdded = value;
                      });
                    },
                  ),
                  icon: Row(
                    children: [
                      const Icon(Icons.add, color: primary900),
                      4.horizontalSpace,
                      Expanded(
                        child: TextWidget(
                          text: 'thêm thành viên tham gia (không bắt buộc)',
                          color: grey700,
                          textStyle: textStyle14SemiBold,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              10.verticalSpace,
              if (employeesAdded.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: TextWidget(
                    text: '${employeesAdded.length} thành viên tham gia',
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
                    itemCount: employeesAdded.length,
                    itemBuilder: (context, index) {
                      final employee = employeesAdded[index];
                      return buildEmployeeSelected(
                        onRemove: () => handleRemove(index),
                        employee: employee,
                      );
                    },
                  ),
                ),
              ],
              50.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
