import 'package:flutter/material.dart';

class KeyboardAware extends StatelessWidget {
  final Widget? child;
  const KeyboardAware({super.key, this.child});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: child,
    );
  }
}
