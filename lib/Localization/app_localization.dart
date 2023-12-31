// ignore_for_file: unnecessary_brace_in_string_interps, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 class AppLocalization  {
  final Locale locale;

  AppLocalization(this.locale);

  static AppLocalization? of(BuildContext context) {
    return Localizations.of<AppLocalization>(context, AppLocalization);
  }

  Map<String, String>? _localizedValues;

  Future load() async {
  
    String jsonStringValues =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');

    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);

    _localizedValues =
        mappedJson.map((key, value) => MapEntry(key, value.toString()));
  }

  String? getTranslatedValue(String key) {
     
    return _localizedValues![key];
  }

  static const LocalizationsDelegate<AppLocalization> delegate =
      _DemoLocalizationDelegate();
}

class _DemoLocalizationDelegate
    extends LocalizationsDelegate<AppLocalization> {
  const _DemoLocalizationDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'gu'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalization> load(Locale locale) async {
    AppLocalization localization = AppLocalization(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_DemoLocalizationDelegate old) => false;
}
