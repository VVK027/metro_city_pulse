import 'dart:async';
import 'package:metro_city_pulse/core/provider/repository/repository_provider.dart';
import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/screens/home/provider/menu_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class RemoteMarkersResult {
  final List<MapMarkerData> markers;
  final List<MapDataEntity> mapDataList;
  final Map<String, int> casesCounts;
  final Map<String, int> severityCounts;

  const RemoteMarkersResult({
    required this.markers,
    required this.mapDataList,
    required this.casesCounts,
    required this.severityCounts,
  });
}

// selected severity state provide
final StateProvider<int?> selectedSeverityProvider = StateProvider<int?>(
  (ref) => null,
);

final mapLiveResetTriggerProvider = StateProvider<int>((ref) => 0);

void resetDashboardToLive(WidgetRef ref) {
  ref.read(selectedFilterProvider.notifier).setFilter(FilterType.all);
  ref.read(selectedSeverityProvider.notifier).state = null;
  ref.read(tabBarProvider.notifier).state = TabBarType.newTab;
  ref.read(remoteMarkersProvider.notifier).refresh();
  ref.read(mapLiveResetTriggerProvider.notifier).state++;
}

// Persisted selected filter
final markerIconSizeProvider = StateProvider<double>(
  (ref) => markerWidthMobile,
);

final StateNotifierProvider<SelectedFilterNotifier, FilterType>
selectedFilterProvider =
    StateNotifierProvider<SelectedFilterNotifier, FilterType>((ref) {
      return SelectedFilterNotifier();
    });

class SelectedFilterNotifier extends StateNotifier<FilterType> {
  SelectedFilterNotifier() : super(FilterType.all);

  void setFilter(FilterType f) {
    state = f;
  }
}

// Provider for casesCounts
final casesCountsProvider = Provider<Map<String, int>>((ref) {
  final result = ref.watch(remoteMarkersProvider).value;
  return result?.casesCounts ?? {};
});

// Provider for severityCounts
final severityCountsProvider = Provider<Map<String, int>>((ref) {
  final result = ref.watch(remoteMarkersProvider).value;
  return result?.severityCounts ?? {};
});

// Async fetch of remote markers
final remoteMarkersProvider =
    AsyncNotifierProvider<RemoteMarkersNotifier, RemoteMarkersResult>(
      () => RemoteMarkersNotifier(),
    );

class RemoteMarkersNotifier extends AsyncNotifier<RemoteMarkersResult> {
  late Map<String, int> casesCounts = {};
  late Map<String, int> severityCounts = {};

  Timer? _pollingTimer;
  int _pollingInterval = 1; // default to 5 seconds

  @override
  Future<RemoteMarkersResult> build() async {
    ref.onDispose(() {
      _pollingTimer?.cancel();
    });
    ref.listen(markerIconSizeProvider, (previous, next) {
      if (previous != next) {
        refresh();
      }
    });
    // initial load
    _startPolling();
    return await _loadMarkers();
  }

