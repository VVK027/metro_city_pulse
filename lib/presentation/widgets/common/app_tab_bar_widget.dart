import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/presentation/widgets/buttons/app_tab_text_button.dart';
import 'package:flutter/material.dart';

class AppTabBarWidget extends StatelessWidget {
  final bool isWide;
  final Function(int) onTabPressed;
  final List<Map<String, dynamic>> listTabs;
  final AppTheme theme;

  const AppTabBarWidget({
    super.key,
    required this.isWide,
    required this.onTabPressed,
    required this.listTabs,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: kToolbarHeight - 10,
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: isWide
            ? [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.12),
                  blurRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisAlignment: isWide
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        mainAxisSize: isWide ? MainAxisSize.min : MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: isWide ? 8 : 4),
          AppTabTextButton(
            isActive: listTabs[0]['isActive'],
            title: listTabs[0]['label'],
            value: listTabs[0]['value'].toString(),
            isCompact: !isWide,
            onPressed: () => onTabPressed(0),
          ),
          SizedBox(width: isWide ? 8 : 4),
          AppTabTextButton(
            isActive: listTabs[1]['isActive'],
            title: listTabs[1]['label'],
            value: listTabs[1]['value'].toString(),
            isCompact: !isWide,
            onPressed: () => onTabPressed(1),
          ),
          SizedBox(width: isWide ? 8 : 4),
          AppTabTextButton(
            isActive: listTabs[2]['isActive'],
            title: listTabs[2]['label'],
            value: listTabs[2]['value'].toString(),
            isCompact: !isWide,
            onPressed: () => onTabPressed(2),
          ),
        ],
      ),
      // child: isNotWide ? Row(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: [
      //     AppTabTextButton(
      //       isActive: listTabs[0]['isActive'],
      //       title: listTabs[0]['label'],
      //       value: listTabs[0]['value'].toString(),
      //       onPressed: () => onTabPressed(0),
      //     ),
      //     AppTabTextButton(
      //       isActive: listTabs[1]['isActive'],
      //       title: listTabs[1]['label'],
      //       value: listTabs[1]['value'].toString(),
      //       onPressed: () => onTabPressed(1),
      //     ),
      //     AppTabTextButton(
      //       isActive: listTabs[2]['isActive'],
      //       title: listTabs[2]['label'],
      //       value: listTabs[2]['value'].toString(),
      //       onPressed: () => onTabPressed(2),
      //     ),
      //   ],
      // ) : ListView.builder(
      //   scrollDirection: Axis.horizontal,
      //   itemCount: listTabs.length,
      //   shrinkWrap: true,
      //   physics: const NeverScrollableScrollPhysics(),
      //   itemBuilder: (context, index) {
      //     String title = listTabs[index]['label'];
      //     String value = listTabs[index]['value'].toString();
      //     bool isActive = listTabs[index]['isActive'];
      //     return Row(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         AppTabTextButton(
      //           isActive: isActive,
      //           title: title,
      //           value: value,
      //           onPressed: () => onTabPressed(index),
      //         ),
      //         SizedBox(width: isNotWide ? 2 : 8),
      //       ],
      //     );
      //   },
      // ),
    );
  }
}
