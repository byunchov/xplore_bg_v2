import 'package:auto_route/auto_route.dart';
import 'package:xplore_bg_v2/infrastructure/routing/auth.service.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';

class AuthGuard extends AutoRedirectGuard {
  final AuthService authService;

  AuthGuard(this.authService) {
    authService.addListener(() {
      if (!authService.isAuthenticated) {
        // should be called when the logic effecting this guard changes
        // e.g when the user is no longer authenticated
        reevaluate();
      }
    });
  }

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (authService.isAuthenticated) return redirect(const HomeRoute(), resolver: resolver);
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
