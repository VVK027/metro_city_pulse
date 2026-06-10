import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_colors.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/dialog/app_custom_message_dialog.dart';
import 'package:metro_city_pulse/presentation/widgets/dialog/app_list_dialog.dart';
import 'package:metro_city_pulse/presentation/widgets/dialog/app_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DialogUtil {

  static Future showWidgetAsDialog(BuildContext context, Widget widget, {bool barrierDismissible = false, Color? barrierColor = const Color(0x66000000)}) async {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (ctx) => widget,
    );
  }

  static Future<T?> showDateRangePopup<T>(BuildContext context, {required Widget child, required Offset position}) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, _, _) {
        return Stack(
          children: [
            Positioned(
              left: position.dx,
              top: position.dy,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: child,
              ),
            ),
            // Positioned(
            //   left: position.dx,
            //   top: position.dy,
            //   child: Material(
            //     elevation: 4,
            //     borderRadius: BorderRadius.circular(12),
            //     child: ConstrainedBox(
            //       constraints: BoxConstraints(maxWidth: 500),
            //       child: child,
            //     ),
            //   ),
            // ),
          ],
        );
      },
    );
  }

  static Future<T?> showWidgetAsBottomSheet<T>(BuildContext context, { required Widget? widget, bool barrierDismissible = false,bool scrollControlled = false, Color? barrierColor = const Color(0x66000000), RoundedRectangleBorder? shape}) async {
    return await showModalBottomSheet<T>(
      context: context,
      backgroundColor: barrierColor,
      isScrollControlled: scrollControlled,
      isDismissible: barrierDismissible,
      barrierColor: barrierColor,
      shape: shape,
      builder: (BuildContext ctx) => widget ?? Container(),
    );
  }


  static Future<dynamic> showMsgDialog({
    required BuildContext context,
    String? title,
    required String msg,
    required String positiveBtn,
    String? negativeBtn,
    Function? onPositiveClick,
    Function? onNegativeClick}) async {
    return showWidgetAsDialog(context,
        AppMessageDialog(
          //key: const Key(DialogUtilsKeys.messageDialogKey),
          title: title,
          msg: msg,
          positiveBtn: positiveBtn,
          negativeBtn: negativeBtn,
          onPositiveClick: onPositiveClick,
          onNegativeClick: onNegativeClick,), barrierDismissible: false);
  }

  static Future<dynamic> showCustomMsgDialog({
    required BuildContext context,
    final String? title,
    final Widget? titleWidget,
    final String? msg,
    final Widget? msgWidget,
    final String? positiveBtn,
    final String? negativeBtn,
    final Function? onPositiveClick,
    final Function? onNegativeClick,
    final Color? positiveBtnTextColor,
    final Color? negativeBtnTextColor,
    final Color? positiveBtnBgColor,
    final int? titleFontSize,
    final FontWeight? titleFontWeight,
    final int? msgFontSize,
    final FontWeight? msgFontWeight,
    final int? positiveBtnFontSize,
    final FontWeight? positiveBtnFontWeight,
    final int? negativeBtnFontSize,
    final bool barrierDismissible = false,
    final Color? dividerColor,
    final FontWeight? negativeBtnFontWeight}) async {
    return showWidgetAsDialog(context,
        AppCustomMessageDialog(
         // key: const Key(DialogUtilsKeys.messageDialogKey),
          title: title,
          titleWidget: titleWidget,
          msg: msg,
          msgWidget: msgWidget,
          negativeBtnTextColor: negativeBtnTextColor,
          positiveBtnTextColor: positiveBtnTextColor,
          positiveBtn: positiveBtn,
          negativeBtn: negativeBtn,
          onPositiveClick: onPositiveClick,
          onNegativeClick: onNegativeClick,
          positiveBtnBgColor: positiveBtnBgColor,
          titleFontWeight: titleFontWeight,
          titleFontSize: titleFontSize,
          msgFontWeight: msgFontWeight,
          msgFontSize: msgFontSize,
          positiveBtnFontWeight: positiveBtnFontWeight,
          positiveBtnFontSize: positiveBtnFontSize,
          negativeBtnFontWeight: negativeBtnFontWeight,
          negativeBtnFontSize: negativeBtnFontSize,
          dividerColor: dividerColor,
        ), barrierDismissible: barrierDismissible,);
  }

  static void showSnackBar(BuildContext context, String msg, {Duration duration = const Duration(seconds: 2)}) {
    final snackBar = SnackBar(
     // key: const Key(DialogUtilsKeys.snackBarKey),
      content: AppText(msg, 
        //key: const Key(DialogUtilsKeys.snackBarTextKey),
         size: 14,),
      duration: duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /* msgType = 0 - Success, 1 - Warning, 2 - Failure */
  static void showCustomTopSnackBar(BuildContext context, String msg, {Duration duration = const Duration(seconds: 2),required AppColors colors, int msgType = 0}) {
    // TODO:  Need to change colors accordingly based on UX design
    Color bgColor = colors.black;
    Color msgColor = colors.white;
    IconData icon = Icons.check_circle_rounded;
    if(msgType == 1) {
      // bgColor = colors.colorFBE199;
      // msgColor =  colors.colorAB7E00;
      icon = Icons.priority_high_rounded;
    } else if(msgType == 2) {

      // bgColor = colors.color21D31145;
      // msgColor =  colors.colorD31145;
      icon = Icons.error;
    } else {
      bgColor = colors.black;
      msgColor =  colors.white;
    }

    final snackBar = SnackBar(
     // key: const Key(DialogUtilsKeys.snackBarSuccessKey),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      backgroundColor: bgColor,
      margin: EdgeInsets.only(bottom: MediaQuery.sizeOf(context).height - 140, left: 0),
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(icon, color: msgColor),
          ),
          Expanded(child: AppText(msg,
              // key: const Key(DialogUtilsKeys.snackBarTextKey),
              size: 14, fontWeight: FontWeight.w700, color: msgColor, maxLines: 1, textOverflow: TextOverflow.ellipsis)),
        ],
      ),
      duration: duration,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showLoader(BuildContext context) {
    showWidgetAsDialog(context, Consumer(
      builder: (context, ref, child) {
        final colors = ref.watch(appThemeStateProvider).colors;
        return Center(child: Container(height: 100, width: 100, decoration: BoxDecoration(
            color: colors.white,
            borderRadius: BorderRadius.circular(10.0)
        ), alignment: Alignment.center,
            child: CircularProgressIndicator(color: colors.defaultBlueColor),
        ),
        );
        },),);
  }

  static void hideLoader(BuildContext context) {
    Navigator.pop(context);
  }
  
  static void showListDialog<T>(
      { required BuildContext context,
        required List<T> items,
        required Function(T) onItemSelected,
        String? heading,
        String Function(T)? getTextFromItem,
        Widget Function(T, int, bool)? displayBuilder,
        Widget Function(T, int, bool)? separatorBuilder,
        int initialSelectedIndex = 0,
        String? confirmBtnText,
        String? cancelBtnText,
        double? width,
        double? height,
        EdgeInsets? padding,
        double? posLeft,
        double? posRight,
        double? posTop,
        double? posBottom,
        double? headingTextSize,
      }) {
    showWidgetAsDialog(context, AppListDialog<T>(
        //key: const Key(DialogUtilsKeys.listDialogKey),
        items: items,
        onItemSelected: onItemSelected,
        heading: heading,
        getTextFromItem: getTextFromItem,
        displayBuilder: displayBuilder,
        separatorBuilder: separatorBuilder,
        initialSelectedIndex: initialSelectedIndex,
        confirmBtnText: confirmBtnText,
        cancelBtnText: cancelBtnText,
        padding: padding ?? EdgeInsets.zero,
        width: width,
        height: height,
        posLeft: posLeft,
        posRight: posRight,
        posTop: posTop,
        posBottom: posBottom,
        headingTextSize: headingTextSize ?? 17.0,
    ));
  }

  static void showAcknowledgeDialog(BuildContext context, String msg, String title, Function onAcknowledge, Color buttonColor) {
    DialogUtil.showCustomMsgDialog(
        context: context,
        title: title.toUpperCase(),
        msg: msg,
        positiveBtn: title,
        positiveBtnBgColor: buttonColor,
        barrierDismissible: true,
        onPositiveClick: () {
          onAcknowledge.call();
        }
    );
  }
}