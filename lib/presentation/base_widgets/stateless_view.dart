import 'package:flutter/material.dart';

abstract class StatelessView<T1> extends StatelessWidget {
  final T1 widget;
  const StatelessView(this.widget, {super.key});
  
  @override
  Widget build(BuildContext context);
}