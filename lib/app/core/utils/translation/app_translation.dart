import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../app_storage.dart';
import 'app_strings.dart';
import 'languages/from/ar_sy_translations.dart';
import 'languages/from/en_us_translations.dart';

class AppTranslation extends Translations {

  static Locale get arabicLocale => const Locale(AppStrings.ARABIC_LANG,AppStrings.ARABIC_COUNTRY);
  static Locale get englishLocale => const Locale(AppStrings.ENGLISH_LANG,AppStrings.ENGLISH_COUNTRY);

  static get getDirection => isEnglish ? TextDirection.ltr:TextDirection.rtl;

  static Locale getLocale() {
  final String tag = AppStorage.read(AppStorage.LANGUAGE_KEY) ?? AppStrings.ARABIC;
    final locale = Locale(tag.split('_').first, tag.split('_').last);
    return locale;
  }

  static bool get isEnglish {
    return (getLocale().languageCode == "en") || (Get.locale!.languageCode.split('_').first == AppStrings.ENGLISH_LANG);
  }

  static bool get isArabic {
    return (getLocale().languageCode == AppStrings.ARABIC_LANG) || (Get.locale!.languageCode.split('_').first == AppStrings.ARABIC_LANG);
  }

  static Future saveLocale(Locale locale) async{
    await AppStorage.write(AppStorage.LANGUAGE_KEY, '${locale.languageCode}_${locale.countryCode}');
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        AppStrings.ARABIC: arSY,
        AppStrings.ENGLISH: enUs,
      };
}
