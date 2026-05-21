import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_text_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppImagePickerDialog extends StatelessWidget {

  final WidgetRef ref;

  const AppImagePickerDialog({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
     // key: const Key(AppMessageDialogKeys.alertDialogKey),
      title: AppText('select_image'.tr(ref),
          //key: const Key(AppMessageDialogKeys.titleKey),
          size: 16, textAlign: TextAlign.center),
      actions: <Widget>[
        AppTextButton(
          //key: const Key(AppMessageDialogKeys.positiveBtnKey),
          text: "select_from_gallery".tr(ref), size: 14, textAlign: TextAlign.right,
          maxLines: 2, height: 56,
          onPressed: () async {
            Navigator.of(context).pop(0);
          },
        ),
        AppTextButton(
          //key: const Key(AppMessageDialogKeys.negativeBtnKey),
          text: "take_photo".tr(ref),
          size: 14, textAlign: TextAlign.right,
          maxLines: 2, height: 56,
          onPressed: () async {
            Navigator.of(context).pop(1);
          },
        ),
        AppTextButton(
         // key: const Key(AppMessageDialogKeys.cancelBtnKey),
          text: "cancel".tr(ref),
          size: 14, textAlign: TextAlign.right,
          maxLines: 2, height: 56,
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}