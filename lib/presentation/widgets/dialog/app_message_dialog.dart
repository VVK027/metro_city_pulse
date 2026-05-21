import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_text_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppMessageDialog extends ConsumerWidget {

  final String? title;
  final String msg;
  final String positiveBtn;
  final String? negativeBtn;
  final Function? onPositiveClick;
  final Function? onNegativeClick;

  const AppMessageDialog({super.key, required this.msg, this.title, required this.positiveBtn, this.onPositiveClick, this.negativeBtn, this.onNegativeClick});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = ref.watch(appThemeStateProvider).colors;
    return AlertDialog(
     // key: const Key(AppMessageDialogKeys.alertDialogKey),
      title: title != null ? AppText(title!,
        //key: const Key(AppMessageDialogKeys.titleKey),
        size: 16,) : null,
      content: AppText(msg,
        //key: const Key(AppMessageDialogKeys.messageKey),
        size: 14,),
      actions: <Widget>[
        AppTextButton(
          //key: const Key(AppMessageDialogKeys.positiveBtnKey),
          text: positiveBtn, size: 14, onPressed: () {
          Navigator.of(context).pop();
          onPositiveClick?.call();
        },),
        negativeBtn != null ? AppTextButton(
          //key: const Key(AppMessageDialogKeys.negativeBtnKey),
          text: negativeBtn!, size: 14, onPressed: () {
          Navigator.of(context).pop();
          onNegativeClick?.call();
        }, color: colors.black,): const SizedBox(),
      ],
    );
  }
}