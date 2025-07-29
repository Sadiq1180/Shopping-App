import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/api_models/language_model.dart';
import '../shared/app_persistance/app_local.dart';
import '../shared/constants/lang_constants.dart';

final localizationProvider =
    NotifierProvider<LocalizationProvider, Language>(LocalizationProvider.new);

class LocalizationProvider extends Notifier<Language> {
  @override
  Language build() => _loadCurrentLanguage();

  Language _loadCurrentLanguage() {
    int selectedLang = AppLocal.ins.appBox
        .get(LangConstants.languageIndex, defaultValue: 0);
    LanguageModel lang = LangConstants.languages.elementAt(selectedLang);
    return Language(
        locale: Locale(lang.languageCode, lang.countryCode),
        selectedLang: selectedLang);
  }

  void setLanguage(int langIndex) {
    LanguageModel lang = LangConstants.languages.elementAt(langIndex);
    AppLocal.ins.appBox.put(LangConstants.languageIndex, langIndex);
    state = Language(
        locale: Locale(lang.languageCode, lang.countryCode),
        selectedLang: langIndex);
  }
}

class Language {
  Locale? locale;
  int? selectedLang;
  Language({this.locale, this.selectedLang});
  Language copyWith({Locale? locale, int? selectedLang}) {
    return Language(
        locale: locale ?? this.locale,
        selectedLang: selectedLang ?? this.selectedLang);
  }
}
