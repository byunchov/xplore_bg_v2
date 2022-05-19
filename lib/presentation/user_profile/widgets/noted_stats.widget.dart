import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class UserNotedStatsWidget extends ConsumerWidget {
  const UserNotedStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final user = ref.watch(authControllerProvider);

    return Material(
      color: theme.listTileTheme.tileColor,
      child: SizedBox(
        width: size.width,
        height: 120,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _UserStatItemWidget(
              id: user!.uid,
              field: "like_count",
              title: LocaleKeys.favourites.tr(),
              icon: LineIcons.heartAlt,
              iconColor: Colors.red,
              onPressed: () {
                context.router.navigate(const HomeRoute(children: [
                  NotedLocationsRouter(children: [LikedLocationsRoute()])
                ]));
              },
            ),
            _UserStatItemWidget(
              id: user.uid,
              field: "bookmark_count",
              title: LocaleKeys.bookmarks.tr(),
              icon: Icons.bookmark,
              iconColor: Colors.lightBlue,
              onPressed: () {
                context.router.navigate(const HomeRoute(children: [
                  NotedLocationsRouter(children: [BookmarkedLocationsRoute()])
                ]));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UserStatItemWidget extends StatelessWidget {
  final String id;
  final String field;
  final String title;
  final IconData icon;
  final MaterialColor iconColor;
  final VoidCallback? onPressed;
  final double iconRadius;

  const _UserStatItemWidget({
    Key? key,
    required this.id,
    required this.field,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.onPressed,
    this.iconRadius = 6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(iconRadius),
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.shade200,
              borderRadius: BorderRadius.circular(iconRadius),
            ),
            child: Center(
              child: Icon(
                icon,
                color: iconColor.shade800,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.labelLarge,
              ),
              const SizedBox(height: 5),
              _UserNotedStatsText(
                id: id,
                field: field,
                textStyle: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserNotedStatsText extends StatelessWidget {
  final String id;
  final String field;
  final TextStyle? textStyle;

  const _UserNotedStatsText({
    Key? key,
    required this.id,
    required this.field,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    try {
      return StreamBuilder<DocumentSnapshot>(
        stream: firestore.doc("users/$id").snapshots(),
        builder: (context, snap) {
          if (!snap.hasData) return const Text('--');
          if (snap.hasError) return const SizedBox.shrink();
          final data = snap.data;
          final count = data?[field];
          return Text(count.toString(), style: textStyle);
        },
      );
    } catch (e) {
      return const SizedBox.shrink();
    }
  }
}
