import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/dashboard_app_bar.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/map_section.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/recent_alerts_section.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/summary_card.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/provider/dashboard_stats_provider.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeStateProvider);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final isMobileSmallerTablet =
        isMobile || Responsive.isSmallerTablet(context);

    final stats = ref.watch(dashboardStatsProvider);
    final remoteMarkersResult = ref.watch(remoteMarkersProvider);
    final casesCounts = remoteMarkersResult.value?.casesCounts ?? const {};
    final tabBarProviderNotifier = ref.read(tabBarProvider.notifier);
    final selectedTabItem = ref.watch(tabBarProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: !isMobile
          ? DashboardAppBar(
              title: 'stats'.tr(ref),
              theme: theme,
              userName: 'Viivek Kumar',
              onFilterSelect: () {},
              onLivePressed: _resetFilters,
              onClockPressed: () {},
              onDateRangePressed: () {},
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            if (isMobileSmallerTablet)
              _buildTopBar(
                ref,
                tabBarProviderNotifier,
                selectedTabItem,
                theme,
                casesCounts,
                isMobileSmallerTablet,
                isTablet,
              ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: isMobile
                    ? _buildMobileContent(stats, theme, ref)
                    : _buildDesktopContent(stats, theme, isTablet, ref),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _resetFilters() {
    resetDashboardToLive(ref);
  }

  Widget _buildTopBar(
    WidgetRef ref,
    StateController<TabBarType> tabBarProviderNotifier,
    TabBarType selectedTabItem,
    dynamic theme,
    Map<String, int> casesCounts,
    bool isMobileSmallerTablet,
    bool isTablet,
  ) {
    return Container(
      width: double.infinity,
      color: theme.colors.surface,
      child: Row(
        children: [
          Flexible(
            child: buildTabBar(
              ref,
              tabBarProviderNotifier,
              selectedTabItem,
              isMobileSmallerTablet,
              isTablet,
              theme,
              casesCounts,
            ),
          ),
          const SizedBox(width: 8),
          buildDateRangeButton(isTablet, () {}),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(
    List<StatTileData> stats,
    AppTheme theme,
    WidgetRef ref, {
    required int crossAxisCount,
  }) {
    const tileHeight = 132.0;
    const spacing = 10.0;

    if (crossAxisCount == 4) {
      return SizedBox(
        height: tileHeight,
        child: Row(
          children: [
            for (var i = 0; i < stats.length; i++) ...[
              if (i > 0) const SizedBox(width: spacing),
              Expanded(
                child: SummaryCard(
                  theme: theme,
                  title: stats[i].labelKey.tr(ref).toAllCapitalize(),
                  value: stats[i].value,
                  icon: stats[i].icon,
                  backgroundColor: stats[i].backgroundColor,
                  changePercent: stats[i].changePercent,
                  comparisonLabel: 'vs_last_month'.tr(ref),
                ),
              ),
            ],
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var row = 0; row < stats.length; row += crossAxisCount) ...[
          if (row > 0) const SizedBox(height: spacing),
          SizedBox(
            height: tileHeight,
            child: Row(
              children: [
                for (var col = 0; col < crossAxisCount; col++) ...[
                  if (col > 0) const SizedBox(width: spacing),
                  Expanded(
                    child: row + col < stats.length
                        ? SummaryCard(
                            theme: theme,
                            title: stats[row + col]
                                .labelKey
                                .tr(ref)
                                .toAllCapitalize(),
                            value: stats[row + col].value,
                            icon: stats[row + col].icon,
                            backgroundColor: stats[row + col].backgroundColor,
                            changePercent: stats[row + col].changePercent,
                            comparisonLabel: 'vs_last_month'.tr(ref),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMobileContent(
    List<StatTileData> stats,
    dynamic theme,
    WidgetRef ref,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildStatsGrid(
            stats,
            theme,
            ref,
            crossAxisCount: 2,
          ),
          const SizedBox(height: 24),
          const MapSection(),
          const SizedBox(height: 16),
          RecentAlertsSection(theme: theme),
        ],
      ),
    );
  }

  Widget _buildDesktopContent(
    List<StatTileData> stats,
    dynamic theme,
    bool isTablet,
    WidgetRef ref,
  ) {
    return Column(
      children: [
        _buildStatsGrid(
          stats,
          theme,
          ref,
          crossAxisCount: 4,
        ),
        const SizedBox(height: 24),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Expanded(child: MapSection(fillAvailableHeight: true)),
              const SizedBox(width: 16),
              Expanded(child: RecentAlertsSection(theme: theme, fillAvailableHeight: true)),
            ],
          ),
        ),
      ],
    );
  }
}
