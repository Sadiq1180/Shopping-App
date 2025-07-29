import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigator_key.dart';

class Navigation {
  static pushNamed(String routeName,
          {bool rootNavigator = false, Object? args}) =>
      appContext.pushNamed(routeName, extra: args);

  static pushReplacementNamed(String routeName,
          {bool rootNavigator = false, Object? args}) =>
          appContext.replaceNamed(routeName,extra: args);
      // Navigator.of(appContext, rootNavigator: rootNavigator)
      //     .pushReplacementNamed(routeName, arguments: arguments);

  static pushNamedAndRemoveUntil(String routeName,
      {bool rootNavigator = false, Object? args}) {
    while (appContext.canPop() == true) {
      appContext.pop();
    }
    appContext.replaceNamed(routeName, extra: args);
  }

  static pop({bool rootNavigator = false, int delay = 0}) => Timer(
      Duration(milliseconds: delay),
      () => Navigator.of(appContext, rootNavigator: rootNavigator).pop());

  static String currentScreen() {
    // return ModalRoute.of(appContext)?.settings.name ?? '';
    return '';
    //  return Router.of(appContext).routeInformationProvider?.value.location??'';
  }
}
