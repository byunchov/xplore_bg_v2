import 'package:flutter/material.dart';

abstract class IconStyle {
  final Icon regular;
  final Icon bold;
  static const double iconSize = 26;

  IconStyle(
    this.regular,
    this.bold,
  );

  @override
  String toString() => 'IconStyle(regular: $regular, bold: $bold)';
}

/* class BookmarkIcon implements IconStyle {
  @override
  Icon bold = const Icon(Icons.bookmark, size: IconStyle.iconSize, color: Colors.blue);

  @override
  Icon regular = const Icon(Icons.bookmark_outline, size: IconStyle.iconSize);
} */

class BookmarkIcon implements IconStyle {
  late Icon _regular;
  late Icon _bold;

  BookmarkIcon({Color? colorBold}) {
    _bold = Icon(Icons.bookmark, size: IconStyle.iconSize, color: colorBold ?? Colors.blue);
    _regular = const Icon(Icons.bookmark_outline, size: IconStyle.iconSize);
  }

  @override
  Icon get bold => _bold;

  @override
  Icon get regular => _regular;
}

class LikeIcon implements IconStyle {
  late Icon _regular;
  late Icon _bold;

  LikeIcon({Color? colorBold}) {
    _bold = Icon(Icons.favorite, size: IconStyle.iconSize, color: colorBold ?? Colors.red);
    _regular = const Icon(Icons.favorite_border, size: IconStyle.iconSize);
  }

  @override
  Icon get bold => _bold;

  @override
  Icon get regular => _regular;
}
