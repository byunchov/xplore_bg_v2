import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
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
    final user = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 70,
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        automaticallyImplyLeading: false,

        title: AppbarTitleWidget(
          title: tr("menu_user_profile"),
          actions: [
            AppbarActionWidget(
              iconData: user != null ? Icons.logout : Icons.login,
              buttonSize: 42,
              onTap: () {
                if (user != null) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(height: 32),
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 170,
                      height: 170,
                      decoration: ShapeDecoration(
                        shape: const CircleBorder(
                          side: BorderSide(width: 6, color: Colors.grey),
                          // borderRadius: BorderRadius.circular(200),
                        ),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              user?.photoURL ?? AppConfig.defaultProfilePic),
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
              ),
              const SizedBox(height: 32),
              Text(
                // "Божидар Иванов Юнчов",
                user?.displayName ?? "Божидар Иванов Юнчов",
                textAlign: TextAlign.center,
                maxLines: 2,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user?.email ?? "bozhidar.yunchov@mail.bg",
                textAlign: TextAlign.center,
                maxLines: 1,
                style: theme.textTheme.subtitle1?.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 32),
              Container(
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
                    _userStatsWidget(
                      context,
                      title: tr("favourites"),
                      subtitle: "154",
                      iconData: LineIcons.heartAlt,
                      iconColor: Colors.red,
                    ),
                    _userStatsWidget(
                      context,
                      title: tr("menu_bookmarks"),
                      subtitle: "34",
                      iconData: Icons.bookmark,
                      iconColor: Colors.lightBlue,
                    ),
                    // _userStatsWidget(
                    //   context,
                    //   title: "Visited",
                    //   subtitle: "154",
                    //   iconData: LineIcons.flagAlt,
                    //   iconColor: Colors.amber,
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const ListTile(
                title: Text("Toggle dark mode"),
                trailing: DarkModeSwitch(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _userStatsWidget(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData iconData,
    required MaterialColor iconColor,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          // padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            // color: Colors.red[200],
            color: iconColor.shade200,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Icon(
              iconData,
              // color: Colors.red[800],
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
            Text(
              subtitle,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ],
    );
  }
}

class DarkModeSwitch extends ConsumerWidget {
  const DarkModeSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final darkModeEnabled = ref.watch(appThemeProvider);
    final provider = ref.watch(appThemeProvider.notifier);

    return Switch(
      value: darkModeEnabled,
      onChanged: (value) {
        provider.setThemeMode(value);
      },
    );
  }
}
