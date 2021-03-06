import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/authentication/repositories/auth.repository.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({
    Key? key,
    this.onSignInCallback,
  }) : super(key: key);

  final void Function(UserModel? user)? onSignInCallback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final auth = ref.watch(authControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            print(context.router.stackData.length);
            if (!auth.isAuthenticated && !auth.isGuest) {
              auth.siginGuest();
            }

            context.router.pop();
            if (context.router.stackData.length < 2) {
              context.router.replaceAll([const HomeRoute()]);
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () => context.router.navigate(const ChooseLanguageRoute()),
          ),
          if (auth.isAuthenticated)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                ref.read(authControllerProvider.notifier).signOut();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.welcome_to,
                    // style: theme.textTheme.titleLarge?.copyWith(
                    style: theme.textTheme.headline6?.copyWith(
                      // fontSize: 21,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                      color: theme.textTheme.headlineLarge?.color,
                    ),
                  ).tr(),
                  const SizedBox(height: 5),
                  Text(
                    LocaleKeys.app_title,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      // fontSize: 36,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ).tr(),
                ],
              ),
            ),
            if (size.height >= 540)
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomDivider(
                        width: size.width * 0.55,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 25),
                      ),
                      Text(
                        LocaleKeys.welcome_msg,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: 19,
                          fontWeight: FontWeight.w400,
                        ),
                      ).tr(),
                      CustomDivider(
                        width: size.width * 0.55,
                        height: 4,
                        margin: const EdgeInsets.only(top: 25),
                      ),
                    ],
                  ),
                ),
              ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SigninActionButton(
                    text: LocaleKeys.signin_google.tr(),
                    icon: FontAwesome.google,
                    color: Colors.lightBlue,
                    onPressed: () async {
                      try {
                        final user = await ref.read(authRepositoryProvider).signInWithGoogle();
                        onSignInCallback != null
                            ? onSignInCallback!.call(user)
                            : _defaultOnSigingCallback(context, user);
                      } on Failure catch (e) {
                        SnackbarUtils.showSnackBar(context, message: e.message.tr());
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  SigninActionButton(
                    text: LocaleKeys.signin_facebook.tr(),
                    icon: FontAwesome.facebook_f,
                    color: const Color(0xFF4267B2),
                    onPressed: () async {
                      try {
                        final user = await ref.read(authRepositoryProvider).signInWithFacebook();
                        onSignInCallback != null
                            ? onSignInCallback!.call(user)
                            : _defaultOnSigingCallback(context, user);
                      } on Failure catch (e) {
                        SnackbarUtils.showSnackBar(context, message: e.message.tr());
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.03)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _defaultOnSigingCallback(BuildContext context, UserModel? user) {
    SnackbarUtils.showSnackBar(
      context,
      message: LocaleKeys.signin_user_msg.tr(namedArgs: {'name': user!.fullName}),
      snackBarType: SnackBarType.success,
    );
    context.router.pop();
  }
}
