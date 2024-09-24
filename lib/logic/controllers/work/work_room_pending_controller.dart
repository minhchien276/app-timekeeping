import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/utils/fetch_api/fetch_utils.dart';
import 'package:flutter/widgets.dart';

class WorkRoomPendingController extends FetchUtils<RoomModel> {
  WorkRoomPendingController({
    required super.fetchApi,
    required super.size,
    super.isLoadmoreEnabled,
  });

  ScrollController get scrollController => scroll;

  // @override
  // void onInit() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     fetch();
  //   });
  //   super.onInit();
  // }
}
