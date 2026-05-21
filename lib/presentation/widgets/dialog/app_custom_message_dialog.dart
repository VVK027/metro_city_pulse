import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_text_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppCustomMessageDialog extends ConsumerWidget {

  final String? title;
  final Widget? titleWidget;
  final String? msg;
  final Widget? msgWidget;
  final String? positiveBtn;
  final String? negativeBtn;
  final Function? onPositiveClick;
  final Function? onNegativeClick;
  final Color? negativeBtnTextColor;
  final Color? positiveBtnTextColor;
  final Color? positiveBtnBgColor;
  final int? titleFontSize;
  final FontWeight? titleFontWeight;
  final int? msgFontSize;
  final FontWeight? msgFontWeight;
  final int? positiveBtnFontSize;
  final FontWeight? positiveBtnFontWeight;
  final int? negativeBtnFontSize;
  final FontWeight? negativeBtnFontWeight;
  final Color? dividerColor;

  const AppCustomMessageDialog({super.key,
  this.msg,
  this.msgWidget,
  this.title,
  this.titleWidget,
  required this.positiveBtn,
  this.onPositiveClick,
  this.negativeBtn,
  this.onNegativeClick,
  this.negativeBtnTextColor,
  this.positiveBtnTextColor,
  this.positiveBtnBgColor,
  this.titleFontSize,
  this.titleFontWeight,
  this.msgFontSize,
  this.msgFontWeight,
  this.positiveBtnFontSize,
  this.positiveBtnFontWeight,
  this.negativeBtnFontSize,
  this.negativeBtnFontWeight,
  this.dividerColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeStateProvider).colors;
    return AlertDialog(
       // key: const Key(AppMessageDialogKeys.alertDialogKey),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      content: Column(
       // key: const Key(AppMessageDialogKeys.columnKey),
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          title != null
              ? AppText(title!,
            //key: const Key(AppMessageDialogKeys.titleKey),
            size: titleFontSize?.toDouble() ?? 15,
            fontWeight: FontWeight.w700,
            color: colors.black,
          ) : titleWidget ?? const SizedBox(),
          SizedBox(height: (title != null || titleWidget != null) ? 20 : 0),
          msgWidget ?? AppText(msg ?? "",
           // key: const Key(AppMessageDialogKeys.messageKey),
            size: msgFontSize?.toDouble() ?? 13,
            fontWeight: FontWeight.w400,
            color: colors.black,
          ),
          const SizedBox(height: 20,),
          dividerColor!=null? Divider(color: dividerColor):const SizedBox(),
          positiveBtn != null
              ? AppTextButton(
           // key: const Key(AppMessageDialogKeys.positiveBtnKey),
            text: positiveBtn!,
           // enableTextColor: positiveBtnTextColor,
            height: 40,
            size: positiveBtnFontSize?.toDouble() ?? 15.0,
           // enableBgColor: positiveBtnBgColor,
            fontWeight: positiveBtnFontWeight ?? FontWeight.w400,
            onPressed: () {
              Navigator.of(context).pop();
              onPositiveClick?.call();
            },)
              : const SizedBox(),
          dividerColor!=null
              ? Divider(color: dividerColor)
              : SizedBox(height: positiveBtn != null && negativeBtn != null ? 20 : 0,),
          negativeBtn != null
              ? AppTextButton(
          //  key: const Key(AppMessageDialogKeys.negativeBtnKey),
            text: negativeBtn!,
            size: negativeBtnFontSize?.toDouble() ?? 16.0,
            fontWeight: negativeBtnFontWeight ?? FontWeight.w700,
            onPressed: () {
              Navigator.of(context).pop();
              onNegativeClick?.call();
            },
            color: negativeBtnTextColor ?? colors.black,)
              : const SizedBox(),
        ],
      )
    );
  }
}