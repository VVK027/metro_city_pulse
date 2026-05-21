import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/user_avatar_button_component.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideMenu extends StatelessWidget {
  final AppTheme theme;
  final WidgetRef ref;
  final MenuItemType selectedItem;
  final Function(MenuItemType)? onMenuSelected;
  final Function(int)? onTimeSelected;

  const SideMenu({
    super.key,
    required this.theme,
    required this.onMenuSelected,
    required this.selectedItem,
    this.onTimeSelected,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final assets = theme.assets;
    final colors = theme.colors;

    return Container(
      width: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.gradientColor1, colors.gradientColor2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          AppImage(
            assets.policeLogo,
            width: 40,
            height: 40,
            color: colors.white,
          ),
          const SizedBox(height: 16),
          SideMenuItem(
            icon: assets.dashboardIcon,
            color: colors.white,
            label: "dashboard".tr(ref).toAllCapitalize(),
            isSelected: selectedItem == MenuItemType.dashboard,
            onTap: () {
              onMenuSelected?.call(MenuItemType.dashboard);
              if (Responsive.isMobile(context)) {
                Navigator.pop(context);
              }
            },
          ),
          SideMenuItem(
            icon: assets.dashboardIcon,
            color: colors.white,
            label: "stats".tr(ref).toAllCapitalize(),
            isSelected: selectedItem == MenuItemType.stats,
            onTap: () {
              onMenuSelected?.call(MenuItemType.stats);
              if (Responsive.isMobile(context)) {
                Navigator.pop(context);
              }
            },
          ),
          SideMenuItem(
            icon: assets.alertsIcon,
            color: colors.white,
            label: "alerts".tr(ref).toAllCapitalize(),
            isSelected: selectedItem == MenuItemType.alerts,
            onTap: () {
              onMenuSelected?.call(MenuItemType.alerts);
              if (Responsive.isMobile(context)) {
                Navigator.pop(context);
              }
            },
          ),
          Visibility(
            visible: Responsive.isMobile(context),
            child: SideMenuItem(
              icon: assets.userProfileIcon,
              color: colors.white,
              label: "profile".tr(ref).toAllCapitalize(),
              isSelected: selectedItem == MenuItemType.profile,
              onTap: () {
                onMenuSelected?.call(MenuItemType.profile);
                if (Responsive.isMobile(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          Visibility(
            visible: Responsive.isMobile(context),
            child: SideMenuItem(
              icon: assets.settingIcon,
              color: colors.white,
              label: "settings".tr(ref).toAllCapitalize(),
              isSelected: selectedItem == MenuItemType.settings,
              onTap: () async {
                onMenuSelected?.call(MenuItemType.settings);
                if (Responsive.isMobile(context)) {
                  Navigator.pop(context);
                }
              },
            ),
          ),
          const Spacer(),
          // is case of Mobile handle bottom items
          Visibility(
            visible: Responsive.isMobile(context),
            child: SideMenuItem(
              icon: assets.userProfileIcon,
              color: colors.white,
              label: "logout".tr(ref).toAllCapitalize(),
              isSelected: selectedItem == MenuItemType.logout,
              onTap: () {
                if (Responsive.isMobile(context)) {
                  Navigator.pop(context);
                }
                onMenuSelected?.call(MenuItemType.logout);
              },
            ),
          ),
          // Refresh Icon
          Visibility(
            visible: !Responsive.isMobile(context),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    //TODO: need to modify based on the time selection on UI.
                    onTimeSelected?.call(10);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: colors.accent.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppImage(
                            assets.refreshIcon,
                            width: 22,
                            height: 22,
                          ),
                        ),
                        const SizedBox(height: 6),
                        AppText(
                          "10\n${"minutes_short".tr(ref)}",
                          textAlign: TextAlign.center,
                          color: colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                UserAvatarButtonComponent(
                  ref: ref,
                  theme: theme,
                  profilePic: '',
                  isSideMenu: true,
                  userName: 'Viivek Kumar',
                  onActionSelected: (value) {
                    if (value == 0) {
                      // Profile action
                      onMenuSelected?.call(MenuItemType.profile);
                    } else if (value == 1) {
                      // Settings action
                      onMenuSelected?.call(MenuItemType.settings);
                    } else if (value == 2) {
                      // Logout action
                      onMenuSelected?.call(MenuItemType.logout);
                    }
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  final String icon;
  final String label;
  final Color? color;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const SideMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: Responsive.isMobile(context) ? 2.0 : 10.0,
        ),
        padding: const EdgeInsets.symmetric(vertical: 6),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Responsive.isMobile(context)
            ? Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 10),
                    _getIconWidget(color),
                    const SizedBox(width: 10),
                    AppText(
                      label,
                      textAlign: TextAlign.center,
                      color: color,
                      size: 16,
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  _getIconWidget(color),
                  const SizedBox(height: 6),
                  AppText(
                    label,
                    textAlign: TextAlign.center,
                    size: 10,
                    color: color,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _getIconWidget(dynamic color) {
    return AppImage(icon, width: 18, height: 18, color: color);
  }
}
