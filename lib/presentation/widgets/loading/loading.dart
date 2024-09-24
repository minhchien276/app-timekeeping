import 'package:e_tmsc_app/presentation/widgets/loading/loading_controller.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

class Loading {
  factory Loading() => _shared;
  static final Loading _shared = Loading._sharedInstance();
  Loading._sharedInstance();

  LoadingController? controller;

  void show({
    required BuildContext context,
  }) {
    controller = showOverlay(
      context: context,
    );
  }

  void hide() {
    controller?.close();
    controller = null;
  }

  LoadingController showOverlay({
    required BuildContext context,
  }) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(builder: (context) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          backgroundColor: primary900,
          strokeWidth: 5,
        ),
      );
    });

    state.insert(overlay);

    return LoadingController(close: () {
      overlay.remove();
      return true;
    }, update: (text) {
      return true;
    });
  }
}
