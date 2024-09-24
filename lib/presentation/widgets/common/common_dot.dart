// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_tmsc_app/utils/color.dart';
import 'package:flutter/material.dart';

Widget dot(double size, {Color? color}) => Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color ?? black,
        borderRadius: BorderRadius.circular(100),
      ),
    );
