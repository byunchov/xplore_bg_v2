import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:line_icons/line_icons.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/infrastructure/theme/apptheme.provider.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.menu_user_profile.tr(),
          actions: [
            AppbarActionWidget(
              iconData: user.isAuthenticated ? Icons.logout : Icons.login,
              buttonSize: 42,
              onTap: () {
                if (user.isAuthenticated) {
                  ref.read(authControllerProvider.notifier).signOut();
                } else {
                  context.router.navigate(SigninRoute(onSignInCallback: (_) {}));
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: const [
              _UserProfileSection(),
              _UserSettingSection(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserSettingSection extends StatelessWidget {
  const _UserSettingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.general_settings.tr()),
      child: Column(
        children: [
          const _DarkModeSwitch(),
          _SettingsListTile(
            title: LocaleKeys.select_lang.tr(),
            iconData: Icons.language,
            iconColor: Colors.purple,
            onPressed: () {
              context.router.navigate(const ChooseLanguageRoute());
            },
          ),
          // const Divider(),
          _SettingsListTile(
            title: LocaleKeys.feedback.tr(),
            iconData: Icons.email,
            iconColor: Colors.redAccent,
          ),
        ],
      ),
    );
  }
}

class _SettingsListTile extends StatelessWidget {
  final String title;
  final double iconSize;
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color iconColor;
  const _SettingsListTile({
    Key? key,
    required this.title,
    this.iconSize = 30,
    required this.iconData,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Container(
        height: iconSize,
        width: iconSize,
        decoration: BoxDecoration(
          color: iconColor,
          borderRadius: BorderRadius.circular(iconSize * 0.2),
        ),
        child: Icon(
          iconData,
          size: iconSize * 0.65,
          color: Colors.white,
        ),
      ),
      trailing: Icon(Icons.chevron_right, size: iconSize * 0.65),
      onTap: onPressed,
    );
  }
}

class _UserProfileSection extends ConsumerWidget {
  const _UserProfileSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider.notifier);

    if (user.isAuthenticated) {
      return const _UserLoggedInWidget();
    }
    return const _UserNotLoggedInWidget();
  }
}

class _UserLoggedInWidget extends ConsumerWidget {
  const _UserLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 32),
        const _UserAvatarWidget(),
        const SizedBox(height: 32),
        Text(
          user!.fullName,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          user.email,
          textAlign: TextAlign.center,
          maxLines: 1,
          style: theme.textTheme.subtitle1?.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 32),
        const _UserNotedStatsWidget(),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _UserNotLoggedInWidget extends ConsumerWidget {
  const _UserNotLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: BlankPage(
        icon: Icons.login_rounded,
        iconPadding: const EdgeInsets.only(bottom: 6),
        iconSize: 102,
        heading: LocaleKeys.not_signed_in.tr(),
        shortText: LocaleKeys.not_signed_in_desc.tr(),
        customAction: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton.icon(
            onPressed: () {
              context.router.navigate(SigninRoute(onSignInCallback: (user) {
                log(user.toString());
              }));
            },
            icon: const Icon(Icons.login),
            label: Text(LocaleKeys.signin_btn.tr()),
          ),
        ),
      ),
    );
  }
}

class _UserAvatarWidget extends ConsumerWidget {
  const _UserAvatarWidget({
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

class _DarkModeSwitch extends ConsumerWidget {
  const _DarkModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeEnabled = ref.watch(appThemeProvider);
    final provider = ref.watch(appThemeProvider.notifier);

    return SwitchListTile(
      value: darkModeEnabled,
      onChanged: (value) {
        provider.setThemeMode(value);
      },
      title: const Text("Toggle dark mode"),
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

    return StreamBuilder<DocumentSnapshot>(
      stream: firestore.doc("users/$id").snapshots(),
      builder: (context, snap) {
        if (!snap.hasData) return const Text('--');
        // final snapshot = snap.data as DocumentSnapshot<Map<String, dynamic>>;
        final data = snap.data;
        final count = data?[field];
        return Text(count.toString(), style: textStyle);
      },
    );
  }
}

class _UserNotedStatsWidget extends ConsumerWidget {
  const _UserNotedStatsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    final user = ref.watch(authControllerProvider);

    return Container(
      width: size.width * 0.88,
      height: 115,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: theme.listTileTheme.tileColor,
        // color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 10,
            offset: const Offset(0, 10), // changes position of shadow
          ),
        ],
      ),
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
              context.router
                  .navigate(const NotedLocationsRouter(children: [LikedLocationsRoute()]));
            },
          ),
          _UserStatItemWidget(
            id: user.uid,
            field: "bookmark_count",
            title: LocaleKeys.bookmarks.tr(),
            icon: Icons.bookmark,
            iconColor: Colors.lightBlue,
            onPressed: () {
              context.router
                  .navigate(const NotedLocationsRouter(children: [BookmarkedLocationsRoute()]));
            },
          ),
        ],
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
  const _UserStatItemWidget({
    Key? key,
    required this.id,
    required this.field,
    required this.title,
    required this.icon,
    required this.iconColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconColor.shade200,
              borderRadius: BorderRadius.circular(6),
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
