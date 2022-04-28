import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class AuthChecherScreen extends ConsumerWidget {
  const AuthChecherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    return auth.when(
      data: (user) {
        return AutoRouter.declarative(
          routes: (ctx) {
            return [
              if (user != null) const HomeRoute() else const SigninRoute(),
            ];
          },
        );
      },
      error: (err, stack) => BlankPage(
        heading: "Error",
        shortText: err.toString(),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
