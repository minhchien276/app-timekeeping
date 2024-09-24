import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/services/service/application_service.dart';
import 'package:e_tmsc_app/shared/enums/application_enum.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/fetch_api/fetch_utils.dart';
import 'package:flutter/material.dart';

class PeopleApplicationController extends FetchUtils<ApplicationModel> {
  PeopleApplicationController({
    required super.fetchApi,
    required super.size,
    super.isLoadmoreEnabled,
  });

  final appService = ApplicationService();

  ScrollController get scrollController => scroll;
  int get pendingCount =>
      data.where((e) => e.status == ApplicationEnum.pending).length;
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

  handleApproved(int id, ApplicationEnum status) {
    for (var e in data) {
      if (e.id == id) {
        e.status = status;
      }
    }
    updateData(data);
  }

  handleRefreshPressed() async => await refreshing();
}
