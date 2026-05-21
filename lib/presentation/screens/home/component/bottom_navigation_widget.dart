import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BottomNavigationWidget extends ConsumerWidget {
  final AppTheme theme;
  final int? currentIndex;
  final ValueChanged<int>? onTap;

  const BottomNavigationWidget({
    super.key,
    required this.theme,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double iconSize = 20.0;
    return BottomNavigationBar(
      backgroundColor: theme.colors.background,
      selectedItemColor: theme.colors.selectedColor,
      unselectedItemColor: theme.colors.unSelectedColor,
      iconSize: iconSize,
      elevation: 8.0,
      selectedFontSize: iconSize - 8,
      unselectedFontSize: iconSize - 10,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: AppImage(
            theme.assets.dashboardIcon,
            color: currentIndex == 0
                ? theme.colors.selectedColor
                : theme.colors.unSelectedColor,
            width: iconSize,
            height: iconSize,
          ),
          label: 'dashboard'.tr(ref).toAllCapitalize(),
        ),
        BottomNavigationBarItem(
          icon: AppImage(
            theme.assets.alertsIcon,
            color: currentIndex == 1
                ? theme.colors.selectedColor
                : theme.colors.unSelectedColor,
            width: iconSize,
            height: iconSize,
          ),
          label: 'alerts'.tr(ref).toAllCapitalize(),
        ),
        BottomNavigationBarItem(
          icon: AppImage(
            theme.assets.chatbotIcon,
            color: currentIndex == 2
                ? theme.colors.selectedColor
                : theme.colors.unSelectedColor,
            width: iconSize,
            height: iconSize,
          ),
          label: 'chat_ai'.tr(ref).toAllCapitalize(),
        ),
      ],
      currentIndex: currentIndex ?? -1,
      onTap: onTap,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(
        color: theme.colors.selectedColor,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        color: theme.colors.unSelectedColor,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
