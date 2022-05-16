import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class UserNotLoggedInWidget extends ConsumerWidget {
  const UserNotLoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: BlankPage(
        icon: Icons.login_rounded,
        iconPadding: const EdgeInsets.only(bottom: 6),
        iconSize: size.width * 0.215,
        heading: LocaleKeys.not_signed_in.tr(),
        shortText: LocaleKeys.not_signed_in_desc.tr(),
        customAction: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ElevatedButton.icon(
            onPressed: () {
              context.router.push(SigninRoute());
            },
            icon: const Icon(Icons.login),
            label: Text(LocaleKeys.signin_btn.tr()),
          ),
        ),
      ),
    );
  }
}
