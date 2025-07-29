import 'package:flutter/material.dart';

import '../../domain/api_models/user_model.dart';

class AppData {
  static final AppData instance = AppData._internal();
  AppData._internal();
  String? _token;
  UserModel? _user;
  Locale? _locale;

  String? get token => _token;
  UserModel? get user => _user;
  Locale? get locale => _locale;

  setUser(UserModel? user) {
    _user = user;
  }

  setToken(String? token) {
    _token = token;
  }

  setLocale(Locale locale) {
    _locale = locale;
  }
}
