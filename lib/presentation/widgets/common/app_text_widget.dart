import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/core/keys/generic_widget_keys.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String fontFamily;
  final TextOverflow? textOverflow;
  final double? lineHeight;
  final double? letterSpacing;

  const AppText(
    this.text, {
    super.key,
    this.size,
    this.color,
    this.fontWeight,
    this.style,
    this.maxLines,
    this.textAlign = TextAlign.left,
    this.fontFamily = fontPoppins,
    this.textOverflow,
    this.lineHeight,
    this.letterSpacing,
  });

  // factory AppText.proximaNova(String text,{Key? key,
  //         double? size,
  //         FontWeight? fontWeight,
  //         Color? color,
  //         int? maxLines,
  //         TextOverflow? textOverflow,
  //         TextStyle? style,
  //         TextAlign? textAlign,
  //         double? lineHeight,
  // }) => AppText(text, key: key, size: size, fontWeight: fontWeight, color: color, maxLines: maxLines, style: style, fontFamily: fontProximaNova, textAlign: textAlign, textOverflow: textOverflow, lineHeight: lineHeight,);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      softWrap: true,
      key: const Key(AppTextWidgetKeys.textView),
      textAlign: textAlign,
      style: style ?? TextStyle(
            fontFamily: fontFamily,
            fontSize: size,
            fontWeight: fontWeight,
            color: color,
            height: lineHeight,
            letterSpacing: letterSpacing,
          ),
      maxLines: maxLines,
      overflow: textOverflow,
    );
  }
}
