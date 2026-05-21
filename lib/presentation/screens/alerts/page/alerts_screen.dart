import 'package:metro_city_pulse/core/provider/theme/app_theme_provider.dart';
import 'package:metro_city_pulse/core/themes/app_theme.dart';
import 'package:metro_city_pulse/domain/entities/map_data_entity.dart';
import 'package:metro_city_pulse/domain/entities/map_marker_data.dart';
import 'package:metro_city_pulse/presentation/screens/alerts/provider/alerts_state_provider.dart';
import 'package:metro_city_pulse/presentation/screens/dashboard/component/responsive_date_range_selector.dart';
import 'package:metro_city_pulse/presentation/screens/maps/provider/map_state_provider.dart';
import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_tab_bar_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/common/app_text_widget.dart';
import 'package:metro_city_pulse/presentation/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class AlertsScreen extends ConsumerWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateProvider);
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return Scaffold(
      appBar: null,
      body: isMobile
          ? SafeArea(child: _LeftPanel(theme: theme, isMobileLayout: true))
          : Row(
              children: [
                Container(
                  width: isTablet ? 300 : 360,
                  color: theme.colors.backgroundColor,
                  child: _LeftPanel(theme: theme),
                ),
                const Expanded(child: _RightPanel()),
              ],
            ),
    );
  }
}

