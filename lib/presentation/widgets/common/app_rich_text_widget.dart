import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/core/keys/generic_widget_keys.dart';
import 'package:flutter/material.dart';

class AppRichText extends StatelessWidget {
  final String text;
  final List<Map<String, dynamic>> childrenList;
  final Function(int) onChildrenPress;
  final double? size;
  final FontWeight? fontWeight;
  final Color? color;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign? textAlign;
  final String fontFamily;
  final TextOverflow? textOverflow;
  final double? lineHeight;

  const AppRichText(
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
    required this.childrenList,
    required this.onChildrenPress,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      key: Key(AppRichTextWidgetKeys.textRichView),
      softWrap: true,
      maxLines: maxLines,
      overflow: textOverflow,
      textAlign: textAlign,
      //style: DefaultTextStyle.of(context).style,
      style:
          style ??
          TextStyle(
            fontFamily: fontFamily,
            fontSize: size,
            fontWeight: fontWeight,
            color: color,
            height: lineHeight,
          ),
      TextSpan(
        text: text,
        children: List.generate(childrenList.length, (index) {
          Map<String, dynamic> item = childrenList[index];
          return item['clickable']
              ? WidgetSpan(
                  child: GestureDetector(
                    onTap: () => onChildrenPress(index),
                    child: Text(
                      item['title'],
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: size,
                        fontWeight: fontWeight,
                        color: item['color'] ?? color,
                      ),
                    ),
                  ),
                )
              : TextSpan(
                  text: item['title'],
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: size,
                    fontWeight: fontWeight,
                    color: item['color'] ?? color,
                  ),
                );
        }),
      ),
    );
  }
}
