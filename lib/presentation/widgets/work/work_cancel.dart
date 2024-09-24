import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_item.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkCancel extends StatefulWidget {
  const WorkCancel({super.key});

  @override
  State<WorkCancel> createState() => _WorkCancelState();
}

class _WorkCancelState extends State<WorkCancel> {
  final WorkDetailController _controller = Get.find();

  @override
  void initState() {
    _controller.fetchListTask(TaskStatus.cancel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          body: ListView.builder(
            itemCount: controller.cancelTasks.length,
            itemBuilder: (context, index) {
              final item = controller.cancelTasks[index];
              return WorkItem(
                item: item,
                status: TaskStatus.cancel,
              );
            },
          ),
        );
      },
    );
  }
}
