import 'package:flutter/material.dart';

class AppSafeArea extends StatelessWidget {
  final Widget child;
  const AppSafeArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      left: false,
      right: false,
      maintainBottomViewPadding: true,
      child: child,
    );
  }
}
