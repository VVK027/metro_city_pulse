import 'dart:io';

import 'package:flutter/foundation.dart';

abstract class BaseApiRepository {
  static const String _tag = "BaseApiRepository";

  @protected
  Future<void> callApi<T, H>({
    required Future<HttpResponse> Function() request,
  }) async {

  }

  bool _isSuccessFull(int? statusCode) {
    return statusCode != null && (statusCode >= 200 && statusCode <= 204);
  }
}
