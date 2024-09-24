import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_type.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_error_widget.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApplicationPeople extends GetView<PeopleApplicationController> {
  final UserEnum userEnum;
  const ApplicationPeople({
    Key? key,
    required this.userEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PeopleApplicationController>(
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
                      itemCount: controller.mapped.length,
                      itemBuilder: (context, index) {
                        var key = controller.mapped.keys.toList();
                        var values = controller.mapped.values.toList();
                        return ApplicationType(
                          date: key[index],
                          applications: values[index],
                          userEnum: userEnum,
                          isLast: controller.mapped.length - 1 == index,
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
