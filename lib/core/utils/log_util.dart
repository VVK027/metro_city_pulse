import 'dart:developer';

import 'package:flutter/foundation.dart';

class AppLogUtil {

  static void logMsg(String tag, dynamic data, [bool addToErrorLogs = false, bool isLongerMsg = false]) {
    if (kDebugMode && isLongerMsg) {
      log("$tag $data");
    } else if (kDebugMode) {
      debugPrint("$tag $data");
    }
  }

}