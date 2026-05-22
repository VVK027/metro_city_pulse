# Metro City Pulse

A cross-platform Flutter app for real-time smart city monitoring and traffic incident management. Metro City Pulse gives operators a unified view of city incidents on an interactive map, operational statistics, CCTV-backed alerts, and user settings — optimized for mobile, tablet, and desktop layouts.

## Features

- **Interactive map dashboard** — Google Maps view of incidents across Bengaluru with marker filtering, severity legend, custom info windows, zoom controls, and periodic data refresh.
- **Stats overview** — Summary cards (total cases, new alerts, open cases, total videos), embedded map section, and recent alerts.
- **Alerts workspace** — Filterable alert list with confidence scoring, date-range selection, tabbed case status, and CCTV video playback.
- **Responsive shell** — Side navigation on tablet/desktop; drawer + bottom navigation on mobile. Layout adapts via a custom `AppResponsive` breakpoint system.
- **Authentication flow** — Login, signup, and forgot-password screens wired to Firebase Auth (requires Firebase project setup).
- **Localization** — English and Spanish via ARB translation files with runtime locale switching.
- **Theming** — Light and dark mode with persisted user preference.
- **Connectivity awareness** — Offline detection using `connectivity_plus` with a dedicated no-internet screen.

## Tech Stack

| Category | Packages |
|----------|----------|
| Framework | [Flutter](https://flutter.dev) (SDK ^3.10.9) |
| State management | [Riverpod](https://riverpod.dev) (`hooks_riverpod`, `riverpod_annotation`, code generation) |
| Navigation | [GoRouter](https://pub.dev/packages/go_router) |
| Maps | [google_maps_flutter](https://pub.dev/packages/google_maps_flutter), [google_maps_cluster_manager_2](https://pub.dev/packages/google_maps_cluster_manager_2) |
| Auth | [firebase_core](https://pub.dev/packages/firebase_core), [firebase_auth](https://pub.dev/packages/firebase_auth), [msal_auth](https://pub.dev/packages/msal_auth) / [msal_js](https://pub.dev/packages/msal_js) (MSAL not yet integrated) |
| Media | [video_player](https://pub.dev/packages/video_player) |
| Storage | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| UI | [flutter_svg](https://pub.dev/packages/flutter_svg), [syncfusion_flutter_datepicker](https://pub.dev/packages/syncfusion_flutter_datepicker), Poppins font |
| Networking | [connectivity_plus](https://pub.dev/packages/connectivity_plus) |
| Serialization | [json_annotation](https://pub.dev/packages/json_annotation) / [json_serializable](https://pub.dev/packages/json_serializable) |

## Project Structure

The codebase follows **Clean Architecture**:

```text
lib/
├── core/                 # App bootstrap, routing, themes, providers, constants, utils
│   ├── config/           # Environment configuration (prod/stage/dev/test)
│   ├── router/           # GoRouter setup and route constants
│   ├── provider/         # Global Riverpod providers (theme, locale, repositories)
│   └── themes/           # Light/dark theme definitions and assets
├── data/                 # Models, local/remote data sources, repository implementations
│   ├── data_source/
│   │   ├── local/        # SharedPreferences / local DB
│   │   └── remote/       # REST API service and endpoints
│   ├── models/
│   └── repositories/
├── domain/               # Entities, repository contracts, use cases
├── presentation/         # Screens, widgets, feature-specific providers
│   ├── screens/
│   │   ├── home/         # App shell (side menu, bottom nav)
│   │   ├── maps/         # Map dashboard
│   │   ├── dashboard/    # Stats screen
│   │   ├── alerts/       # Alerts list and video panel
│   │   ├── login/        # Auth screens
│   │   ├── profile/
│   │   └── settings/
│   └── widgets/          # Shared UI components
└── main.dart             # Entry point
```

## Screens & Navigation

| Route | Screen | Description |
|-------|--------|-------------|
| `/` | Login | Landing / sign-in with responsive split layout |
| `/login` | Login | Email & password authentication |
| `/signup` | Signup | New user registration |
| `/forgotPassword` | Forgot Password | Password reset flow |
| `/home` | Home | Main shell with map, stats, alerts, and chat nav items |
| `/profile` | Profile | User profile details |
| `/settings` | Settings | Language and theme preferences |

Inside `/home`, navigation works as follows:

| Nav item | Screen | Notes |
|----------|--------|-------|
| Dashboard | `CustomMapScreen` | Full-screen Google Maps incident view |
| Stats | `DashboardScreen` | KPI cards, map section, recent alerts |
| Alerts | `AlertsScreen` | Alert list + CCTV video player |
| Chat AI | — | Placeholder in bottom nav (not yet implemented) |

## Data Sources

Map and alert data currently loads from bundled sample JSON:

- `assets/json/maps_sample_data.json` — incident records for Bengaluru locations

The `MapRepository` is structured to swap this for a REST API call once backend endpoints are configured in `lib/core/config/environment.dart` and `lib/data/data_source/remote/endpoints.dart`.

## Getting Started

### Prerequisites

- Flutter SDK ^3.10.9
- Dart SDK (bundled with Flutter)
- A [Google Maps API key](https://developers.google.com/maps/documentation/android-sdk/get-api-key) with Maps SDK enabled
- A [Firebase project](https://console.firebase.google.com/) (for authentication)

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/VK027/metro_city_pulse.git
   cd metro_city_pulse
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   Riverpod and JSON serialization rely on `build_runner`:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Configure Google Maps**

   Add your API key to the platform manifests:

   - **Android** — `android/app/src/main/AndroidManifest.xml` inside `<application>`:

     ```xml
     <meta-data
         android:name="com.google.android.geo.API_KEY"
         android:value="YOUR_API_KEY"/>
     ```

   - **iOS** — `ios/Runner/AppDelegate.swift` or `ios/Runner/Info.plist`:

     ```xml
     <key>GMSApiKey</key>
     <string>YOUR_API_KEY</string>
     ```

   - **Web** — load the Maps JavaScript API with your key in `web/index.html`.

5. **Configure Firebase** (optional, required for auth)

   - Create a Firebase project and add Android/iOS/Web apps.
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) into the respective platform folders.
   - Run `flutterfire configure` to generate `firebase_options.dart`.
   - Uncomment `Firebase.initializeApp()` in `lib/core/main_initialisation.dart`.

6. **Run the app**

   ```bash
   flutter run
   ```

   Supported targets: **Android**, **iOS**, **Web**, **macOS**, **Linux**, and **Windows**.

### Environment Configuration

API base URLs for prod, stage, dev, and test environments are defined in `lib/core/config/environment.dart`. Update the `restBaseUrl` values and wire up the REST client in `lib/core/dependency_manager.dart` when connecting to a live backend.

## Development

### Localization

Translation files live in `assets/translations/`:

- `app_en.arb` — English
- `app_es.arb` — Spanish

Add or update keys in both files, then use `.tr(ref)` via the localization utilities.

### Linting

The project uses `flutter_lints` and `riverpod_lint` with a custom lint plugin. Run analysis with:

```bash
flutter analyze
```

### Tests

```bash
flutter test
```

## License

Private project — not published to pub.dev (`publish_to: 'none'`).

---

Made with care by [Viivek Kumar](https://github.com/VK027)
