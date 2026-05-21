import 'package:metro_city_pulse/core/keys/generic_widget_keys.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/utils/app_utils.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class AppAvatarWithEditWidget extends StatelessWidget {
  final AppTheme theme;
  final Function()? onPressed;
  final String profilePic;
  final String userName;
  final double size;
  final bool isEditRequired;

  const AppAvatarWithEditWidget({
    super.key,
    required this.theme,
    this.profilePic = '',
    this.size = 150.0,
    this.onPressed,
    required this.userName,
    this.isEditRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = theme.colors;
    final assets = theme.assets;
    double radius = size / 2;
    double fontSize = (size >= 150) ? (size / 3) : size / 2.4;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: InkWell(
        key: const Key(AppAvatarWithEditWidgetKeys.profilePicPressedKey),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        onTap: onPressed,
        child: Stack(
          children: [
            (profilePic.isNotEmpty)
                ? AppImage(
                    (profilePic.isEmpty) ? assets.userProfileIcon : profilePic,
                    key: const Key(AppAvatarWithEditWidgetKeys.profilePicKey),
                    isFromAssets: profilePic.isEmpty,
                    height: size,
                    width: size,
                    fit: BoxFit.fill,
                  )
                : Container(
                    key: const Key(
                      AppAvatarWithEditWidgetKeys.gradientContainerKey,
                    ),
                    height: size,
                    width: size,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: const [0.0, 1.0],
                        colors: [
                          colors.tempGradientColor1,
                          colors.gradientColor2,
                        ],
                      ),
                      border: Border.all(
                        color: colors.white.withValues(alpha: 0.3),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colors.black.withValues(alpha: 0.16),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: AppText(
                      AppUtils.getShortNamedString(userName),
                      key: const Key(
                        AppAvatarWithEditWidgetKeys.userShortNameKey,
                      ),
                      size: fontSize,
                      color: colors.white,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                    ),
                  ),
            Visibility(
              visible: isEditRequired,
              child: Positioned(
                bottom: 0,
                child: Container(
                  width: size,
                  height: 35,
                  alignment: Alignment.center,
                  //color: colors.containerColor1.withOpacity(0.75),
                  child: AppText(
                    key: const Key(AppAvatarWithEditWidgetKeys.userEditKey),
                    '', //'''edit'.tr(ref),
                    size: 16,
                    // color: colors.tileBackgroundColor,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
