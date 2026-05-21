import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';

/// Alert model
// class Alert {
//   final String title;
//   final String camera;
//   final String location;
//   final DateTime timestamp;
//   final TabBarType tabType;
//   final int confidenceScore;
//
//   Alert(
//     this.title,
//     this.camera,
//     this.location,
//     this.timestamp,
//     this.tabType,
//     this.confidenceScore,
//   );
// }

/// Providers
final confidenceProvider = StateProvider<double>((ref) => 70);
final selectedAlertProvider = StateProvider<MapDataEntity?>((ref) => null);
final selectedAlertTabProvider = StateProvider<TabBarType>(
  (ref) => TabBarType.newTab,
);

// final alertsProvider = Provider<List<Alert>>((ref) {
//   return [
//     Alert(
//       "Crowd Alert",
//       "CCTV_SENT_Cam03",
//       "Central Bus Terminal",
//       DateTime(2023, 11, 2, 18, 29),
//       TabBarType.newTab,
//       82,
//     ),
//     Alert(
//       "Unauthorized Access",
//       "CCTV_SENT_Cam01",
//       "Command Control Room",
//       DateTime(2023, 11, 2, 18, 15),
//       TabBarType.newTab,
//       65,
//     ),
//     Alert(
//       "Stalled Vehicle",
//       "CCTVGate03_Cam01",
//       "Kempegowda Airport",
//       DateTime(2023, 11, 2, 18, 29),
//       TabBarType.dispatch,
//       74,
//     ),
//     Alert(
//       "Signal Tampering",
//       "CCTV_Metro_Cam09",
//       "MG Road Junction",
//       DateTime(2023, 11, 2, 17, 52),
//       TabBarType.dispatch,
//       56,
//     ),
//     Alert(
//       "Vandalism - Perimeter Breach",
//       "E134",
//       "Case 234",
//       DateTime(2023, 11, 2, 18, 29),
//       TabBarType.cases,
//       91,
//     ),
//     Alert(
//       "Criminal Activity",
//       "E134",
//       "Case 234",
//       DateTime(2023, 11, 2, 18, 29),
//       TabBarType.cases,
//       49,
//     ),
//     Alert(
//       "Suspicious Package",
//       "CCTV_Station_Cam06",
//       "City Bus Stand",
//       DateTime(2023, 11, 2, 17, 39),
//       TabBarType.cases,
//       38,
//     ),
//   ];
// });

// final remoteAlertsProvider = Provider<List<Alert>>((ref) {
//   final remoteResult = ref.watch(remoteMarkersProvider).value;
//   final mapDataList = remoteResult?.mapDataList ?? const [];
//
//   return mapDataList
//       .map(
//         (item) => Alert(
//           item.label?.trim().isNotEmpty == true ? item.label!.trim() : "Alert",
//           item.reportedBy?.trim().isNotEmpty == true
//               ? item.reportedBy!.trim()
//               : (item.vehicleNo?.trim().isNotEmpty == true
//                     ? item.vehicleNo!.trim()
//                     : "--"),
//           item.location?.locationName?.trim().isNotEmpty == true
//               ? item.location!.locationName!.trim()
//               : (item.location?.locationAddress?.trim().isNotEmpty == true
//                     ? item.location!.locationAddress!.trim()
//                     : "--"),
//           _parseReportedTime(item.reportedTime),
//           MapUtils.getCaseType(
//             item.caseStatus?.toString().trim().toLowerCase() ?? "new",
//           ),
//           item.confidenceScore ?? 50,
//         ),
//       )
//       .toList();
// });

// final effectiveAlertsProvider = Provider<List<Alert>>((ref) {
//   final remoteAlerts = ref.watch(remoteAlertsProvider);
//   if (remoteAlerts.isNotEmpty) {
//     return remoteAlerts;
//   }
//   return ref.watch(alertsProvider);
// });

final filteredAlertsProvider = Provider<List<MapDataEntity>>((ref) {
  final remoteResult = ref.watch(remoteMarkersProvider).value;
  final mapDataList = remoteResult?.mapDataList ?? const [];

  final selectedTab = ref.watch(selectedAlertTabProvider);
  final minConfidence = ref.watch(confidenceProvider).toInt();

  return mapDataList
      .where(
        (alert) =>
            (alert.caseStatus?.trim().toLowerCase() ?? "") ==
            selectedTab.title.toLowerCase(),
      )
      .where((alert) => (alert.confidenceScore ?? 0) >= minConfidence)
      .toList();
});
