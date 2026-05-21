import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/app_bar_action_buttons.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/responsive_date_range_selector.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/user_avatar_button_component.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_custom_outlined_button.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_elevated_icon_button.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_tab_bar_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardAppBar extends ConsumerWidget implements PreferredSizeWidget {
  static const double _kAppBarControlGap = 8;
  static const double _kDefaultIconSize = 32;

  final String title, userName;
  final String? userProfilePic;
  final AppTheme theme;
  final Function()? onMenuPressed;
  final Function()? onLogoutPressed;
  final Function()? onFilterSelect;
  final Function()? onDateRangePressed;
  final Function()? onClockPressed;
  final Function()? onLivePressed;

  const DashboardAppBar({
    super.key,
    required this.title,
    required this.userName,
    this.userProfilePic,
    required this.theme,
    this.onMenuPressed,
    this.onLogoutPressed,
    this.onFilterSelect,
    this.onDateRangePressed,
    this.onClockPressed,
    this.onLivePressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isMobile =
        Responsive.isMobile(context) || Responsive.isSmallerTablet(context);
    final bool isTablet = Responsive.isTablet(context);

    final tabBarProviderNotifier = ref.read(tabBarProvider.notifier);
    final TabBarType selectedTabItem = ref.watch(tabBarProvider);

    final casesCounts = ref.watch(
      remoteMarkersProvider.select(
        (value) => value.value?.casesCounts ?? const <String, int>{},
      ),
    );

    return AppBar(
      backgroundColor: theme.colors.appBarBackgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: kToolbarHeight,
      leading: isMobile
          ? IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: onMenuPressed,
            )
          : null,
      centerTitle: false,
      title: isMobile
          ? _buildAppBarTitle()
          : Padding(
              padding: const EdgeInsets.only(left: 16),
              child: _buildAppBarTitle(),
            ),
      titleSpacing: 0,
      actionsPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 12),
      actions: [
        if (isMobile) ...[
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colors.primaryColor,
            child: IconButton(
              iconSize: _kDefaultIconSize - 6,
              icon: AppImage(theme.assets.filterIcon, color: Colors.white),
              onPressed: onFilterSelect,
            ),
          ),
          const SizedBox(width: _kAppBarControlGap),
          AppBarActionButtons(theme: theme),
          const SizedBox(width: _kAppBarControlGap),
          UserAvatarButtonComponent(
            ref: ref,
            theme: theme,
            profilePic: userProfilePic ?? '',
            userName: userName,
            size: _kDefaultIconSize,
            onActionSelected: (value) {
              if (value == 0) {
                NavigationUtil.push(context, '/profile');
              } else if (value == 1) {
                NavigationUtil.push(context, '/settings');
              } else if (value == 2) {
                onLogoutPressed?.call();
              }
            },
          ),
        ] else
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTabBar(
                ref,
                tabBarProviderNotifier,
                selectedTabItem,
                isMobile,
                isTablet,
                theme,
                casesCounts,
              ),
              const SizedBox(width: _kAppBarControlGap),
              buildDateRangeButton(
                isTablet,
                onDateRangePressed,
                foregroundColor: Colors.white,
                borderColor: Colors.white38,
              ),
              const SizedBox(width: _kAppBarControlGap),
              buildClockButton(onClockPressed, theme),
              const SizedBox(width: _kAppBarControlGap),
              buildLiveWidget(isTablet, onLivePressed, theme, ref),
              const SizedBox(width: _kAppBarControlGap),
              AppBarActionButtons(theme: theme),
              const SizedBox(width: _kAppBarControlGap),
              UserAvatarButtonComponent(
                ref: ref,
                theme: theme,
                profilePic: userProfilePic ?? '',
                userName: userName,
                size: _kDefaultIconSize,
                onActionSelected: (value) {
                  if (value == 0) {
                    NavigationUtil.push(context, '/profile');
                  } else if (value == 1) {
                    NavigationUtil.push(context, '/settings');
                  } else if (value == 2) {
                    onLogoutPressed?.call();
                  }
                },
              ),
            ],
          ),
      ],
    );
  }

  /// App bar title widget.
  Widget _buildAppBarTitle() {
    return AppText(
      title.toAllCapitalize(),
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}

/// The below components will get access publicly in the app.
/// Custom tab bar with callback for switching tabs.
Widget buildTabBar(
  WidgetRef ref,
  StateController<TabBarType> tabBarProviderNotifier,
  TabBarType selectedTab,
  bool isMobile,
  bool isTablet,
  AppTheme theme,
  Map<String, int> casesCounts,
) {
  return AppTabBarWidget(
    theme: theme,
    isWide: !(isMobile || isTablet),
    listTabs: List.generate(TabBarType.values.length, (index) {
      final item = TabBarType.values[index];
      return {
        'label': item.statusKey.tr(ref).toAllCapitalize(),
        'value': casesCounts[item.statusKey] ?? 0,
        'isActive': selectedTab == item,
      };
    }),
    onTabPressed: (index) {
      switch (index) {
        case 0:
          tabBarProviderNotifier.state = TabBarType.newTab;
          break;
        case 1:
          tabBarProviderNotifier.state = TabBarType.dispatch;
          break;
        case 2:
          tabBarProviderNotifier.state = TabBarType.cases;
          break;
      }
    },
  );
}

/// Date Range Picker button.
Widget buildDateRangeButton(bool isTablet, Function()? onDateRangePressed, {Color? foregroundColor, Color? borderColor}) {
  return SizedBox(
    height: 36,
    child: ResponsiveDateRangeSelector(
      isTablet: isTablet,
      foregroundColor: foregroundColor,
      borderColor: borderColor,
    ),
  );
  // return AppCustomOutlinedButton(
  //   label: isTablet ? "" : "28 Jun 25 - 10 Jul 25",
  //   icon: Icons.calendar_today,
  //   padding: isTablet ? EdgeInsets.zero : null,
  //   onPressed: onDateRangePressed,
  //   foregroundColor: Colors.black54,
  // );
}

/// Clock dropdown button.
Widget buildClockButton(Function()? onClockPressed, AppTheme theme) {
  return SizedBox(
    height: 36,
    child: AppCustomOutlinedButton(
      icon: Icons.access_time,
      labelIcon: Icons.keyboard_arrow_down,
      label: '',
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: onClockPressed,
      foregroundColor: Colors.white,
      borderColor: Colors.white38,
    ),
  );
}

/// Wi-Fi/Live button, changes style for tablet or wider screens.
Widget buildLiveWidget(
  bool isTablet,
  Function()? onLivePressed,
  AppTheme theme,
  WidgetRef ref,
) {
  if (isTablet) {
    return SizedBox(
      height: 36,
      child: AppCustomOutlinedButton(
        label: '',
        icon: Icons.wifi_tethering,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        onPressed: onLivePressed,
        backgroundColor: Colors.white,
        foregroundColor: theme.colors.secondaryColor,
        borderColor: Colors.white38,
      ),
    );
  }
  return SizedBox(
    height: 36,
    child: AppElevatedIconButton(
      onPressed: onLivePressed,
      label: 'live'.tr(ref).toAllCapitalize(),
      icon: Icons.wifi_tethering,
      backgroundColor: Colors.white,
      foregroundColor: theme.colors.secondaryColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      radius: 20,
    ),
  );
}
