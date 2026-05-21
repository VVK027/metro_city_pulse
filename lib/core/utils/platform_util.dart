import 'package:flutter/foundation.dart';

class PlatformUtil {
  static bool get isAndroid => defaultTargetPlatform == TargetPlatform.android;

  static bool get isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isWindows => defaultTargetPlatform == TargetPlatform.windows;

  static bool get isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  // static bool isAndroid12OrAbove() {
  //   final osVersion = NativeCommunicationChannel.get().getOSValue();
  //   return osVersion != null && osVersion >= 31;
  // }
}
