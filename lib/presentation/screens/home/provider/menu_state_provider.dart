import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum MenuItemType { dashboard, stats, alerts, profile, logout, chat, settings}

final menuProvider = StateProvider<MenuItemType>((ref) => MenuItemType.dashboard);

// The provider that holds the currently selected index
final bottomNavIndexProvider = StateProvider<int?>((ref) => 0);

final StateProvider<TabBarType> tabBarProvider = StateProvider<TabBarType>((ref) => TabBarType.newTab);
