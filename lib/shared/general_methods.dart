import 'package:flutter/material.dart';

bool isNotNull(var value) => value != null ? true : false;
bool isNull(var value) => value == null ? true : false;
bool isMoreThanZero(num value) => value > 0 ? true : false;
bool isEqualToZero(num value) => value == 0 ? true : false;
bool isMoreOrEqualZero(num value) => value >= 0 ? true : false;

void onWidgetDidBuild(VoidCallback callback) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    callback();
  });
}