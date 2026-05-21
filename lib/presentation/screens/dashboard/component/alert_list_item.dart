import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/presentation/utils/date_time_util.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlertListItem extends ConsumerWidget {
  final MapDataEntity alert;
  final AppTheme theme;

  const AlertListItem({super.key, required this.alert, required this.theme});

  String _cameraLabel() {
    if (alert.cameraName?.trim().isNotEmpty == true) {
      return alert.cameraName!.trim();
    }
    if (alert.vehicleNo?.trim().isNotEmpty == true) {
      return alert.vehicleNo!.trim();
    }
    return alert.id ?? '--';
  }

  String _locationLabel() {
    if (alert.locationName?.trim().isNotEmpty == true) {
      return alert.locationName!.trim();
    }
    if (alert.locationAddress?.trim().isNotEmpty == true) {
      return alert.locationAddress!.trim();
    }
    return '--';
  }

  String _caseLabel() {
    if (alert.status?.trim().isNotEmpty == true) {
      return alert.status!.trim().toAllCapitalize();
    }
    return alert.confidenceScore?.toString() ?? '--';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = alert.type?.trim().isNotEmpty == true
        ? alert.type!.trim()
        : 'Alert';
    final imageUrl = alert.imageUrl?.trim();
    final formattedDate = DateTimeUtil.getFormattedDateTime(
      alert.isoTimestamp,
      format: 'MMM dd yyyy h:mm:ss a',
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imageUrl != null && imageUrl.isNotEmpty
                ? Image.network(
                    imageUrl,
                    width: 120,
                    height: 90,
                    fit: BoxFit.cover,
                    errorBuilder: (_, error, stackTrace) => _placeholderImage(),
                  )
                : _placeholderImage(),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                        text: _cameraLabel(),
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
                  '${'location'.tr(ref).toAllCapitalize()}: ${_locationLabel()}',
                  style: TextStyle(color: theme.colors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  '${'cases'.tr(ref).toAllCapitalize()}: ${_caseLabel()}',
                  style: TextStyle(color: theme.colors.text),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                formattedDate,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 12),
              Text(
                '${'id_required'.tr(ref).replaceAll('*', '').trim().toUpperCase()} : ${alert.id ?? '--'}',
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

  Widget _placeholderImage() {
    return Container(
      width: 120,
      height: 90,
      color: Colors.grey.shade200,
      child: Icon(Icons.image_not_supported, color: Colors.grey.shade500),
    );
  }
}
