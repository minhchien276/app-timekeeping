// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_custom_text.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_kback_button.dart';
import 'package:e_tmsc_app/routes/go_routes.dart';
import 'package:e_tmsc_app/shared/extensions/datetime_extension.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:e_tmsc_app/utils/network_image.dart';
import 'package:e_tmsc_app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../utils/app_icon.dart';

class PostScreen extends StatelessWidget {
  final List<BlogModel> posts;
  const PostScreen({
    Key? key,
    required this.posts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary900,
      appBar: AppBar(
        backgroundColor: primary900,
        centerTitle: true,
        leading: const KBackButton(),
        title: TextWidget(
          text: 'Tin tức nội bộ',
          color: white,
          textStyle: textStyle17Bold,
        ),
      ),
      body: Container(
        height: context.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return postItem(
              blog: posts[index],
              isLast: index == posts.length - 1,
              context: context,
            );
          },
        ),
      ),
    );
  }

  Widget postItem({
    required BlogModel blog,
    required bool isLast,
    required BuildContext context,
  }) =>
      InkWell(
        onTap: () => context.pushNamed(AppRoute.postDetail.name, extra: blog),
        child: Container(
          padding: EdgeInsets.only(
              left: 28.w, right: 18.w, top: 18.h, bottom: isLast ? 70.h : 0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      height: 35.h,
                      width: 35.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: primary900),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(17))),
                      child: Image.asset(AppIcon.group, scale: 3.5)),
                  8.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Hành chính nhân sự',
                        color: black,
                        textStyle: textStyle14SemiBold,
                      ),
                      TextWidget(
                        text: formatPostDateTime(blog.createdAt),
                        color: black,
                        textStyle: textStyle10SemiBold,
                      ),
                    ],
                  ),
                ],
              ),
              16.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: blog.title ?? '',
                          color: black,
                          textStyle: textStyle16Bold,
                          maxLines: 2,
                        ),
                        15.verticalSpace,
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: primary900,
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(
                              color: primary900,
                              width: 1,
                            ),
                          ),
                          child: TextWidget(
                            text: 'Xem thêm',
                            color: Colors.white,
                            textStyle: textStyle11Bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  15.horizontalSpace,
                  networkImageWithCached(
                    size: Size(120.w, 90.h),
                    url: blog.image,
                    borderRadius: 4,
                  ),
                ],
              ),
              10.verticalSpace,
              isLast == false
                  ? Divider(
                      color: primary900,
                      thickness: 0.5,
                    )
                  : Container(),
            ],
          ),
        ),
      );
}
