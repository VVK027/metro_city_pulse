# Metro City Pulse

A real-time smart city monitoring and traffic information dashboard. Metro City Pulse provides a unified interface to track city incidents, monitor CCTV feeds, and visualize traffic alerts on an interactive map.

## 🚀 Key Features

- **Real-time Dashboard**: Get a high-level overview of total cases, new alerts, and open incidents.
- **Interactive Map Visualization**: Track incidents and traffic status across the city using Google Maps with clustering support.
- **Incident Alerts**: Real-time notifications for crowd alerts, stalled vehicles, vandalism, and other activities.
- **Responsive Design**: Optimized for Mobile, Tablet, and Web platforms using the `responsive_framework`.
- **Secure Authentication**: Integration with MSAL (Microsoft Authentication Library) and Firebase Auth.
- **Multi-language Support**: Fully localized in English and Spanish.
- **Dark/Light Mode**: Full theme support to suit user preferences.

## 🛠 Tech Stack

- **Frontend**: [Flutter](https://flutter.dev)
- **State Management**: [Riverpod](https://riverpod.dev) (Hooks & Annotation)
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router)
- **Maps**: [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter) & [Cluster Manager](https://pub.dev/packages/google_maps_cluster_manager_2)
- **Backend/Auth**: [Firebase](https://firebase.google.com/), [MSAL Auth](https://pub.dev/packages/msal_auth)
- **Local Storage**: [Shared Preferences](https://pub.dev/packages/shared_preferences)
- **UI Components**: [Syncfusion Flutter Datepicker](https://pub.dev/packages/syncfusion_flutter_datepicker), [Flutter SVG](https://pub.dev/packages/flutter_svg)

## 📁 Project Structure

The project follows the **Clean Architecture** pattern to ensure scalability and maintainability:

```text
lib/
├── core/           # App-wide configurations, themes, constants, and global providers.
├── data/           # Data sources (remote/local) and repository implementations.
├── domain/         # Domain entities and use cases (business logic).
├── presentation/   # UI layer: Screens, widgets, and state providers.
└── main.dart       # Entry point of the application.
```

## 🏁 Getting Started

### Prerequisites

- Flutter SDK (^3.10.9)
- Google Maps API Key (Configured in AndroidManifest.xml and Info.plist)
- MSAL/Firebase configuration files (where applicable)

### Installation

1.  **Clone the repository**
    ```bash
    git clone https://github.com/yourusername/metro_city_pulse.git
    cd metro_city_pulse
    ```

2.  **Install dependencies**
    ```bash
    flutter pub get
    ```

3.  **Generate code**
    The project uses `build_runner` for Riverpod and JSON serialization.
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the application**
    ```bash
    flutter run
    ```

## 📱 Screens

- **Login/Signup**: Secure authentication flow.
- **Dashboard**: Real-time statistics and quick access to maps and alerts.
- **Map View**: Detailed geographical view of incidents.
- **Alerts**: Comprehensive list of recent city alerts.
- **Profile & Settings**: Manage user profiles, app language, and theme modes.

---

Made with ❤️ by [Viivek Kumar](https://github.com/vvk)
