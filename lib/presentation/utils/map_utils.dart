import 'package:metro_city_pulse/core/themes/app_assets.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

const double markerWidth = 40;
const double markerHeight = 40;
const double infoWindowWidth = 180;

class MapUtils {
  static List<Map<String, Object>> getSeveritiesList(
    Map<String, int> casesCounts,
  ) {
    return [
      {"label": "S1", "count": casesCounts['S1'] ?? 0, "color": Colors.red},
      {"label": "S2", "count": casesCounts['S2'] ?? 0, "color": Colors.orange},
      {"label": "S3", "count": casesCounts['S3'] ?? 0, "color": Colors.yellow},
      {"label": "S4", "count": casesCounts['S4'] ?? 0, "color": Colors.green},
      {"label": "S5", "count": casesCounts['S5'] ?? 0, "color": Colors.cyan},
    ];
  }

  static String getSeverityByIndex(int index) {
    if (index == -1) return '';
    return 'S${index + 1}'.toUpperCase();
  }

  // static String getSeverityByIndex(int selectedSeverityIndex) {
  //   switch (selectedSeverityIndex) {
  //     case -1: return '';
  //     case 0: return 'S1';
  //     case 1: return 'S2';
  //     case 2: return 'S3';
  //     case 3: return 'S4';
  //     case 4: return 'S5';
  //     default: return '';
  //   }
  // }

  static FilterType getFilterType(MapDataEntity entity) {
    final String? type = entity.location?.locationType?.trim().toLowerCase();
    switch (type) {
      case 'traffic':
        return FilterType.traffic;
      case 'public works':
      case 'public_works':
      case 'public-works':
        return FilterType.publicWorks;
      case 'airport':
        return FilterType.airport;
      case 'park':
        return FilterType.park;
      default:
        return FilterType.all;
    }
  }

  static TabBarType getCaseType(String caseStatus) {
    switch (caseStatus) {
      case 'new':
        return TabBarType.newTab;
      case 'dispatch':
        return TabBarType.dispatch;
      case 'cases':
        return TabBarType.cases;
      default:
        return TabBarType.newTab;
    }
  }

  static Future<Map<FilterType, BitmapDescriptor>> loadIcons(
    AppAssets assets,
  ) async {
    return {
      FilterType.traffic: await BitmapDescriptor.asset(
        ImageConfiguration(size: const Size(markerWidth, markerHeight)),
        assets.vehicleIcon,
      ),
      FilterType.publicWorks: await BitmapDescriptor.asset(
        ImageConfiguration(size: const Size(markerWidth, markerHeight)),
        assets.publicGroupIcon,
      ),
      FilterType.airport: await BitmapDescriptor.asset(
        ImageConfiguration(size: const Size(markerWidth, markerHeight)),
        assets.theftIcon,
      ),
      FilterType.park: await BitmapDescriptor.asset(
        ImageConfiguration(size: const Size(markerWidth, markerHeight)),
        assets.publicGroupIcon,
      ),
    };
  }

  static const initialCameraPosition = CameraPosition(
    target: LatLng(12.9716, 77.5946), // Bengaluru
    zoom: 12,
  );

  static Future<void> zoomIn(GoogleMapController? controller) async {
    if (controller != null) controller.animateCamera(CameraUpdate.zoomIn());
  }

  static Future<void> zoomOut(GoogleMapController? controller) async {
    if (controller != null) controller.animateCamera(CameraUpdate.zoomOut());
  }

  static Offset? getOffsetForLatLng(
    GoogleMapController? controller,
    LatLngBounds? mapBounds,
    Size? mapSize,
    LatLng? markerLatLng,
  ) {
    if (markerLatLng == null ||
        controller == null ||
        mapBounds == null ||
        mapSize == null) {
      return null;
    }
    LatLng sw = mapBounds.southwest;
    LatLng ne = mapBounds.northeast;
    double dx =
        ((markerLatLng.longitude - sw.longitude) /
            (ne.longitude - sw.longitude)) *
        mapSize.width;
    double dy =
        ((ne.latitude - markerLatLng.latitude) / (ne.latitude - sw.latitude)) *
        mapSize.height;
    bool showLeft = dx + infoWindowWidth > mapSize.width;
    double offsetX = showLeft
        ? dx - infoWindowWidth + markerWidth / 2.1
        : dx + markerWidth / 2.1;
    double offsetY = dy - markerHeight * 2;
    return Offset(offsetX, offsetY);
  }

  static Future<void> goToCurrentLocation(
    GoogleMapController? controller,
  ) async {
    if (controller != null) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(initialCameraPosition),
      );
    }
    // Position position = await Geolocator.getCurrentPosition(
    //     desiredAccuracy: LocationAccuracy.high);
    // final controller = await _controller.future;
    // controller.animateCamera(
    //   CameraUpdate.(
    //     CameraPosition(
    //       target: LatLng(position.latitude, position.longitude),
    //       zoom: 16,
    //     ),
    //   ),
    // );
  }
}
