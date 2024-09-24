import 'package:e_tmsc_app/logic/controllers/work/work_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_room_approve_controller.dart';
import 'package:e_tmsc_app/logic/controllers/work/work_room_pending_controller.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:e_tmsc_app/presentation/widgets/room/room_item.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/enums/room_enum.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WorkController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(
            backgroundColor: primary900,
            leading: const KBackButton(),
            centerTitle: true,
            title: TextWidget(
              text: 'Giao việc',
              color: white,
              textStyle: textStyle17Bold,
            ),
            actions: [
              IconButton(
                onPressed: () => context.pushNamed(AppRoute.workSearch.name),
                icon: const Icon(Icons.search, color: white),
              ),
              IconButton(
                onPressed: () =>
                    context.pushNamed(AppRoute.workCreateGroup.name),
                icon: const Icon(Icons.add, color: white),
              ),
            ],
            bottom: _buildTabbar(),
          ),
          body: TabBarView(
            controller: _tabController,
            children: const [
              RoomActive(),
              RoomPending(),
            ],
          ),
        );
      },
    );
  }

  PreferredSize _buildTabbar() {
    return PreferredSize(
      preferredSize: Size(double.infinity, 48.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: TextWidget(
                  text: 'Đang hoạt động',
                  color: white,
                  textStyle: textStyle15SemiBold,
                ),
              ),
              Tab(
                child: TextWidget(
                  text: 'Mời tham gia',
                  color: white,
                  textStyle: textStyle15SemiBold,
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
    );
  }
}

class RoomActive extends StatefulWidget {
  const RoomActive({super.key});

  @override
  State<RoomActive> createState() => _RoomActiveState();
}

class _RoomActiveState extends State<RoomActive>
    with AutomaticKeepAliveClientMixin {
  final WorkRoomApproveController _controller = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<WorkRoomApproveController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: LoadingCircle(color: primary900))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return RoomItem(
                      onTap: () => context.pushNamed(
                          AppRoute.workGroupDetail.name,
                          extra: controller.data[index]),
                      room: controller.data[index],
                      status: RoomStatus.approve,
                    );
                  },
                ),
              );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class RoomPending extends StatefulWidget {
  const RoomPending({super.key});

  @override
  State<RoomPending> createState() => _RoomPendingState();
}

class _RoomPendingState extends State<RoomPending>
    with AutomaticKeepAliveClientMixin {
  final WorkRoomPendingController _controller = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.fetch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<WorkRoomPendingController>(
      builder: (controller) {
        return controller.isLoading
            ? const Center(child: LoadingCircle(color: primary900))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
                child: ListView.builder(
                  itemCount: controller.data.length,
                  itemBuilder: (context, index) {
                    return RoomItem(
                      room: controller.data[index],
                      status: RoomStatus.pending,
                    );
                  },
                ),
              );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