  void _startPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(Duration(minutes: _pollingInterval), (_) {
      debugPrint('Refreshing map markers...');
      refresh();
    });
  }

  void setPollingInterval(int minutes) {
    _pollingInterval = minutes;
    _startPolling();
  }

  Future<RemoteMarkersResult> _loadMarkers() async {
    try {
      final theme = ref.read(appThemeStateProvider);
      final markerSize = ref.read(markerIconSizeProvider);
      final Map<FilterType, BitmapDescriptor> icons = await MapUtils.loadIcons(
        theme.assets,
        markerSize: Size(markerSize, markerSize),
      );

      casesCounts = {};
      severityCounts = {};

      // Get data from repository/api
      List<MapDataEntity> mapsList = await ref
          .read(mapRepositoryProvider)
          .getMapDataList();

      final markers = <MapMarkerData>[];

      for (var data in mapsList) {
        final FilterType filterType = MapUtils.getFilterType(data);
        final BitmapDescriptor bm =
            icons[filterType] ?? BitmapDescriptor.defaultMarker;

        final String status =
            data.status?.toString().toLowerCase() ?? 'unknown';
        casesCounts[status] = (casesCounts[status] ?? 0) + 1;

        final String severity =
            data.severity?.toString().toUpperCase() ?? 'unknown';
        severityCounts[severity] = (severityCounts[severity] ?? 0) + 1;

        markers.add(
          MapMarkerData(
            position: LatLng(
              data.coordinates?.latitude ?? 0.0,
              data.coordinates?.longitude ?? 0.0,
            ),
            filterType: filterType,
            id: data.id.toString(),
            title: data.type.toString(),
            severity: data.severity.toString().toUpperCase(),
            icon: bm,
            tabType: MapUtils.getCaseType(status),
          ),
        );
      }

      return RemoteMarkersResult(
        markers: markers,
        mapDataList: mapsList,
        casesCounts: casesCounts,
        severityCounts: severityCounts,
      );
    } catch (e, stackTrace) {
      // Handle error
      // Log the error and stack trace
      debugPrint('Error loading markers: $e');
      debugPrint('Stack trace: $stackTrace');
      return RemoteMarkersResult(
        markers: [],
        mapDataList: [],
        casesCounts: {},
        severityCounts: {},
      );
    }
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _loadMarkers());
  }
}

// Auto-refresh toggle
// final autoRefreshProvider = StateProvider<bool>((ref) => false);
//Implement this in the UI where needed
// final autoRefresh = ref.watch(autoRefreshProvider);
// Auto-refresh handling
//     ref.listen<bool>(autoRefreshProvider, (prev, next) {
//       if (next) {
//         ref.read(markersPollingProvider.notifier).startPolling();
//       } else {
//         ref.read(markersPollingProvider.notifier).stopPolling();
//       }
//     });
//
//ref.read(autoRefreshProvider.notifier).state = value;

// final autoRefreshProvider = StateNotifierProvider<AutoRefreshNotifier, bool>((ref) {
//   return AutoRefreshNotifier();
// });
//
// class AutoRefreshNotifier extends StateNotifier<bool> {
//   AutoRefreshNotifier() : super(false);
//
//   Timer? _timer;
//
//   void toggle(bool enabled, {required VoidCallback onTick}) {
//     state = enabled;
//     _timer?.cancel();
//     if (enabled) {
//       _timer = Timer.periodic(const Duration(seconds: 30), (_) => onTick());
//     }
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
// }

//Sample for polling provider (If needed in future)
// final mapPollingProvider = StateNotifierProvider<MapPollingNotifier, AsyncValue<List<MapMarkerData>>>(
//       (ref) => MapPollingNotifier(ref.read),
// );
//
// class MapPollingNotifier extends StateNotifier<AsyncValue<List<MapMarkerData>>> {
//   final Reader read;
//   Timer? _timer;
//   int _pollingInterval = 5; // default to 5 seconds
//
//   bool _isPolling = false;
//
//   bool get isPolling => _isPolling;
//
//   MapPollingNotifier(this.read) : super(const AsyncValue.loading()) {
//     _loadMarkers();
//   }
//
//   void setPollingInterval(int seconds) {
//     _pollingInterval = seconds;
//     if (_isPolling) {
//       _startPolling();
//     }
//   }
//
//   void _startPolling() {
//     _timer?.cancel();
//     _timer = Timer.periodic(Duration(seconds: _pollingInterval), (_) {
//       refresh();
//     });
//     _isPolling = true;
//   }
//
//   void stopPolling() {
//     _timer?.cancel();
//     _isPolling = false;
//   }
//
//   Future<void> refresh() async {
//     state = const AsyncValue.loading();
//     state = await AsyncValue.guard(() => _loadMarkers());
//   }
//}
//
