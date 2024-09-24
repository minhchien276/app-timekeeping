import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_item.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkDone extends StatefulWidget {
  const WorkDone({super.key});

  @override
  State<WorkDone> createState() => _WorkDoneState();
}

class _WorkDoneState extends State<WorkDone> {
  final WorkDetailController _controller = Get.find();

  @override
  void initState() {
    _controller.fetchListTask(TaskStatus.done);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          body: ListView.builder(
            itemCount: controller.doneTasks.length,
            itemBuilder: (context, index) {
              final item = controller.doneTasks[index];
              return WorkItem(
                item: item,
                status: TaskStatus.done,
              );
            },
          ),
        );
      },
    );
  }
}
