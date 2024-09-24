import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  pop() => Navigator.pop(this);
}
