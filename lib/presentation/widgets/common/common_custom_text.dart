import 'package:flutter/widgets.dart';

// text widget to using alter text in project
class TextWidget extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? size;
  final Color color;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLines;
  final TextStyle? textStyle;
  const TextWidget({
    Key? key,
    required this.text,
    this.fontWeight,
    this.size,
    required this.color,
    this.textAlign,
    this.textDecoration,
    this.maxLines,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle?.copyWith(
            color: color,
            decoration: textDecoration,
            decorationColor: color,
          ) ??
          TextStyle(
            fontFamily: 'BeauSans',
            fontSize: size,
            fontWeight: fontWeight,
            color: color,
            decoration: textDecoration,
            decorationColor: color,
          ),
      maxLines: maxLines ?? 2,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
    );
  }
}
