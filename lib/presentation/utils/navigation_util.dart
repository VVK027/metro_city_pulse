import 'package:metro_city_pulse/core/router/app_router_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NavigationUtil {

  static Future<T?> push<T>(BuildContext context, String path, {Map<String, dynamic>? params, GoRouter? router}) async {
    return (router ?? GoRouter.of(context)).push<T>(path, extra: params);
  }

  static Future<T?> pushReplace<T>(BuildContext context, String path, {Map<String, dynamic>? params, GoRouter? router}) {
    return (router ?? GoRouter.of(context)).pushReplacement<T>(path, extra: params);
  }

  static Future<T?> pushReplaceUntil<T>(BuildContext context, String path, {Map<String, dynamic>? params, GoRouter? router}) {
    final routerObj = router ?? GoRouter.of(context);
    while (routerObj.canPop()) {
      routerObj.pop();
    }
    return pushReplace(context, path, params: params, router: router);
  }

  static void pop(BuildContext context, {dynamic result, GoRouter? router}) {
    return (router ?? GoRouter.of(context)).pop(result);
  }

  static void popUntil(BuildContext context, String path, {dynamic result, GoRouter? router}) {
    return Navigator.popUntil(context, ModalRoute.withName(path));
  }

  static bool canPop(BuildContext context, {GoRouter? router}) {
    return (router ?? GoRouter.of(context)).canPop();
  }

  static bool isInheritedFromGoRouter(BuildContext context) {
    return GoRouter.maybeOf(context) != null;
  }

  static Future<void> clearDataAndMoveToLogin(BuildContext context, WidgetRef ref, String source, {String? errorMessage}) async {
    // String location = ref.read(getRouterProvider).location();
    // final isLoggedIn = await ref.read(localRepositoryProvider).isLoggedIn();
   // LogUtil.log(source, "Route: $location, IsLoggedIn: $isLoggedIn");
   //  if (location != AppRoutes.logInScreen && isLoggedIn) {
   //   // LogUtil.log(source, "clear data and move to login");
   //    // ref.read(getPollingControllerProvider).stopAndDispose();
   //    // await ref.read(localRepositoryProvider).clearData();
   //    await EnvironmentChangeHelper.updateEnvAndLogging(ref, Env.defaultEnv(), false);
      if (context.mounted) {
        NavigationUtil.pushReplaceUntil(context,
            AppRoutes.logInScreen,
            router: ref.read(goRouterProvider),
            //params: {errorCode : errorMessage},
        );
      }
   //  }
  }
}