import 'package:metro_city_pulse/core/constants/app_constants.dart';
import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/data/models/alert_model.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/alert_list_item.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/components/card_top_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentAlertsSection extends ConsumerWidget {
  final AppTheme theme;

  const RecentAlertsSection({super.key, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: defaultCardElevation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Top Bar
          CardTopContainerWidget(
            title: 'recentAlerts'.tr(ref).toAllCapitalize(),
            isViewAll: true,
            color: theme.colors.primaryColor,
            iconData: Icons.refresh,
          ),
          ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: recentAlerts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return AlertListItem(
                alert: AlertDataModel.fromJson(recentAlerts[index]),
                theme: theme,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 0.5,
                height: 0.5,
                color: Colors.grey[400],
              );
            },
          ),
        ],
      ),
    );
  }
}
