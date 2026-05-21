//import 'package:google_maps_cluster_manager_2/google_maps_cluster_manager_2.dart' show ClusterItem;
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Filter enum
enum FilterType { all, traffic, publicWorks, airport, park }

String filterTypeToKey(FilterType t) => t.toString().split('.').last;

enum TabBarType {
  newTab(title: "New"),
  dispatch(title: "Dispatch"),
  cases(title: "Cases");

  final String title;

  const TabBarType({required this.title});
}

class MapMarkerData {
  final String id;
  final String title;
  final LatLng position;
  final BitmapDescriptor icon;
  final FilterType filterType;
  final TabBarType tabType;
  final String severity;

  const MapMarkerData({
    required this.id,
    required this.title,
    required this.position,
    required this.icon,
    required this.filterType,
    required this.tabType,
    required this.severity,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'position': {'lat': position.latitude, 'lng': position.longitude},
    'filterType': filterType.toString(),
    'tabType': tabType.toString(),
    'severity': severity,
  };

  static MapMarkerData fromJson(Map<String, dynamic> json) => MapMarkerData(
    id: json['id'],
    title: json['title'],
    position: LatLng(json['position']['lat'], json['position']['lng']),
    icon: BitmapDescriptor.defaultMarker, // Replace with actual icon logic
    filterType: FilterType.values.firstWhere((e) => e.toString() == json['filterType']),
    tabType: TabBarType.values.firstWhere((e) => e.toString() == json['tabType']),
    severity: json['severity'],
  );
}


// class MapMarkerData with ClusterItem {
//   final String id;
//   final LatLng position;
//   final String title;
//   final String severity; // 1–10 scale
//   final BitmapDescriptor icon;
//   final FilterType filterType;
//   final TabBarType tabType;
//
//   MapMarkerData({
//     required this.id,
//     required this.position,
//     required this.title,
//     required this.severity,
//     required this.icon,
//     required this.filterType,
//     required this.tabType,
//   });
//
//   @override
//   LatLng get location => position;
// }

