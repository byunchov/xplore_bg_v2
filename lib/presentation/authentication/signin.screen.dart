import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/authentication/repositories/auth.repository.dart';
import 'package:xplore_bg_v2/presentation/screens.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final authCOntrolerState = ref.watch(authControllerProvider);

    ref.listen<User?>(
      authControllerProvider,
      (previous, next) {
        print(previous?.displayName);
        print(next?.displayName);
        if (next != null) {
          pushReplacement(context, const HomeScreen());
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {},
          ),
          if (authCOntrolerState != null)
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
                    "welcome_to",
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.1,
                    ),
                  ).tr(),
                  const SizedBox(height: 5),
                  Text(
                    "app_title",
                    style: theme.textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ).tr(),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'welcome_msg',
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
                    text: tr("signin_google"),
                    icon: FontAwesome.google,
                    color: Colors.lightBlue,
                    onPressed: () async {
                      try {
                        // final user = await signInWithGoogle();
                        final user = await ref.read(authRepositoryProvider).signInWithGoogle();
                        debugPrint(user?.email);
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  SigninActionButton(
                    text: tr("signin_facebook"),
                    icon: FontAwesome.facebook_f,
                    color: const Color(0xFF4267B2),
                    onPressed: () async {
                      // await Future.delayed(const Duration(seconds: 2));
                      try {
                        // final user = await signInWithFacebook();
                        final user = await ref.read(authRepositoryProvider).signInWithFacebook();
                        debugPrint(user?.email);
                      } catch (e) {
                        debugPrint(e.toString());
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

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}

class SigninActionButton extends StatefulWidget {
  final double btnHeight;
  final Color color;
  final String text;
  final IconData icon;
  final AsyncCallback onPressed;

  const SigninActionButton({
    Key? key,
    this.btnHeight = 50.0,
    required this.text,
    required this.icon,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<SigninActionButton> createState() => _SigninActionButtonState();
}

class _SigninActionButtonState extends State<SigninActionButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ElevatedButton(
      child: Visibility(
        visible: !_isLoading,
        replacement: Center(
          child: SizedBox.square(
            dimension: widget.btnHeight * 0.55,
            child: CircularProgressIndicator.adaptive(
              // backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon),
            CustomDivider(
              height: widget.btnHeight * 0.36,
              width: 1,
              color: Colors.grey[350],
              margin: const EdgeInsets.symmetric(horizontal: 12),
            ),
            Text(widget.text),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 3,
        fixedSize: Size(double.infinity, widget.btnHeight),
        primary: widget.color,
        onSurface: widget.color,
      ),
      onPressed: _isLoading
          ? null
          : () async {
              setState(() => _isLoading = true);
              await widget.onPressed();
              setState(() => _isLoading = false);
            },
    );
  }
}
