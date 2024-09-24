import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/fetch_api/fetch_utils.dart';
import 'package:flutter/material.dart';

class ApproveApplicationController extends FetchUtils<ApplicationModel> {
  ApproveApplicationController({
    required super.fetchApi,
    required super.size,
    super.isLoadmoreEnabled,
  });

  ScrollController get scrollController => scroll;
  Map<DateTime, List<ApplicationModel>> get mapped => _mapping();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetch();
    });
  }

  _mapping() {
    Map<DateTime, List<ApplicationModel>> map = {};
    for (var e in data) {
      var key = e.createdAt!.startTime();
      if (map[key] != null) {
        map[key]!.add(e);
      } else {
        map[key] = [e];
      }
    }
    return map;
  }

  handleRefreshPressed() async => await refreshing();

  handleAddItem(ApplicationModel item) {
    data.add(item);
    sort();
    updateData(data);
  }

  sort() {
    data.sort((a, b) => b.createdAt!.millisecondsSinceEpoch
        .compareTo(a.createdAt!.millisecondsSinceEpoch));
  }
}
