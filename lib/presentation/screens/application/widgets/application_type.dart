// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/application_model.dart';
import 'package:e_tmsc_app/presentation/screens/application/widgets/application_item.dart';
import 'package:e_tmsc_app/presentation/widgets/loading/loading_more.dart';
import 'package:e_tmsc_app/shared/enums/user_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/extensions/datetime_extension.dart';
import '../../../../utils/color.dart';
import '../../../../utils/styles.dart';
import '../../../widgets/common/common_custom_text.dart';

class ApplicationType extends StatelessWidget {
  final DateTime date;
  final List<ApplicationModel> applications;
  final UserEnum userEnum;
  final bool isLast;
  final bool isFirst;
  final bool isLoading;
  const ApplicationType({
    Key? key,
    required this.date,
    required this.applications,
    required this.userEnum,
    required this.isLast,
    required this.isLoading,
    required this.isFirst,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 24.w, right: 24.w, top: isFirst ? 12.h : 20.h),
          child: TextWidget(
            text: formatNotiDate(date),
            color: black,
            textStyle: textStyle12.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        Column(
          children: List.generate(
            applications.length,
            (index) => ApplicationItem(
              item: applications[index],
              userEnum: userEnum,
            ),
          ),
        ),
        isLast ? 40.verticalSpace : 0.verticalSpace,
        if (isLast && isLoading) ...[
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LoadingMore(),
                isLast ? 20.verticalSpace : 0.verticalSpace,
              ],
            ),
          ),
        ],
      ],
    );
  }
}
