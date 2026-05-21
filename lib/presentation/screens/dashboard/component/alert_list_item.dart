import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/data/models/alert_model.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlertListItem extends ConsumerWidget {
  final AlertDataModel alert;
  final AppTheme theme;

  const AlertListItem({super.key, required this.alert, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              alert.imageUrl,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  alert.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.colors.text,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    text: '${'camera'.tr(ref).toAllCapitalize()} : ',
                    style: TextStyle(color: theme.colors.text),
                    children: [
                      TextSpan(
                        text: alert.camera,
                        style: TextStyle(
                          color: theme.colors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'location'.tr(ref).toAllCapitalize()}: ${alert.location}',
                  style: TextStyle(color: theme.colors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'cases'.tr(ref).toAllCapitalize()}: ${alert.caseName}',
                  style: TextStyle(color: theme.colors.text),
                ),
              ],
            ),
          ),

          // Date & ID
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Nov 02 2023', style: TextStyle(color: Colors.grey)),
              Text('6:29:37 PM', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 12),
              Text(
                '${'id_required'.tr(ref).replaceAll('*', '').trim().toUpperCase()} : ${alert.id}',
                style: TextStyle(
                  color: theme.colors.text,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
