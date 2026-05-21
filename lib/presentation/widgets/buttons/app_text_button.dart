import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String fontFamily;
  final double? width;
  final double? height;
  final bool enabled;
  final ButtonStyle? buttonStyle;
  final TextOverflow? textOverflow;
  final double? lineHeight;


  const AppTextButton({super.key,
    required this.text,
    this.onPressed,
    this.size,
    this.color,
    this.fontWeight,
    this.style,
    this.maxLines,
    this.width,
    this.height = 44,
    this.enabled = true,
    this.textAlign = TextAlign.left,
    this.fontFamily = fontPoppins,
    this.buttonStyle,
    this.textOverflow,
    this.lineHeight
  });

  // factory AppTextButton.Poppins({required String text,
  //     Key? key,
  //     double? size,
  //     FontWeight? fontWeight,
  //     Color? color,
  //     int? maxLines,
  //     TextStyle? style,
  //     TextAlign? textAlign,
  //     Function()? onPressed,
  //     double? width,
  //     bool enabled = true,
  //     double? height = 44,
  //     ButtonStyle? buttonStyle,
  //     TextOverflow? textOverflow,
  //     double? lineHeight,
  // }) => AppTextButton(key: key,
  //   text: text,
  //   size: size,
  //   fontWeight: fontWeight,
  //   color: color,
  //   maxLines: maxLines,
  //   style: style,
  //   width: width,
  //   height: height,
  //   fontFamily: fontPoppins,
  //   onPressed: enabled ? onPressed : null,
  //   buttonStyle: buttonStyle,
  //   textOverflow: textOverflow,
  //   lineHeight: lineHeight,
  // );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          //key: const Key(AppTextButtonKeys.button),
        style: buttonStyle,
        onPressed: onPressed,
        child: AppText(text,
          //key: const Key(AppTextButtonKeys.buttonText),
        size: size,
        fontWeight: fontWeight,
        color: color,
        maxLines: maxLines,
        style: style,
        textAlign: textAlign,
        fontFamily: fontFamily,
        textOverflow: textOverflow,
        lineHeight: lineHeight,)),
    );
  }
}

