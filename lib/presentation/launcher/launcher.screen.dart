import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';

class LauncherScreen extends ConsumerWidget {
  const LauncherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);

    ref.listen<User?>(
      authControllerProvider,
      (previous, next) {
        print(previous?.displayName);
        print(next?.displayName);
        if (next == null) {
          pushReplacement(context, const SignInScreen());
        } else {
          pushReplacement(context, const HomeScreen());
        }
      },
    );

    return const SignInScreen();

    // return Scaffold(
    //   body: Center(
    //     child: Column(
    //       children: [
    //         CircularProgressIndicator.adaptive(
    //           backgroundColor: Colors.white,
    //           valueColor: AlwaysStoppedAnimation(theme.primaryColor),
    //         ),
    //         Text(user?.uid ?? "none"),
    //       ],
    //     ),
    //   ),
    // );
  }
}

pushReplacement(BuildContext context, Widget destination) {
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => destination));
}
