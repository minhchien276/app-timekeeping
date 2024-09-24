import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../../../logic/controllers/application/pending_application_controller.dart';
import '../../../../shared/enums/user_enum.dart';
import '../../../../utils/app_icon.dart';
import '../../../../utils/color.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/common/common_custom_text.dart';
import '../../../widgets/common/common_error_widget.dart';
import '../../../widgets/common/common_kback_button.dart';
import '../../../widgets/loading/loading_circle.dart';
import '../../application/widgets/application_type.dart';

class ListApplicationPending extends StatefulWidget {
  const ListApplicationPending({super.key});

  @override
  State<StatefulWidget> createState() => ListApplicationPendingState();
}

class ListApplicationPendingState extends State<ListApplicationPending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const KBackButton(),
        backgroundColor: primary900,
        centerTitle: true,
        title: TextWidget(
          text: 'Danh sách đơn cần duyệt',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: GetBuilder<PendingApplicationController>(
        builder: (controller) {
          return controller.isLoading || controller.isRefreshing
              ? const Center(child: LoadingCircle(color: primary900))
              : controller.isError
                  ? DisconnectWidget(onTap: () => controller.refreshing())
                  : controller.mapped.isEmpty
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
                            itemCount: controller.mapped.length,
                            itemBuilder: (context, index) {
                              var key = controller.mapped.keys.toList();
                              var values = controller.mapped.values.toList();
                              return ApplicationType(
                                userEnum: UserEnum.other,
                                date: key[index],
                                applications: values[index],
                                isLast: controller.mapped.length - 1 == index,
                                isLoading: controller.isLoadingMore,
                                isFirst: 0 == index,
                              );
                            },
                          ),
                        );
        },
      ),
    );
  }
}
