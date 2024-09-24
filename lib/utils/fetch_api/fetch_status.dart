import 'package:get/get.dart';

class FetchStatus extends GetxController with StateMixin {
  final _isLoading = Rx<bool>(false);
  final _isRefresh = Rx<bool>(false);
  final _isLoadMore = Rx<bool>(false);
  final _isError = Rx<bool>(false);

  bool get isLoading => _isLoading.value;
  bool get isRefreshing => _isRefresh.value;
  bool get isLoadingMore => _isLoadMore.value;
  bool get isError => _isError.value;

  setLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  setRefreshing(bool value) {
    _isRefresh.value = value;
    update();
  }

  setLoadingMore(bool value) {
    _isLoadMore.value = value;
    update();
  }

  setError(bool value) {
    _isError.value = value;
    update();
  }
}
