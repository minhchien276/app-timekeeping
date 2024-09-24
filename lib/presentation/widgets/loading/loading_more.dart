import 'package:e_tmsc_app/presentation/widgets/loading/loading_circle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 40.h,
      padding: EdgeInsets.all(6.h),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(100),
      ),
      child: const LoadingCircle(width: 3),
    );
  }
}
