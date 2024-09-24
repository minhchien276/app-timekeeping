import 'package:e_tmsc_app/logic/controllers/application/people_application_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'application_my_client.dart';
import 'application_pending_client.dart';

class ApplicationClient extends StatelessWidget {
  const ApplicationClient({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: background,
        appBar: AppBar(
          backgroundColor: primary900,
          centerTitle: true,
          title: TextWidget(
            text: 'Danh sách đơn từ',
            color: white,
            textStyle: textStyle17Bold,
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushNamed(AppRoute.applicationCreate.name);
              },
              icon: Image.asset(AppIcon.mailPlus, scale: 3),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 48.h),
            child: Stack(
              alignment: Alignment.center,
              children: [
                TabBar(
                  tabs: [
                    Tab(
                      child: TextWidget(
                        text: 'Đơn đã duyệt',
                        color: white,
                        textStyle: textStyle15SemiBold,
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'Đơn cần duyệt',
                            color: white,
                            textStyle: textStyle15SemiBold,
                          ),
                          GetBuilder<PeopleApplicationController>(
                            builder: (controller) {
                              if (controller.pendingCount != 0) {
                                return Row(
                                  children: [
                                    6.horizontalSpace,
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 16.h,
                                          width: 16.h,
                                          decoration: BoxDecoration(
                                            color: white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          child: Center(
                                            child: TextWidget(
                                              text: controller.pendingCount
                                                  .toString(),
                                              color: primary900,
                                              textStyle: textStyle10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  indicatorWeight: 2,
                  indicatorColor: white,
                  dividerColor: primary900,
                  dividerHeight: 2,
                ),
                Positioned(
                  child: Container(
                    width: 1,
                    height: 48.h,
                    color: white.withOpacity(0.2),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 1.h,
                    color: white.withOpacity(0.2),
                  ),
                )
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: ApplicationMyClient(userEnum: UserEnum.my)),
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: ApplicationPendingClient(userEnum: UserEnum.my)),
          ],
        ),
      ),
    );
  }
}
