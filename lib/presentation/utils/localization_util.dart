import 'package:metro_city_pulse/core/provider/language_provider.dart';
import 'package:metro_city_pulse/core/utils/log_util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocalizationUtil {

  LocalizationUtil._();

  // static updateLanguage(BuildContext context, Locale locale, WidgetRef ref, {bool refreshDashboard = true}) async {
  //   await context.setLocale(locale);
  //   currentLocale = locale;
  //   await WidgetsFlutterBinding.ensureInitialized().performReassemble();
  //   if (refreshDashboard) {
  //     ref.read(getSafetyTabControllerProvider).reload();
  //   }
  // }

  static bool isEnglishLanguageSelected(BuildContext context) {
    //return context.locale.languageCode == "en";
    return Localizations.localeOf(context).languageCode == "en";
  }

  // static String getCurrentLanguageCode() {
  //   return Localizations.localeOf(context).languageCode;
  // }
//
//   static Locale getLocaleFromCode(String? code) {
//     return code == "fr" ? const Locale("fr", "FR") : const Locale("en", "US");
//   }
//
//   static String getLanguageNameKey(Locale locale) {
//     return locale.languageCode == "fr" ? "french_canadian" : "english";
//   }
//
//   static isValidCountry(String countryName) {
//     return isCountryCanada(countryName) || isCountryUSA(countryName) || isCountryJamaica(countryName);
//   }
//
//
//
//   static List<String> getCountriesNameList() {
//     List<String> nameList = ["select_one".tr(ref)];
//     List<String> countryList = getListOfCountriesWithFlagDialCode().map((element) => element["name"].toString()).toList();
//     nameList.addAll(countryList);
//     return nameList;
// }
//
// List<Map<String, dynamic>> getListOfCountriesWithFlagDialCode(WidgetRef ref) {
//   return [
//     {"name":"usa".tr(ref),"flag":"🇺🇸","code":"US","dial_code":"+1"},
//     {"name":"Spanish".tr(ref),"flag":"🇪🇸", "code":"ES", "dial_code":"+34"},
//     {"name":"India","flag":"🇮🇳","code":"IN","dial_code":"+91"}, // Keeping for testing purpose
//   ];
// }

}

extension StringExtension on String {

  //Usage Example:
  // Text('welcome'.tr(ref)),
  // Text('hello_user'.tr(ref, args: ['John'])),
  // Text('apples_count'.tr(ref, namedArgs: {'count': '3'})),
  String tr(WidgetRef ref, {Map<String, String>? namedArgs, List<String>? args}) {
    final translations = ref.watch(translationsProvider);
    return translations.tr(this, namedArgs: namedArgs, args: args);
  }


  bool equalsIgnoreCase(String? text) {
    return toLowerCase() == text?.toLowerCase();
  }

  bool containsIgnoreCase(String? text) {
    return text == null ? true : toLowerCase().contains(text.toLowerCase());
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String toAllCapitalize() {
    List<String> strings = split(' ');
    return strings.map((word) => word.capitalize()).join(" ").trim();
  }

  double toDouble() {
    try {
      return double.parse(this);
    } catch (e) {
      AppLogUtil.logMsg("StringExtension", "toDouble: parsing failed, $e");
    }
    return 0.0;
  }
}