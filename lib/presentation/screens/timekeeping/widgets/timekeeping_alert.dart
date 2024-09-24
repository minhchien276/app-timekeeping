// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/shared/enums/check_enum.dart';
import 'package:flutter/material.dart';

import 'package:e_tmsc_app/presentation/screens/timekeeping/widgets/timekeeping_string.dart';
import 'package:e_tmsc_app/utils/button_string.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';

class TimekeepingAlert extends StatelessWidget {
  final bool isSucces;
  final CheckEnum type;
  final VoidCallback callback;
  const TimekeepingAlert({
    Key? key,
    required this.isSucces,
    required this.type,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              isSucces ? 'assets/icons/active.png' : 'assets/icons/fail.png',
              scale: 2,
            ),
            const SizedBox(width: 14),
            TextWidget(
              text: isSucces
                  ? TimekeepingString.checkInSuccess
                  : TimekeepingString.checkInFail,
              fontWeight: FontWeight.w500,
              size: 18,
              color: white,
            ),
          ],
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: callback,
          child: TextWidget(
            text: isSucces ? ButtonStrings.confirmBtn : ButtonStrings.tryBtn,
            fontWeight: FontWeight.w600,
            size: 14,
            color: greyText,
          ),
        ),
      ],
    );
  }
}
