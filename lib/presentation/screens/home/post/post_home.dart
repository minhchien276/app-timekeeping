// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PostHome extends StatelessWidget {
  final bool? isFirst;
  final BlogModel blog;
  const PostHome({
    Key? key,
    this.isFirst,
    required this.blog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(AppRoute.postDetail.name, extra: blog),
      child: Container(
        height: 226.h,
        width: 285.w,
        margin: EdgeInsets.only(right: 8.w, left: isFirst == true ? 24.w : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: neutral300),
        ),
        child: Stack(
          children: [
            networkImageWithCached(size: Size(285.w, 226.h), url: blog.image),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 83.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xff000000).withOpacity(0.8),
                        const Color(0xff302F2F).withOpacity(0.5),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                    children: [
                      14.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              text: blog.title ?? '',
                              color: white,
                              textStyle: textStyle15SemiBold,
                              maxLines: 2,
                            ),
                            TextWidget(
                              text: blog.content ?? '',
                              color: white,
                              textStyle: textStyle10,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 14.w,
                        ),
                        height: 24.h,
                        width: 71.w,
                        decoration: BoxDecoration(
                          color: primary900,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: TextWidget(
                            text: 'Xem thêm',
                            color: white,
                            textStyle: textStyle10SemiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
