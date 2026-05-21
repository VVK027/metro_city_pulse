import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_card.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_empty_state.dart';
import 'package:metro_city_pulse/presentation/widgets/components/card_top_container_widget.dart';

class MapSection extends ConsumerWidget {
  final bool fillAvailableHeight;

  const MapSection({super.key, this.fillAvailableHeight = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Subscribe ONLY to the primary color used in the header so unrelated
    // theme changes (e.g. mode toggles touching gradients) don't force a
    // rebuild of this section.
    final Color primaryColor = ref.watch(
      appThemeStateProvider.select((t) => t.colors.primaryColor),
    );

    final Widget placeholder = AppEmptyState(
      icon: Icons.map_outlined,
      message: 'mapFeatureComingSoon'.tr(ref),
      iconSize: 64,
      textSize: 20,
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CardTopContainerWidget(
            title: 'map_overview'.tr(ref).toAllCapitalize(),
            isViewAll: false,
            color: primaryColor,
            iconData: Icons.location_on_outlined,
          ),
          if (fillAvailableHeight)
            Expanded(child: Center(child: placeholder))
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
