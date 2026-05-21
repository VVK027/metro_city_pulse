import 'dart:async';

import 'package:metro_city_pulse/core/utils/log_util.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'internet_util_provider.g.dart';

@riverpod
class InternetUtilState extends _$InternetUtilState {
  static const String tag = "InternetUtilState";

  StreamSubscription<ConnectivityResult>? _subscription;

  @override
  bool build() => true;

  void dispose() {
    AppLogUtil.logMsg(tag, "dispose called");
    _subscription?.cancel();
  }

  void onConnectivityChanged() {
    // InternetUtil.isConnected().then((value) {
    //   state = value;
    // });
    // _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    //   state = await InternetUtil.isConnected();
    // });
    ref.onDispose(dispose);
  }
}
