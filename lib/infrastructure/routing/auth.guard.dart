import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';

class AuthGuard extends AutoRedirectGuard {
  final Ref ref;

  AuthGuard(this.ref) {
    final authController = ref.watch(authControllerProvider.notifier);

    authController.addListener((user) {
      if (!authController.isAuthenticated || !authController.isGuest) {
        reevaluate();
      }
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authController = ref.watch(authControllerProvider.notifier);

    if (authController.isAuthenticated || authController.isGuest) {
      resolver.next();
      return;
    }

    router.push(
      SigninRoute(
        onSignInCallback: (_) {
          resolver.next();
          router.removeLast();
        },
      ),
    );
  }
}
