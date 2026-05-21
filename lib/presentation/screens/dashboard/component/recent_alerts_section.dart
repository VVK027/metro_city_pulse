import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/alert_list_item.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/provider/dashboard_stats_provider.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/components/card_top_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentAlertsSection extends ConsumerWidget {
  final AppTheme theme;
  final bool fillAvailableHeight;

  const RecentAlertsSection({
    super.key,
    required this.theme,
    this.fillAvailableHeight = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(recentMapAlertsProvider);
    final alertsHeight = MediaQuery.sizeOf(context).height * 0.42;

    final alertsList = alerts.isEmpty
        ? Center(
            child: Text(
              'select_alert_to_view_details'.tr(ref),
              style: TextStyle(color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: alerts.length,
            itemBuilder: (context, index) {
              return AlertListItem(
                alert: alerts[index],
                theme: theme,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
                color: Colors.grey.shade400,
              );
            },
          );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: defaultCardElevation,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              ref.read(menuProvider.notifier).state = MenuItemType.alerts;
              ref.read(bottomNavIndexProvider.notifier).state = 1;
            },
            child: CardTopContainerWidget(
              title: 'recentAlerts'.tr(ref).toAllCapitalize(),
              isViewAll: true,
              color: theme.colors.primaryColor,
              iconData: Icons.refresh,
            ),
          ),
          if (fillAvailableHeight)
            Expanded(child: alertsList)
          else
            SizedBox(
              height: alertsHeight.clamp(280, 520),
              child: alertsList,
            ),
        ],
      ),
    );
  }
}
