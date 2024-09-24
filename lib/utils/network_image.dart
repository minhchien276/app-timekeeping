import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_tmsc_app/utils/app_icon.dart';
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

Widget networkImageWithCached({
  required Size size,
  required String? url,
  double? borderRadius,
  BoxBorder? boxBorder,
  String? placeholder,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: boxBorder,
      borderRadius: BorderRadius.circular(1000), // Bo góc của ClipRRect
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 24),
      child: Container(
        height: size.height == 0 ? null : size.height,
        width: size.width == 0 ? null : size.width,
        color: white,
        child: url != null && url.isNotEmpty
            ? CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    const Center(
                  child: CircularProgressIndicator.adaptive(
                    backgroundColor: primary400,
                    valueColor: AlwaysStoppedAnimation<Color>(primary100),
                  ),
                ),
                errorWidget: (context, _, __) {
                  return Image.asset(
                    placeholder ?? AppIcon.avtIcon,
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                placeholder ?? AppIcon.avtIcon,
                fit: BoxFit.cover,
              ),
      ),
    ),
  );
}
