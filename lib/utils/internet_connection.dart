import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_snackbar.dart';
import 'package:flutter/material.dart';

const connnectedMessage = 'Đã khôi phục kết nối mạng';
const disconnnectMessage = 'Không có kết nối mạng';

class InternetStatusListener {
  static final _singleton = InternetStatusListener._internal();
  InternetStatusListener._internal();
  static InternetStatusListener getInstance() => _singleton;

  final Connectivity _connectivity = Connectivity();

  bool hasConnection = true;
  bool firstMessage = false;

  bool hasShownNoInternet = false;
  bool hasShownInternet = false;

  StreamController connectionChangeController = StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  void _connectionChange(ConnectivityResult result) async {
    await checkConnection(result);
  }

  Future<bool> checkConnection(ConnectivityResult result) async {
    bool previousConnection = hasConnection;
    if (result != ConnectivityResult.none) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          hasConnection = true;
        } else {
          hasConnection = false;
        }
      } on SocketException catch (_) {
        hasConnection = false;
      }
    } else {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }

  initialize() async {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
  }

  dispose() {
    connectionChangeController.close();
  }
}

updateConnectivity(
  BuildContext context,
  dynamic hasConnection,
  InternetStatusListener internetStatusListener,
) {
  if (!hasConnection && !internetStatusListener.hasShownNoInternet) {
    internetStatusListener.hasShownNoInternet = true;
    debugPrint(
        'InternetStatusListener No internet connection ${internetStatusListener.firstMessage}');
    if (internetStatusListener.firstMessage) {
      context.showErrorMessage(disconnnectMessage);
    }
    internetStatusListener.firstMessage = true;
    Future.delayed(const Duration(seconds: 3), () {
      internetStatusListener.hasShownNoInternet = false;
    });
  } else if (!internetStatusListener.hasShownInternet) {
    internetStatusListener.hasShownInternet = false;
    context.showSuccessMessage(connnectedMessage);
    debugPrint('InternetStatusListener Internet connected');
    Future.delayed(const Duration(seconds: 3), () {
      internetStatusListener.hasShownInternet = false;
    });
  }
}

class RequestStatusListener {
  static final _singleton = RequestStatusListener._internal();
  RequestStatusListener._internal();
  static RequestStatusListener getInstance() => _singleton;

  bool hasShownNoInternet = false;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();

  Stream get connectionChange => connectionChangeController.stream;

  disconnect() => connectionChangeController.sink.add(true);

  initialize(BuildContext context) {
    connectionChange.listen((event) {
      if (!hasShownNoInternet) {
        hasShownNoInternet = true;
        context.showErrorMessage(disconnnectMessage);
        debugPrint('RequestStatusListener No internet connection');
        Future.delayed(const Duration(seconds: 3), () {
          hasShownNoInternet = false;
        });
      }
    });
  }

  dispose() {
    connectionChangeController.close();
  }
}
