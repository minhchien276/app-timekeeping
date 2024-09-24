import 'package:e_tmsc_app/logic/controllers/work/word_detail_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/work/work_item.dart';
import 'package:e_tmsc_app/shared/enums/task_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkTodo extends StatefulWidget {
  const WorkTodo({super.key});

  @override
  State<WorkTodo> createState() => _WorkTodoState();
}

class _WorkTodoState extends State<WorkTodo> {
  final WorkDetailController _controller = Get.find();

  @override
  void initState() {
    _controller.fetchListTask(TaskStatus.todo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkDetailController>(
      builder: (controller) {
        return Scaffold(
          body: ListView.builder(
            itemCount: controller.todoTasks.length,
            itemBuilder: (context, index) {
              final item = controller.todoTasks[index];
              return WorkItem(
                item: item,
                status: TaskStatus.todo,
              );
            },
          ),
        );
      },
    );
  }
}
