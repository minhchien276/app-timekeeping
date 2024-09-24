import 'package:e_tmsc_app/presentation/screens/application/widgets/application_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../shared/enums/user_enum.dart';
import '../../../../utils/app_icon.dart';
import '../../../../utils/color.dart';
import '../../../logic/controllers/application/my_application_controller.dart';
import '../../widgets/common/common_error_widget.dart';
import '../../widgets/loading/loading_circle.dart';

class ApplicationMyClient extends StatelessWidget {
  ApplicationMyClient({super.key, required this.userEnum});

  final MyApplicationController controller = Get.find();
  final UserEnum userEnum;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyApplicationController>(
      builder: (_) {
        return controller.isLoading || controller.isRefreshing
            ? const Center(child: LoadingCircle(color: primary900))
            : controller.isError
                ? DisconnectWidget(onTap: () => controller.refreshing())
                : controller.mappedApprove.isEmpty
                    ? Center(
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppIcon.iconNotItem,
                            scale: 1.2,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "KHÔNG CÓ ĐƠN NÀO !!!",
                                style: TextStyle(
                                  color: black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ))
                    : RefreshIndicator(
                        color: primary900,
                        onRefresh: () => controller.handleRefreshPressed(),
                        child: ListView.builder(
                          controller: controller.scrollController,
                          itemCount: controller.mappedApprove.length,
                          itemBuilder: (context, index) {
                            var key = controller.mappedApprove.keys.toList();
                            var values =
                                controller.mappedApprove.values.toList();
                            return ApplicationType(
                              userEnum: userEnum,
                              date: key[index],
                              applications: values[index],
                              isLast:
                                  controller.mappedApprove.length - 1 == index,
                              isFirst: 0 == index,
                              isLoading: controller.isLoadingMore,
                            );
                          },
                        ),
                      );
      },
    );
  }
}
