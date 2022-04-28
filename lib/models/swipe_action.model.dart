import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class SwipeActionModel {
  final Widget child;
  final AsyncCallback? onTap;

  const SwipeActionModel({required this.child, this.onTap});
}
