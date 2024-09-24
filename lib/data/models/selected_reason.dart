import 'package:e_tmsc_app/data/models/reason.dart';

class SelectedReason {
  Reason reason;
  bool hasSelect;
  SelectedReason({
    required this.reason,
    required this.hasSelect,
  });

  copyWith() {
    return SelectedReason(
      reason: reason,
      hasSelect: hasSelect,
    );
  }
}
