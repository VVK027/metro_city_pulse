import 'dart:convert';
import 'package:metro_city_pulse/core/utils/log_util.dart';
import 'package:flutter/services.dart';

class Translations {
  final Map<String, String> _map;

  Translations(this._map);

  String tr(String key, {Map<String, String>? namedArgs, List<String>? args}) {
    var value = _map[key] ?? key;

    // Replace positional args {0}, {1}...
    if (args != null) {
      for (var i = 0; i < args.length; i++) {
        value = value.replaceAll('{$i}', args[i]);
      }
    }

    // Replace named args {name}, {count}
    if (namedArgs != null) {
      namedArgs.forEach((placeholder, replacement) {
        value = value.replaceAll('{$placeholder}', replacement);
      });
    }

    return value;
  }

  // static Future<Translations> load(String localeCode) async {
  //   final jsonStr = await rootBundle.loadString('lib/l10n/app_$localeCode.arb');
  //   final data = json.decode(jsonStr) as Map<String, dynamic>;
  //   final values = <String, String>{};
  //
  //   data.forEach((key, value) {
  //     if (value is String) values[key] = value;
  //   });
  //
  //   return Translations._(values);
  // }

  /// Dynamic fallback (proxy-like lookup)
  // String _dynamicLookup(String key, {List<dynamic> args = const []}) {
  //   try {
  //     final symbol = Symbol(key);
  //     final invocation = Invocation.method(symbol, args);
  //     final result = _l10n.noSuchMethod(invocation);
  //     if (result is String) return result;
  //   } catch (_) {}
  //   return key; // fallback to key
  // }
}

class TranslationCache {
  static final Map<String, Map<String, String>> _cache = {};

  /// Preload all supported locales concurrently
  static Future<void> preload(List<String> supportedLocales) async {
    try {
      await Future.wait(
        supportedLocales.map((locale) async {
          if (_cache.containsKey(locale)) return;
          final jsonStr = await rootBundle.loadString(
            'assets/translations/app_$locale.arb',
          );
          final Map<String, dynamic> data =
              jsonDecode(jsonStr) as Map<String, dynamic>;
          _cache[locale] = data.map((k, v) => MapEntry(k, v.toString()));
        }),
      );
    } catch (e) {
      AppLogUtil.logMsg("Error preloading translations:", e.toString());
    }
  }

  /// Get translations from cache
  static Map<String, String> get(String localeCode) {
    return _cache[localeCode] ?? {};
  }
}
