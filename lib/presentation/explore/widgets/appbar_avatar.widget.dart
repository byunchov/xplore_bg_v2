import 'package:flutter/material.dart';
import 'package:xplore_bg_v2/domain/core/constants/widget.constants.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class AppbarAvatarIcon extends StatelessWidget {
  final double iconRadius;
  final String profilePic;
  final VoidCallback onTap;

  const AppbarAvatarIcon({
    Key? key,
    this.iconRadius = WidgetConstants.kAppbarAvatarRadius,
    required this.onTap,
    required this.profilePic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: CircleAvatar(
        radius: iconRadius,
        child: ClipOval(
          child: CustomCachedImage(imageUrl: profilePic),
        ),
      ),
    );
  }
}
