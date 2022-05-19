import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/utils.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/profile_edit.provider.dart';
import 'widgets/user_avatar.widget.dart';

class EditUserProfileScreen extends HookConsumerWidget {
  const EditUserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);
    final formKey = ref.watch(userFormKeyProvider);
    final textController = ref.watch(userNameTextControllerProvider);

    textController.text = user!.fullName;

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitleWidget(
            title: LocaleKeys.edit_profile.tr(),
            leading: AppbarActionWidget(
              iconData: Icons.arrow_back,
              buttonSize: 42,
              onTap: () => context.router.pop(),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const UserAvatarWidget(),
                const SizedBox(height: 32),
                TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    labelText: LocaleKeys.user_lbl.tr(),
                    hintText: LocaleKeys.enter_new_name.tr(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.enter_new_name_epmty.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 45,
                  ),
                  child: ElevatedButton(
                    child: Text(tr(LocaleKeys.update_profile).toUpperCase()),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: theme.primaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        _handleProfileUpdate(
                          ref,
                          onSuccess: () {
                            SnackbarUtils.showSnackBar(
                              context,
                              message: LocaleKeys.update_profile_success.tr(),
                              snackBarType: SnackBarType.success,
                            );
                            context.router.pop();
                          },
                          onError: (e) {
                            SnackbarUtils.showSnackBar(
                              context,
                              message: e.toString(),
                              snackBarType: SnackBarType.error,
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleProfileUpdate(
    WidgetRef ref, {
    VoidCallback? onSuccess,
    void Function(Object e)? onError,
  }) async {
    final user = ref.read(authControllerProvider);
    final name = ref.read(userNameTextControllerProvider).text;
    final firestore = ref.read(firebaseFirestoreProvider);

    try {
      if (user!.fullName != name) {
        ref.read(authControllerProvider.notifier).state = user.copyWith(fullName: name);
        await firestore.collection("users").doc(user.uid).update({'full_name': name});
        onSuccess?.call();
      }
    } catch (e) {
      onError?.call(e);
    }
  }
}
