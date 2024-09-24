import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_item.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkWorking extends StatefulWidget {
  const WorkWorking({super.key});

  @override
  State<WorkWorking> createState() => _WorkWorkingState();
}

class _WorkWorkingState extends State<WorkWorking> {
  final WorkDetailController _controller = Get.find();

  @override
  void initState() {
    _controller.fetchListTask(TaskStatus.working);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          body: ListView.builder(
            itemCount: controller.workingTasks.length,
            itemBuilder: (context, index) {
              final item = controller.workingTasks[index];
              return WorkItem(
                item: item,
                status: TaskStatus.working,
              );
            },
          ),
        );
      },
    );
  }
}
