import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/fetch_api/fetch_utils.dart';
import 'package:flutter/material.dart';

class MyApplicationController extends FetchUtils<ApplicationModel> {
  MyApplicationController({
    required super.fetchApi,
    required super.size,
    super.isLoadmoreEnabled,
  });

  ScrollController get scrollController => scroll;
  Map<DateTime, List<ApplicationModel>> get mappedApprove => _mappingApprove();

  Map<DateTime, List<ApplicationModel>> get mappedPending => _mappingPending();

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetch();
    });
  }

  _mappingApprove() {
    Map<DateTime, List<ApplicationModel>> map = {};
    for (var e in data) {
      var key = e.createdAt!.startTime();
      var approverId = e.approverId;
      if (approverId != null) {
        if (map[key] != null) {
          map[key]!.add(e);
        } else {
          map[key] = [e];
        }
      }
    }
    return map;
  }

  _mappingPending() {
    Map<DateTime, List<ApplicationModel>> map = {};
    for (var e in data) {
      var key = e.createdAt!.startTime();
      var approverId = e.approverId;
      if (approverId == null) {
        if (map[key] != null) {
          map[key]!.add(e);
        } else {
          map[key] = [e];
        }
      }
    }
    return map;
  }

  handleRefreshPressed() async => await refreshing();
}