/// LEFT PANEL (Alerts List + Filters)
class _LeftPanel extends ConsumerWidget {
  final AppTheme theme;
  final bool isMobileLayout;
  const _LeftPanel({required this.theme, this.isMobileLayout = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final confidenceScore = ref.watch(confidenceProvider);
    final alerts = ref.watch(filteredAlertsProvider);
    final selectedAlert = ref.watch(selectedAlertProvider);

    final shouldClearSelection = alerts.isEmpty && selectedAlert != null;
    final shouldSelectFirst =
        alerts.isNotEmpty &&
        (selectedAlert == null ||
            !alerts.any((alert) => alert.id == selectedAlert.id));

    if (shouldClearSelection || shouldSelectFirst) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final currentSelected = ref.read(selectedAlertProvider);
        if (alerts.isEmpty) {
          if (currentSelected != null) {
            ref.read(selectedAlertProvider.notifier).state = null;
          }
          return;
        }

        final hasCurrentSelection =
            currentSelected != null &&
            alerts.any((alert) => alert.id == currentSelected.id);
        if (!hasCurrentSelection) {
          ref.read(selectedAlertProvider.notifier).state = alerts.first;
        }
      });
    }

    final apiTabCounts = ref.watch(
      remoteMarkersProvider.select(
        (value) => value.value?.casesCounts ?? const <String, int>{},
      ),
    );
    final selectedTab = ref.watch(selectedAlertTabProvider);
    final selectedTabNotifier = ref.read(selectedAlertTabProvider.notifier);

    final tabCounts = apiTabCounts;

    return Container(
      color: theme.colors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SizedBox(height: isMobileLayout ? 8 : 16),
        // Status tabs + date range (same row on mobile)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobileLayout ? 10 : 8),
          child: isMobileLayout
              ? Row(
                  children: [
                    Expanded(
                      child: AppTabBarWidget(
                        theme: theme,
                        isWide: !isMobileLayout,
                        listTabs: [
                          {
                            'label': "new".tr(ref).toAllCapitalize(),
                            'value': tabCounts['new'] ?? 0,
                            'isActive': selectedTab == TabBarType.newTab,
                          },
                          {
                            'label': "dispatch".tr(ref).toAllCapitalize(),
                            'value': tabCounts['dispatch'] ?? 0,
                            'isActive': selectedTab == TabBarType.dispatch,
                          },
                          {
                            'label': "cases".tr(ref).toAllCapitalize(),
                            'value': tabCounts['cases'] ?? 0,
                            'isActive': selectedTab == TabBarType.cases,
                          },
                        ],
                        onTabPressed: (index) {
                          switch (index) {
                            case 0:
                              selectedTabNotifier.state = TabBarType.newTab;
                              break;
                            case 1:
                              selectedTabNotifier.state = TabBarType.dispatch;
                              break;
                            case 2:
                              selectedTabNotifier.state = TabBarType.cases;
                              break;
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    const ResponsiveDateRangeSelector(),
                  ],
                )
              : Center(
                  child: AppTabBarWidget(
                    theme: theme,
                    isWide: true,
                    listTabs: [
                    {
                      'label': "new".tr(ref).toAllCapitalize(),
                      'value': tabCounts['new'] ?? 0,
                      'isActive': selectedTab == TabBarType.newTab,
                    },
                    {
                      'label': "dispatch".tr(ref).toAllCapitalize(),
                      'value': tabCounts['dispatch'] ?? 0,
                      'isActive': selectedTab == TabBarType.dispatch,
                    },
                    {
                      'label': "cases".tr(ref).toAllCapitalize(),
                      'value': tabCounts['cases'] ?? 0,
                      'isActive': selectedTab == TabBarType.cases,
                    },
                  ],
                  onTabPressed: (index) {
                    switch (index) {
                      case 0:
                        selectedTabNotifier.state = TabBarType.newTab;
                        break;
                      case 1:
                        selectedTabNotifier.state = TabBarType.dispatch;
                        break;
                      case 2:
                        selectedTabNotifier.state = TabBarType.cases;
                        break;
                    }
                  },
                ),
              ),
        ),

        const Divider(),

        // Date + Confidence
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isMobileLayout)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "confidence_score".tr(ref).toAllCapitalize(),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            ">= ${confidenceScore.toInt()}",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: confidenceScore,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: "${confidenceScore.toInt()}",
                      onChanged: (value) {
                        ref.read(confidenceProvider.notifier).state = value;
                      },
                    ),
                  ],
                )
              else ...[
                Row(
                  children: [
                    Expanded(
                      child: Text("select_date_range".tr(ref).toAllCapitalize()),
                    ),
                    const ResponsiveDateRangeSelector(),
                  ],
                ),
                const SizedBox(height: 8),
                const Divider(),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text("confidence_score".tr(ref).toAllCapitalize()),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        ">= ${confidenceScore.toInt()}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: confidenceScore,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: "${confidenceScore.toInt()}",
                  onChanged: (value) {
                    ref.read(confidenceProvider.notifier).state = value;
                  },
                ),
              ],
            ],
          ),
        ),

        const Divider(),

        // Alerts List
          Expanded(
            child: ClipRect(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 8),
                primary: false,
                itemCount: alerts.length,
                itemBuilder: (context, index) {
                  final alert = alerts[index];
                  final isSelected = selectedAlert?.id == alert.id;
                  final title = alert.type?.trim().isNotEmpty == true
                      ? alert.type!.trim()
                      : "Alert";
                  final camera = alert.cameraName?.trim().isNotEmpty == true
                      ? alert.cameraName!.trim()
                      : (alert.vehicleNo?.trim().isNotEmpty == true
                            ? alert.vehicleNo!.trim()
                            : "--");
                  final location =
                      alert.locationName?.trim().isNotEmpty == true
                      ? alert.locationName!.trim()
                      : (alert.locationAddress?.trim().isNotEmpty == true
                            ? alert.locationAddress!.trim()
                            : "--");
                  final reportedAt = _parseReportedTime(alert.isoTimestamp);
                  return ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.camera_alt)),
                    title: AppText(title, fontWeight: FontWeight.bold),
                    selected: isSelected,
                    selectedTileColor: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.12),
                    subtitle: Text(
                      "${"camera".tr(ref).toAllCapitalize()}: $camera\n"
                      "${"location".tr(ref).toAllCapitalize()}: $location",
                    ),
                    isThreeLine: true,
                    trailing: Text(
                      "${reportedAt.month}/${reportedAt.day}/${reportedAt.year}\n${reportedAt.hour}:${reportedAt.minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 12),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () {
                      ref.read(selectedAlertProvider.notifier).state = alert;
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// RIGHT PANEL (Video + Actions + Details)
class _RightPanel extends ConsumerStatefulWidget {
  const _RightPanel();

  @override
  ConsumerState<_RightPanel> createState() => _RightPanelState();
}

class _RightPanelState extends ConsumerState<_RightPanel> {
  VideoPlayerController? _controller;
  String? _activeVideoUrl;
  bool _isVideoInitializing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String? _normalizedUrl(String? value) {
    final trimmed = value?.trim() ?? "";
    return trimmed.isEmpty ? null : trimmed;
  }

  void _syncVideoController(String? videoUrl) {
    if (_activeVideoUrl == videoUrl) {
      return;
    }

    _activeVideoUrl = videoUrl;
    final previousController = _controller;
    _controller = null;
    previousController?.dispose();

    if (videoUrl == null) {
      if (mounted) {
        setState(() => _isVideoInitializing = false);
      }
      return;
    }

    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    _controller = controller;
    if (mounted) {
      setState(() => _isVideoInitializing = true);
    }

    controller
        .initialize()
        .then((_) {
          if (!mounted || _controller != controller) {
            return;
          }
          controller
            ..setLooping(true)
            ..play();
          setState(() => _isVideoInitializing = false);
        })
        .catchError((_) {
          if (!mounted || _controller != controller) {
            return;
          }
          setState(() => _isVideoInitializing = false);
        });
  }

  @override
  Widget build(BuildContext context) {
    final selectedAlert = ref.watch(selectedAlertProvider);
    final videoUrl = _normalizedUrl(selectedAlert?.cameraUrl);
    final imageUrl = _normalizedUrl(selectedAlert?.imageUrl);
    _syncVideoController(videoUrl);

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Video Evidence
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              constraints: const BoxConstraints(maxHeight: 320),
              color: Colors.black,
              width: double.infinity,
              child:
                  videoUrl != null && _controller?.value.isInitialized == true
                  ? AspectRatio(
                      aspectRatio: _controller!.value.aspectRatio,
                      child: VideoPlayer(_controller!),
                    )
                  : imageUrl != null
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        "assets/images/traffic_area.jpg",
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: 220,
                      child: Center(
                        child: videoUrl != null && _isVideoInitializing
                            ? const CircularProgressIndicator()
                            : const Text(
                                "No evidence available",
                                style: TextStyle(color: Colors.white70),
                              ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 12),

          // Action Buttons
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.work),
                label: Text("create_case".tr(ref).toAllCapitalize()),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.feedback),
                label: Text("feedback".tr(ref).toAllCapitalize()),
                onPressed: () {},
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.sos, color: Colors.white),
                label: Text("sos".tr(ref).toUpperCase()),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {},
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.close),
                label: Text("ignore".tr(ref).toAllCapitalize()),
                onPressed: () {},
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Alert Info Card
          if (selectedAlert != null) ...[
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: const Icon(Icons.security, size: 36),
                title: Text(
                  selectedAlert.type?.trim().isNotEmpty == true
                      ? selectedAlert.type!.trim()
                      : "Alert",
                ),
                subtitle: Text(
                  selectedAlert.isoTimestamp ??
                      _parseReportedTime(
                        selectedAlert.isoTimestamp,
                      ).toIso8601String(),
                ),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "${"confidence".tr(ref).toAllCapitalize()} ${selectedAlert.confidenceScore ?? 0}%",
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: _AlertDetailsPanel(alert: selectedAlert, ref: ref),
            ),
          ] else
            Text(
              "select_alert_to_view_details".tr(ref).toAllCapitalize(),
              style: const TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}

