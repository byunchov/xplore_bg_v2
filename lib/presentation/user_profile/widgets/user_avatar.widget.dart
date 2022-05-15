import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

class UserAvatarWidget extends ConsumerWidget {
  const UserAvatarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 170,
            height: 170,
            decoration: ShapeDecoration(
              shape: const CircleBorder(
                side: BorderSide(width: 6, color: Colors.grey),
              ),
              image: DecorationImage(
                image:
                    CachedNetworkImageProvider(user?.profileImage ?? AppConfig.defaultProfilePic),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              splashRadius: 30,
              icon: Container(
                width: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[200],
                ),
                child: Center(
                    child: Icon(
                  LineIcons.pen,
                  color: Colors.grey[800],
                )),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
