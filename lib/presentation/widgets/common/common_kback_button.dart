// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/extensions/context_extension.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/utils/app_icon.dart';

class KBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  const KBackButton({
    Key? key,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap ?? () => context.pop(),
      icon: Image.asset(
        AppIcon.back,
        scale: 3,
      ),
    );
  }
}
