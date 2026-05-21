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
            icon: assets.statsIcon,
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
          SideMenuItem(
            iconData: Icons.notifications_none_rounded,
            color: colors.white,
            label: "notifications".tr(ref).toAllCapitalize(),
            isSelected: false,
            onTap: () {
              _showNotificationsSnackBar(context);
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

  void _showNotificationsSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('no_new_notifications'.tr(ref)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class SideMenuItem extends StatelessWidget {
  static const double _kIconSize = 20;
  static const double _kIconBoxSize = 24;

  final String? icon;
  final IconData? iconData;
  final String label;
  final Color? color;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const SideMenuItem({
    super.key,
    this.icon,
    this.iconData,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: isMobile ? 2 : 4),
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 8 : 10,
          horizontal: isMobile ? 12 : 0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white24 : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: isMobile
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 10),
                  _buildIcon(color),
                  const SizedBox(width: 10),
                  AppText(
                    label,
                    textAlign: TextAlign.center,
                    color: color,
                    size: 16,
                  ),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildIcon(color),
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

  Widget _buildIcon(Color? color) {
    return SizedBox(
      width: _kIconBoxSize,
      height: _kIconBoxSize,
      child: Center(
        child: iconData != null
            ? Icon(iconData, size: _kIconSize, color: color)
            : AppImage(
                icon!,
                width: _kIconSize,
                height: _kIconSize,
                color: color,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
