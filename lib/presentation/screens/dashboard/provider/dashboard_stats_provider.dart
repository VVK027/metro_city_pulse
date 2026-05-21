import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';

class StatTileData {
  final String labelKey;
  final String value;
  final String icon;
  final Color backgroundColor;
  final double? changePercent;

  const StatTileData({
    required this.labelKey,
    required this.value,
    required this.icon,
    required this.backgroundColor,
    this.changePercent,
  });
}

final dashboardStatsProvider = Provider<List<StatTileData>>((ref) {
  final theme = ref.watch(appThemeStateProvider);
  final result = ref.watch(remoteMarkersProvider).value;
  final mapDataList = result?.mapDataList ?? const [];
  final casesCounts = result?.casesCounts ?? const {};

  final totalVideos = mapDataList
      .where((item) => item.cameraUrl != null && item.cameraUrl!.trim().isNotEmpty)
      .length;

  return buildStatsList(
    theme: theme,
    mapDataList: mapDataList,
    totalCases: mapDataList.length,
    newAlerts: casesCounts['new'] ?? 0,
    openCases: casesCounts['dispatch'] ?? 0,
    totalVideos: totalVideos,
  );
});

List<StatTileData> buildStatsList({
  required AppTheme theme,
  required List<MapDataEntity> mapDataList,
  required int totalCases,
  required int newAlerts,
  required int openCases,
  required int totalVideos,
}) {
  final now = DateTime.now();
  final thisMonth = (now.year, now.month);
  final lastMonthDate = DateTime(now.year, now.month - 1);
  final lastMonth = (lastMonthDate.year, lastMonthDate.month);

  return [
    StatTileData(
      labelKey: 'total_cases',
      value: '$totalCases',
      icon: theme.assets.totalVideoIcon,
      backgroundColor: const Color(0xFF9747FF),
      changePercent: _monthOverMonthChange(
        mapDataList,
        thisMonth,
        lastMonth,
        (_) => true,
      ),
    ),
    StatTileData(
      labelKey: 'newAlerts',
      value: '$newAlerts',
      icon: theme.assets.submittedIcon,
      backgroundColor: const Color(0xFF198754),
      changePercent: _monthOverMonthChange(
        mapDataList,
        thisMonth,
        lastMonth,
        (item) => item.status?.trim().toLowerCase() == 'new',
      ),
    ),
    StatTileData(
      labelKey: 'openCases',
      value: '$openCases',
      icon: theme.assets.processedIcon,
      backgroundColor: const Color(0xFF2A66F4),
      changePercent: _monthOverMonthChange(
        mapDataList,
        thisMonth,
        lastMonth,
        (item) => item.status?.trim().toLowerCase() == 'dispatch',
      ),
    ),
    StatTileData(
      labelKey: 'totalVideos',
      value: '$totalVideos',
      icon: theme.assets.progressIcon,
      backgroundColor: const Color(0xFFF89F1D),
      changePercent: _monthOverMonthChange(
        mapDataList,
        thisMonth,
        lastMonth,
        (item) =>
            item.cameraUrl != null && item.cameraUrl!.trim().isNotEmpty,
      ),
    ),
  ];
}

double? _monthOverMonthChange(
  List<MapDataEntity> mapDataList,
  (int, int) thisMonth,
  (int, int) lastMonth,
  bool Function(MapDataEntity item) predicate,
) {
  final currentCount = _countInMonth(mapDataList, thisMonth, predicate);
  final previousCount = _countInMonth(mapDataList, lastMonth, predicate);

  if (previousCount == 0) {
    if (currentCount == 0) return 0;
    return 100;
  }

  return ((currentCount - previousCount) / previousCount) * 100;
}

int _countInMonth(
  List<MapDataEntity> mapDataList,
  (int, int) month,
  bool Function(MapDataEntity item) predicate,
) {
  return mapDataList.where((item) {
    final reportedAt = _parseReportedTime(item.isoTimestamp);
    if (reportedAt.year != month.$1 || reportedAt.month != month.$2) {
      return false;
    }
    return predicate(item);
  }).length;
}

final recentMapAlertsProvider = Provider<List<MapDataEntity>>((ref) {
  final mapDataList =
      ref.watch(remoteMarkersProvider).value?.mapDataList ?? const [];
  final sorted = List<MapDataEntity>.from(mapDataList)
    ..sort(
      (a, b) => _parseReportedTime(
        b.isoTimestamp,
      ).compareTo(_parseReportedTime(a.isoTimestamp)),
    );
  return sorted;
});

DateTime _parseReportedTime(String? value) {
  if (value == null || value.trim().isEmpty) {
    return DateTime.fromMillisecondsSinceEpoch(0);
  }
  return DateTime.tryParse(value.trim()) ?? DateTime.fromMillisecondsSinceEpoch(0);
}
