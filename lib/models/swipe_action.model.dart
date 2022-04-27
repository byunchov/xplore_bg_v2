import 'package:flutter/widgets.dart';

class SwipeActionModel {
  final Widget child;
  final VoidCallback? onTap;

  const SwipeActionModel({required this.child, this.onTap});
}
