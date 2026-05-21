import 'package:metro_city_pulse/presentation/utils/localization_util.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AppUtils {

  static bool checkSpecialCharacters(String kdDetectorName) {
    return kdDetectorName.contains(RegExp(r'[!@#$%^&*(),.?":;~`{}|<>]'));
  }

  static bool checkLeadingWhiteSpace(String kdDetectorName) {
    return kdDetectorName.split(" ").first == '';
  }

  static bool checkTrailingWhiteSpace(String kdDetectorName) {
    return kdDetectorName.split(" ").last == '';
  }

  static bool validEmail(String email) {
    return email.contains(RegExp("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"));
  }

  static bool validPhoneNumber(String phone, [bool isEmergencyContact = false]) {
    if (isEmergencyContact == true && phone == "911") {
      return true;
    }
    return (phone.isNotEmpty && phone.length >= 7 &&  phone.length <= 13);
  }

  static String getFirstName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "";
    } else {
      try {
        final parts = name.split(" ");
        return parts.length > 1 ? parts.getRange(0, parts.length-1).join(" ") : name;
      } catch (_) {
        return "";
      }
    }
  }

  static String getLastName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "";
    } else {
      try {
        final parts = name.split(" ");
        return parts.length > 1 ? parts.last : "";
      } catch (_) {
        return "";
      }
    }
  }

  // static Future<bool> callNumber(String number) async {
  //   String newNum = number.startsWith("+") ? number : "+$number";
  //   return launchUri(Uri(scheme: "tel", path: newNum));
  // }

  // static Future<bool> launchInAppBrowserUri(Uri uri) async {
  //   try {
  //     if (await canLaunchUrl(uri)) {
  //       return await launchUrl(uri, mode: LaunchMode.platformDefault);
  //     }
  //   } catch (e) {
  //     LogUtil.log("launchInAppBrowserUri", "unable to launch $uri, error: $e");
  //   }
  //   return false;
  // }

  // static Future<bool> launchUri(Uri uri) async {
  //   try {
  //     if (await canLaunchUrl(uri)) {
  //       return await launchUrl(uri);
  //     }
  //   } catch (e) {
  //     LogUtil.log("launchUri", "unable to launch $uri, error: $e");
  //   }
  //   return false;
  // }

  // static Future<bool> launchApp(String shortLink, String fullLink) async {
  //   try {
  //     if (!(await launchUri(Uri.parse(shortLink)))) {
  //       launchUri(Uri.parse(fullLink));
  //     }
  //   } catch (_) {}
  //   return false;
  // }

  static String getShortNamedString(String? name) {
    List<String> list = name?.split(" ") ?? [""];
    if (list.length > 1) {
      var k = "";
      if (list.first.isNotEmpty) {
        k = list.first.split("").first.toUpperCase();
      }
      if (list[1].isNotEmpty) {
        k += list[1].split("").first.toUpperCase();
      }
      return k;
    } else if (list.first.split("").isNotEmpty) {
      return list.first.split("").first.toUpperCase();
    }
    return "";
  }

  static String? getPasswordErrorText(WidgetRef ref, String? errorCode) {
    if(errorCode == 'invalid_password'){
      return 'invalid_password'.tr(ref);
    }
    if(errorCode == "WeakPasswordError") {
      return "weak_password_error".tr(ref);
    }
    if(errorCode == "password_required") {
      return "password_required".tr(ref);
    }
    if(errorCode == "no_user") {
      return "no_user".tr(ref);
    }
    return null;
  }

  // static Color getPasswordBorderColor(AppColors colors, String? errorCode) {
  //   if(errorCode != null && errorCode == "no_user") {
  //     return colors.errorSuggestionTextColor;
  //   }
  //   return colors.entryFieldsBorderColor;
  // }

  static String? getEmailErrorText(WidgetRef ref, String text, String? errorCode) {
    if(!validEmail(text) && text.isNotEmpty) {
      return "invalid_email".tr(ref);
    } else if(errorCode == "invalid_email") {
      return "invalid_email".tr(ref);
    } else if(errorCode == "email_already_used") {
      return "email_already_used".tr(ref);
    } else if(errorCode == "user_not_found") {
      return "user_not_found".tr(ref);
    }
    return null;
  }

  static String? getEmailPasswordErrorText(WidgetRef ref, String? errorCode) {
    if(errorCode == "invalid_email") {
      return "invalid_email".tr(ref);
    } else if(errorCode == "email_already_used") {
      return "email_already_used".tr(ref);
    } else if(errorCode == "user_not_found") {
      return "user_not_found".tr(ref);
    } else if(errorCode == 'invalid_password'){
      return 'invalid_password'.tr(ref);
    }
    if(errorCode == "WeakPasswordError") {
      return "weak_password_error".tr(ref);
    }
    if(errorCode == "password_required") {
      return "password_required".tr(ref);
    }
    if(errorCode == "no_user") {
      return "no_user".tr(ref);
    }
    return null;
  }

  // static Color getEmailBorderColor(String text, AppColors colors) {
  //   if(!validEmail(text) && text.isNotEmpty) {
  //     return colors.errorSuggestionTextColor;
  //   }
  //   return colors.entryFieldsBorderColor;
  // }

  static bool isValidName(String text) {
    if(checkSpecialCharacters(text) && text.isNotEmpty) {
      return false;
    } else if(checkLeadingWhiteSpace(text) && text.isNotEmpty) {
      return false;
    } else if(checkTrailingWhiteSpace(text) && text.isNotEmpty) {
      return false;
    }
    return true;
  }

  static String? getNameErrorText(WidgetRef ref, String text) {
    if(checkSpecialCharacters(text) && text.isNotEmpty) {
      return "name_must_not_contain_special_characters".tr(ref).capitalize();
    } else if(checkLeadingWhiteSpace(text) && text.isNotEmpty) {
      return "name_must_begin_with_alphanumeric".tr(ref).capitalize();
    } else if(checkTrailingWhiteSpace(text) && text.isNotEmpty) {
      return "name_must_end_with_alphanumeric".tr(ref).capitalize();
    }
    return null;
  }

  // static Color getNameBorderColor(String text, AppColors colors) {
  //   if(checkSpecialCharacters(text) && text.isNotEmpty) {
  //     return colors.errorSuggestionTextColor;
  //   } else if(checkLeadingWhiteSpace(text) && text.isNotEmpty) {
  //     return colors.errorSuggestionTextColor;
  //   } else if(checkTrailingWhiteSpace(text) && text.isNotEmpty) {
  //     return colors.errorSuggestionTextColor;
  //   }
  //   return colors.entryFieldsBorderColor;
  // }

  // static Color getPhoneNumberBorderColor(String text, AppColors colors, [bool isEmergencyContact = false]) {
  //   if (isEmergencyContact == true && text == "911") {
  //     return colors.entryFieldsBorderColor;
  //   }
  //   else if(!validPhoneNumber(text) && text.isNotEmpty) {
  //     return colors.errorSuggestionTextColor;
  //   }
  //   return colors.entryFieldsBorderColor;
  // }

  static String getDialCode(String? countryCode){
    return countryCode == null ? '' : countryCode.toUpperCase() == 'IN' ? '+91' : '+1';
  }

  static String? getPhoneErrorText(WidgetRef ref, String text, String? errorCode) {
    if(!AppUtils.validPhoneNumber(text) && text.isNotEmpty ) {
      return "invalid_phone".tr(ref);
    } else if(errorCode == "bad_phone") {
      return "bad_phone".tr(ref);
    }
    return null;
  }

  static FilteringTextInputFormatter propertyNameFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]'));

  static FilteringTextInputFormatter nameFormatter = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]'));
  
  static FilteringTextInputFormatter denyNameFormatter = FilteringTextInputFormatter.deny(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  static FilteringTextInputFormatter phoneFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
}