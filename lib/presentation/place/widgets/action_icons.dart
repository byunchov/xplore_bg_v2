import 'package:flutter/material.dart';

abstract class IconStyle {
  Icon regular;
  Icon bold;
  static const double iconSize = 26;

  IconStyle(
    this.regular,
    this.bold,
  );

  @override
  String toString() => 'IconStyle(regular: $regular, bold: $bold)';
}

class BookmarkIcon implements IconStyle {
  @override
  Icon bold = const Icon(Icons.bookmark, size: IconStyle.iconSize, color: Colors.blue);

  @override
  Icon regular = const Icon(Icons.bookmark_outline, size: IconStyle.iconSize);
}

class LikeIcon implements IconStyle {
  @override
  Icon bold = const Icon(Icons.favorite, size: IconStyle.iconSize, color: Colors.red);

  @override
  Icon regular = const Icon(Icons.favorite_border, size: IconStyle.iconSize);
}
