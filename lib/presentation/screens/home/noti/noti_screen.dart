import 'package:e_tmsc_app/logic/controllers/notification/notification_controller.dart';
import 'package:e_tmsc_app/logic/provider/notification_provider.dart';
import 'package:e_tmsc_app/presentation/screens/home/noti/noti_type.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_error_widget.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotiScreen extends GetView<NotificationController> {
  const NotiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NotificationController(
          fetchApi: (int page) async =>
              await NotificationProvider().getNotification(page),
          size: 20,
          isLoadmoreEnabled: true,
        ));
    return GetBuilder<NotificationController>(
      builder: (_) {
        final data = controller.mapped;
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: primary900,
            leading: const KBackButton(),
            centerTitle: true,
            title: TextWidget(
              text: 'Thông báo',
              color: white,
              textStyle: textStyle17Bold,
            ),
            // ƒ
          ),
          body: RefreshIndicator(
            color: primary900,
            onRefresh: () => controller.handleRefreshPressed(),
            child: controller.isLoading || controller.isRefreshing
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      backgroundColor: primary900,
                      strokeWidth: 5,
                    ),
                  )
                : controller.isError
                    ? DisconnectWidget(onTap: () => controller.refreshing())
                    : ListView.builder(
                        controller: controller.scrollController,
                        physics: const ClampingScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          var key = data.keys.toList();
                          var values = data.values.toList();
                          return NotiType(
                            date: key[index],
                            notis: values[index],
                            isLast: index == data.length - 1,
                            isLoading: controller.isLoadingMore,
                          );
                        },
                      ),
          ),
        );
      },
    );
  }
}
