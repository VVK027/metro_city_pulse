import 'package:metro_city_pulse/core/constants/constants.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/components/card_top_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MapSection extends ConsumerWidget {
  final bool fillAvailableHeight;

  const MapSection({super.key, this.fillAvailableHeight = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final placeholder = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.map_outlined, size: 64, color: Colors.grey),
        const SizedBox(height: 10),
        Text(
          'mapFeatureComingSoon'.tr(ref),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: defaultCardElevation,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTopContainerWidget(
            title: 'map_overview'.tr(ref).toAllCapitalize(),
            isViewAll: false,
            color: theme.colors.primaryColor,
            iconData: Icons.location_on_outlined,
          ),
          if (fillAvailableHeight)
            Expanded(
              child: Center(child: placeholder),
            )
          else
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
              child: placeholder,
            ),
        ],
      ),
    );
  }
}
