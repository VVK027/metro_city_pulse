import 'package:metro_city_pulse/core/themes/app_theme.dart';

List<Map<String, dynamic>> statsList(AppTheme theme) {
  return [
    {'label': 'Total Cases', 'value': '200', 'icon': theme.assets.totalVideoIcon, 'color': theme.colors.secondaryColor},
    {'label': 'New Alerts', 'value': '180', 'icon': theme.assets.submittedIcon, 'color': theme.colors.accent},
    {'label': 'Open Cases', 'value': '9', 'icon': theme.assets.processedIcon, 'color': theme.colors.primaryColor},
    {'label': 'Total Videos', 'value': '240', 'icon': theme.assets.progressIcon, 'color': theme.colors.blue},
  ];
}

// https://picsum.photos/200/300?random=1
final List<Map<String, dynamic>> recentAlerts = [
  {
    'title': 'Crowd Alert',
    'camera': 'CCTV_Majestic_Cam03',
    'location': 'Majestic Bus Station',
    'case': '1024',
    'imageUrl': 'https://image.tmdb.org/t/p/w780/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg',
    'id': '238642',
    'timestamp':'Nov 3 2025 6:35:40 PM'
  },
  {
    'title': 'Stalled vehicle Alert',
    'camera': 'CCTV_KIA_Gate03_Cam01',
    'location': 'Kempegowda Int. Airport',
    'case': '842',
    'imageUrl': 'https://image.tmdb.org/t/p/w780/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg',
    'id': '238642',
    'timestamp':'Nov 3 2025 6:35:40 PM'
  },
  {
    'title': 'Vandalism-Perimeter Breach Alert',
    'camera': 'EI34',
    'location': 'M.G. Road Metro',
    'case': '345',
    'imageUrl': 'https://image.tmdb.org/t/p/w780/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg',
    'id': '238642',
    'timestamp':'Nov 3 2025 6:35:40 PM'
  },
  {
    'title': 'Criminal Activity',
    'camera': 'EI34',
    'location': 'Indiranagar 100 Ft Rd',
    'case': '212',
    'imageUrl': 'https://image.tmdb.org/t/p/w780/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg',
    'id': '238642',
    'timestamp':'Nov 3 2025 6:35:40 PM'
  },
];

