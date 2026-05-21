import 'package:metro_city_pulse/presentation/screens/home/page/home_screen.dart';
import 'package:metro_city_pulse/presentation/screens/login/page/forgot_password_screen.dart';
import 'package:metro_city_pulse/presentation/screens/login/page/login_screen.dart';
import 'package:metro_city_pulse/presentation/screens/profile/page/profile_screen.dart';
import 'package:metro_city_pulse/presentation/screens/settings/page/settings_screen.dart';
import 'package:metro_city_pulse/presentation/screens/signup/page/signup_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  //final isAuth = ref.watch(authProvider);
  //final localRepo = ref.read(localRepositoryProvider);
  // final isLoggedIn = ref.watch(authProvider);
  // final isFirstTime = ref.watch(onboardingProvider);

  return GoRouter(
    routes: [
      // GoRoute(path: AppRoutes.landingScreen, builder: (context, state) {
      //   return const LandingPage();
      // }, redirect: (context, state) async {
      //   if((await localRepo.getUser())?.isVerifyRequired() == true) {
      //     return null;
      //   } else if(await localRepo.isLoggedIn()) {
      //     return await localRepo.isWalkthroughViewed() ? AppRoutes.initialHomeScreen : AppRoutes.walkthroughPage;
      //   } else {
      //     return null;
      //   }
      // }),
      GoRoute(
        path: AppRoutes.landingScreen,
        builder: (context, state) {
          // String? errorMessage;
          // if(state.extra != null) {
          //   errorMessage = (state.extra as Map<String, dynamic>)[errorCode] as String?;
          // }
          return LoginScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.logInScreen,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.signupScreen,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: AppRoutes.forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    redirect: (context, state) {
      // if (!isLoggedIn) return '/login';
      // if (isFirstTime) return '/onboarding';
      return null;
    },
  );
});

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}

class AppRoutes {
  static const String landingScreen = "/";
  static const String logInScreen = "/login";
  static const String homeScreen = "/home";
  static const String profileScreen = "/profile";
  static const String signupScreen = "/signup";
  static const String forgotPasswordScreen = "/forgotPassword";
  static const String settingsScreen = "/settings";
}
