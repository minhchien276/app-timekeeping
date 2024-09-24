import 'package:e_tmsc_app/logic/controllers/work/work_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class WorkSearch extends StatefulWidget {
  const WorkSearch({super.key});

  @override
  State<WorkSearch> createState() => _WorkSearchState();
}

class _WorkSearchState extends State<WorkSearch> {
  final WorkController workController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: white,
          appBar: AppBar(
            backgroundColor: primary900,
            titleSpacing: 0,
            leading: const KBackButton(),
            centerTitle: true,
            title: TextField(
              autofocus: true,
              cursorColor: primary900,
              decoration: InputDecoration(
                fillColor: white,
                filled: true,
                hintText: 'Tìm kiếm',
                hintStyle: textStyle14SemiBold,
                constraints: BoxConstraints.tight(const Size.fromHeight(40)),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100),
                  borderSide: const BorderSide(color: white),
                ),
              ),
              style: textStyle14SemiBold,
            ),
            actions: [
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  text: 'Xong',
                  color: white,
                  textStyle:
                      textStyle12SemiBold.copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
          body: Column(
            children: [],
          ),
        );
      },
    );
  }
}
