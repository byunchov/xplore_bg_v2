import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class AuthCheckerScreen extends ConsumerWidget {
  const AuthCheckerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

    return Scaffold(
      body: auth.when(
        data: (user) {
          if (user != null) {
            context.router.pushAndPopUntil(const HomeRoute(), predicate: (_) => true);
          } else {
            context.router.pushAndPopUntil(SigninRoute(
              onSignInCallback: (usr) {
                SnackbarUtils.showSnackBar(context, message: "Welcome. ${usr.displayName}");
              },
            ), predicate: (_) => true);
          }
          return null;
        },
        error: (err, stack) => BlankPage(
          heading: "Error",
          shortText: err.toString(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
