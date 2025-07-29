import 'package:flutter/material.dart';

class AppBottomPadding extends StatelessWidget {
  final Widget child;
  const AppBottomPadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.only(bottom: 20),
      child: child,
    );
  }
}
