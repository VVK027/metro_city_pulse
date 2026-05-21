import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/screens/alerts/page/alerts_screen.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/dashboard_app_bar.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/page/dashboard_screen.dart';
import 'package:metro_city_pulse/presentation/screens/home/component/bottom_navigation_widget.dart';
import 'package:metro_city_pulse/presentation/screens/home/component/side_menu.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/screens/maps/page/custom_map_screen.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';
import 'package:metro_city_pulse/presentation/screens/profile/page/profile_screen.dart';
import 'package:metro_city_pulse/presentation/screens/settings/page/settings_screen.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/utils/map_utils.dart';
import 'package:metro_city_pulse/presentation/utils/navigation_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final themeNotifier = ref.read(appThemeStateProvider.notifier);
    final isMobile = Responsive.isMobile(context);

    final currentIndex = ref.watch(bottomNavIndexProvider);
    final bottomNavProvider = ref.read(bottomNavIndexProvider.notifier);

    final selectedMenuItem = ref.watch(menuProvider);
    final menuNotifier = ref.read(menuProvider.notifier);

    syncMarkerIconSize(context, ref);

    return Scaffold(
      drawer: isMobile
          ? _buildDrawer(context, ref, theme, selectedMenuItem)
          : null,
      bottomNavigationBar: isMobile
          ? _buildBottomNav(
              theme,
              currentIndex ?? 0,
              menuNotifier,
              bottomNavProvider,
            )
          : null,
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) => Column(
            children: [
              if (isMobile)
                _buildAppBar(scaffoldContext, theme, themeNotifier, ref),
              Expanded(
                child: Row(
                  children: [
                    if (!isMobile)
                      SideMenu(
                        ref: ref,
                        theme: theme,
                        selectedItem: selectedMenuItem,
                        onMenuSelected: (menuType) =>
                            _onMenuSelectedWithNavUpdate(
                              context,
                              ref,
                              menuType,
                            ),
                        onTimeSelected: (int interval) {
                          ref
                              .read(remoteMarkersProvider.notifier)
                              .setPollingInterval(interval);
                        },
                      ),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _buildScreenContent(selectedMenuItem),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------
  // Drawer
  // ------------------------------
  Widget _buildDrawer(
    BuildContext context,
    WidgetRef ref,
    AppTheme theme,
    MenuItemType selectedMenu,
  ) {
    return SafeArea(
      child: Drawer(
        child: SideMenu(
          ref: ref,
          theme: theme,
          selectedItem: selectedMenu,
          onMenuSelected: (menuType) =>
              _onMenuSelectedWithNavUpdate(context, ref, menuType),
        ),
      ),
    );
  }

  // ------------------------------
  // Bottom Navigation
  // ------------------------------
  Widget _buildBottomNav(
    AppTheme theme,
    int currentIndex,
    StateController<MenuItemType> menuNotifier,
    StateController<int?> bottomNavNotifier,
  ) {
    return BottomNavigationWidget(
      theme: theme,
      currentIndex: currentIndex,
      onTap: (index) {
        bottomNavNotifier.state = index;
        _updateMenuViaIndex(index, menuNotifier);
      },
    );
  }

  // ------------------------------
  // App Bar (Only for Mobile)
  // ------------------------------
  Widget _buildAppBar(
    BuildContext context,
    AppTheme theme,
    AppThemeState themeNotifier,
    WidgetRef ref,
  ) {
    final selectedMenu = ref.watch(menuProvider);
    final showMapControls = selectedMenu == MenuItemType.dashboard;

    return DashboardAppBar(
      title: _appBarTitleForMenu(ref, selectedMenu),
      theme: theme,
      onMenuPressed: () => Scaffold.of(context).openDrawer(),
      userName: 'Viivek Kumar',
      onLogoutPressed: () {
        _logoutFunction(context, ref);
      },
      onFilterSelect: showMapControls ? () {} : null,
      onLivePressed: showMapControls
          ? () => resetDashboardToLive(ref)
          : () {
              ref.read(remoteMarkersProvider.notifier).refresh();
            },
      onClockPressed: () {},
      onDateRangePressed: () {},
    );
  }

  // ------------------------------
  // Screen Content by Menu
  // ------------------------------
  Widget _buildScreenContent(MenuItemType selectedMenu) {
    switch (selectedMenu) {
      case MenuItemType.dashboard:
        return const CustomMapScreen();
      case MenuItemType.stats:
        return const DashboardScreen();
      case MenuItemType.alerts:
        return const AlertsScreen();
      case MenuItemType.profile:
        return const ProfileScreen();
      case MenuItemType.settings:
        return const SettingsScreen();
      default:
        return const CustomMapScreen();
    }
  }

  // ------------------------------
  // Menu Logic
  // ------------------------------
  void _updateMenuViaIndex(int index, final menuNotifier) {
    final menuMapping = {
      0: MenuItemType.dashboard,
      1: MenuItemType.stats,
      2: MenuItemType.alerts,
      3: MenuItemType.chat,
    };
    menuNotifier.state = menuMapping[index] ?? MenuItemType.dashboard;
  }

  void _onMenuSelectedWithNavUpdate(
    BuildContext context,
    WidgetRef ref,
    MenuItemType menuType,
  ) {
    final menuNotifier = ref.read(menuProvider.notifier);
    final bottomNavProvider = ref.read(bottomNavIndexProvider.notifier);

    switch (menuType) {
      case MenuItemType.dashboard:
        menuNotifier.state = MenuItemType.dashboard;
        bottomNavProvider.state = 0;
        break;
      case MenuItemType.stats:
        menuNotifier.state = MenuItemType.stats;
        bottomNavProvider.state = 1;
        break;
      case MenuItemType.alerts:
        menuNotifier.state = MenuItemType.alerts;
        bottomNavProvider.state = 2;
        break;
      case MenuItemType.chat:
        menuNotifier.state = MenuItemType.chat;
        bottomNavProvider.state = 3;
        break;
      case MenuItemType.profile:
        _navFunction(context, ref, '/profile');
        break;
      case MenuItemType.settings:
        _navFunction(context, ref, '/settings');
        break;
      case MenuItemType.logout:
        _logoutFunction(context, ref);
        break;
    }
  }

  void _navFunction(BuildContext context, WidgetRef ref, String route) {
    NavigationUtil.push(context, route);
  }

  String _appBarTitleForMenu(WidgetRef ref, MenuItemType menu) {
    switch (menu) {
      case MenuItemType.stats:
        return 'stats'.tr(ref);
      case MenuItemType.alerts:
        return 'alerts'.tr(ref);
      case MenuItemType.chat:
        return 'chat_ai'.tr(ref);
      default:
        return 'dashboard'.tr(ref);
    }
  }

  // ------------------------------
  // Logout function
  // ------------------------------
  void _logoutFunction(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: AppText("logging_out".tr(ref).toAllCapitalize())),
    );
    NavigationUtil.clearDataAndMoveToLogin(context, ref, 'side_menu');
  }
}

void syncMarkerIconSize(BuildContext context, WidgetRef ref) {
  final markerSize = MapUtils.markerSizeForScreenWidth(
    MediaQuery.sizeOf(context).width,
  );
  if (ref.read(markerIconSizeProvider) != markerSize) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(markerIconSizeProvider.notifier).state = markerSize;
    });
  }
}
