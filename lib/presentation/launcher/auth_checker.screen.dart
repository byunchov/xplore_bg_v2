import 'package:flutter/material.dart';

class AuthCheckerScreen extends StatelessWidget {
  const AuthCheckerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SizedBox.square(
        dimension: 64,
        child: CircularProgressIndicator(),
      )),
    );
  }
}

/* 
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
                SnackbarUtils.showSnackBar(context, message: "Welcome. ${usr.fullName}");
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
 */