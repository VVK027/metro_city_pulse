import 'package:metro_city_pulse/core/constants/app_constants.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/dashboard_app_bar.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/map_section.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/recent_alerts_section.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/summary_card.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    final stats = statsList(theme);

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: !isMobile
          ? DashboardAppBar(
              title: 'dashboard'.tr(ref),
              theme: theme,
              userName: 'Viivek Kumar',
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14.0),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: stats.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 2 : 4,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: isMobile
                      ? 1.35
                      : isTablet
                      ? 1.6
                      : 2.1,
                ),
                itemBuilder: (context, index) {
                  final item = stats[index];
                  return SummaryCard(
                    title: item['label'],
                    value: item['value'],
                    icon: item['icon'],
                    color: item['color'],
                  );
                },
              ),
              const SizedBox(height: 24),
              isMobile
                  ? Column(
                      children: [
                        const MapSection(),
                        const SizedBox(height: 16),
                        RecentAlertsSection(theme: theme),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(child: MapSection()),
                        const SizedBox(width: 16),
                        Expanded(child: RecentAlertsSection(theme: theme)),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
