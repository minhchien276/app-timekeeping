// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/logic/controllers/application/my_application_controller.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_type.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_error_widget.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationMy extends GetView<MyApplicationController> {
  final UserEnum userEnum;
  const ApplicationMy({
    Key? key,
    required this.userEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyApplicationController>(
      builder: (_) {
        return controller.isLoading || controller.isRefreshing
            ? const Center(child: LoadingCircle(color: primary900))
            : controller.isError
                ? DisconnectWidget(onTap: () => controller.refreshing())
                : RefreshIndicator(
                    color: primary900,
                    onRefresh: () => controller.handleRefreshPressed(),
                    child: ListView.builder(
                      controller: controller.scrollController,
                      itemCount: controller.mappedApprove.length,
                      itemBuilder: (context, index) {
                        var key = controller.mappedApprove.keys.toList();
                        var values = controller.mappedApprove.values.toList();
                        return ApplicationType(
                          date: key[index],
                          applications: values[index],
                          userEnum: userEnum,
                          isLast: controller.mappedApprove.length - 1 == index,
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