class _AlertDetailsPanel extends StatelessWidget {
  final MapDataEntity alert;
  final WidgetRef ref;

  const _AlertDetailsPanel({required this.alert, required this.ref});

  String _value(String? value) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isEmpty ? '--' : trimmed;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final details = <MapEntry<String, String>>[
      MapEntry('ID', _value(alert.id)),
      MapEntry('type'.tr(ref).toAllCapitalize(), _value(alert.type)),
      MapEntry('camera'.tr(ref).toAllCapitalize(), _value(alert.cameraName)),
      MapEntry('location'.tr(ref).toAllCapitalize(), _value(alert.locationName)),
      MapEntry('Address', _value(alert.locationAddress)),
      MapEntry('Location Type', _value(alert.locationType)),
      MapEntry(
        'Latitude',
        alert.coordinates?.latitude?.toStringAsFixed(6) ?? '--',
      ),
      MapEntry(
        'Longitude',
        alert.coordinates?.longitude?.toStringAsFixed(6) ?? '--',
      ),
      MapEntry('Date', _value(alert.date)),
      MapEntry('Time', _value(alert.time)),
      MapEntry('Timestamp', _value(alert.isoTimestamp)),
      MapEntry(
        'confidence'.tr(ref).toAllCapitalize(),
        '${alert.confidenceScore ?? 0}%',
      ),
      MapEntry('Status', _value(alert.status).toAllCapitalize()),
      MapEntry('Severity', _value(alert.severity)),
      MapEntry('Live', alert.isLive == true ? 'Yes' : 'No'),
      MapEntry('Vehicle No', _value(alert.vehicleNo)),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: details.length,
        separatorBuilder: (context, index) => const Divider(height: 20),
        itemBuilder: (context, index) {
          final entry = details[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 130,
                child: Text(
                  entry.key,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  entry.value,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

DateTime _parseReportedTime(String? value) {
  if (value == null || value.trim().isEmpty) {
    return DateTime.now();
  }
  return DateTime.tryParse(value.trim()) ?? DateTime.now();
}
