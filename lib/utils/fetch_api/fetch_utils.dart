import 'package:e_tmsc_app/utils/fetch_api/fetch_status.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class FetchUtils<T> extends FetchStatus {
  final Future<List<T>> Function(int page) fetchApi;
  final bool? isLoadmoreEnabled;
  FetchUtils(
      {required this.fetchApi,
      required int size,
      this.isLoadmoreEnabled = false})
      : _size = size;

  final _endReachedThreshold = 200;

  final int _size;
  bool _isEmpty = false;
  int _currentPage = 0;
  final _data = Rx<List<T>>([]);
  ScrollController scroll = ScrollController();

  bool get isFreezing =>
      (isLoading || isRefreshing || isLoadingMore) && !_isEmpty;
  List<T> get data => _data.value;

  updateData(var value) {
    _data.value = value;
    update();
  }

  //prevent request when data is empty
  void emptyData(int len) {
    if (len < _size) {
      _isEmpty = true;
      debugPrint('empty data to get');
    }
  }

  Future<void> fetch() async {
    if (isFreezing) return;
    debugPrint('begin fetching');
    try {
      setLoading(true);
      final response = await fetchApi(_currentPage);
      setError(false);
      emptyData(response.length);
      _data.value = [...response];
      update();
      debugPrint('fetched');
      setLoading(false);
    } catch (e) {
      setError(true);
      setLoading(false);
    }
  }

  Future<void> refreshing() async {
    if (isFreezing) return;
    debugPrint('begin refresh');
    try {
      _currentPage = 0;
      setRefreshing(true);
      final response = await fetchApi(_currentPage);
      setError(false);
      emptyData(response.length);
      _data.value = [...response];
      update();
      debugPrint('refreshed');
      setRefreshing(false);
    } catch (e) {
      setError(true);
      setRefreshing(false);
    }
  }

  Future<void> loadmore() async {
    if (isFreezing || _isEmpty) return;
    debugPrint('begin loadmore');
    try {
      ++_currentPage;
      setLoadingMore(true);
      final response = await fetchApi(_currentPage);
      setError(false);
      emptyData(response.length);
      _data.value.addAll(response);
      update();
      debugPrint('loaded');
      setLoadingMore(false);
    } catch (e) {
      setError(true);
      setLoadingMore(false);
    }
  }

  void _onScroll() {
    if (isLoadmoreEnabled == true &&
        !isFreezing &&
        scroll.hasClients &&
        scroll.position.extentAfter < _endReachedThreshold) {
      loadmore();
    }
  }

  @override
  addListener(GetStateUpdate listener) {
    scroll.addListener(_onScroll);
    return super.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    scroll.removeListener(_onScroll);
    super.removeListener(listener);
  }
}
