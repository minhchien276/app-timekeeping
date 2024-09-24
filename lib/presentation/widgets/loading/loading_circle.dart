// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/utils/color.dart';

class LoadingCircle extends StatelessWidget {
  final double? width;
  final Color? color;
  const LoadingCircle({
    Key? key,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? white,
      strokeWidth: width ?? 4,
    );
  }
}
