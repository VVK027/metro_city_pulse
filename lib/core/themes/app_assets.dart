/// Single source of truth for asset paths shipped with the app.
///
/// Keep this list lean — every entry corresponds to a file declared in
/// `pubspec.yaml` and bundled with the binary. Removing an entry here is the
/// quickest way to catch dead references at compile time.
class AppAssets {
  static const String _baseFilePath = 'assets/images';
  static const String _mapMarkerPath = '$_baseFilePath/map-marker-icons';

  // Dashboard summary card icons
  final String totalVideoIcon = '$_baseFilePath/total-videos-icon.svg';
  final String submittedIcon = '$_baseFilePath/submitted-icon.svg';
  final String processedIcon = '$_baseFilePath/processed-icon.svg';
  final String progressIcon = '$_baseFilePath/progress-icon.svg';

  // Navigation & action icons
  final String dashboardIcon = '$_baseFilePath/dashboard_icon.svg';
  final String statsIcon = '$_baseFilePath/stats_icon.svg';
  final String alertsIcon = '$_baseFilePath/alerts_icon.svg';
  final String chatbotIcon = '$_baseFilePath/chat_bot.svg';
  final String refreshIcon = '$_baseFilePath/refresh_icon.svg';
  final String settingIcon = '$_baseFilePath/setting_icon.svg';
  final String filterIcon = '$_baseFilePath/filter-icon.svg';
  final String powerOff = '$_baseFilePath/power_off.svg';
  final String editSquare = '$_baseFilePath/edit_square.svg';
  final String userProfileIcon = '$_baseFilePath/user_profile_icon.svg';

  // Branding
  final String policeDepartmentLogo = '$_baseFilePath/police_department.png';
  final String policeLogo = '$_baseFilePath/police_logo.png';

  // Map marker icons
  final String publicGroupIcon = '$_mapMarkerPath/public-group.png';
  final String theftIcon = '$_mapMarkerPath/theft.png';
  final String vehicleIcon = '$_mapMarkerPath/vehicle.png';

  // Map zoom / legend controls
  final String locationIcon = '$_mapMarkerPath/location.svg';
  final String zoomInIcon = '$_mapMarkerPath/zoom_in.svg';
  final String zoomOutIcon = '$_mapMarkerPath/zoom_out.svg';
  final String resetIcon = '$_mapMarkerPath/reset_icon.svg';
  final String exclamationIcon = '$_mapMarkerPath/exclamation.svg';
}
