import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_image_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:flutter/material.dart';

class MapTabBarWidget extends StatelessWidget {
  final Function(FilterType) onPressed;
  final Function(FilterType) onFilterSelected;
  final FilterType selectedFilter;
  final AppTheme theme;

  const MapTabBarWidget({
    super.key,
    required this.theme,
    required this.onPressed,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: kToolbarHeight,
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: theme.colors.black.withValues(alpha: 0.12),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: FilterType.values.length,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            itemBuilder: (context, index) {
              FilterType f = FilterType.values[index];
              final selected = f == selectedFilter;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: GestureDetector(
                  onTap: () => onPressed(f),
                  //borderRadius: BorderRadius.circular(8),
                  behavior: HitTestBehavior.opaque,

                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: selected
                        ? BoxDecoration(
                            color: theme.colors.primaryColor,
                            borderRadius: BorderRadius.circular(12),
                          )
                        : BoxDecoration(),
                    // decoration: BoxDecoration(
                    //   color: selected ? Color(0xFF0A3ABB) : Colors.white,
                    //   borderRadius: BorderRadius.circular(8),
                    // border: Border.all(
                    //   color: selected
                    //       ? Colors.blue
                    //       : Colors.grey.shade300,
                    // ),
                    // ),
                    child: Center(
                      child: AppText(
                        _labelFor(f),
                        textAlign: TextAlign.center,
                        color: selected ? Colors.white : theme.colors.text,
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: (selectedFilter == FilterType.all)
                ? theme.colors.unSelectedColor
                : theme.colors.primaryColor,
            child: IconButton(
              icon: AppImage(
                theme.assets.filterIcon,
                width: 25,
                height: 25,
                color: Colors.white,
              ),
              onPressed: (selectedFilter == FilterType.all)
                  ? null
                  : () => onFilterSelected(selectedFilter),
            ),
          ),
        ),
      ],
    );
  }

  String _labelFor(FilterType f) {
    switch (f) {
      case FilterType.all:
        return 'All';
      case FilterType.traffic:
        return 'Traffic';
      case FilterType.publicWorks:
        return 'Public Works';
      case FilterType.airport:
        return 'Airport';
      case FilterType.park:
        return 'Park';
    }
  }
}
