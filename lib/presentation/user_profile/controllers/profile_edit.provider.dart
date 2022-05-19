import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userFormKeyProvider = Provider.autoDispose<GlobalKey<FormState>>((ref) {
  return GlobalKey<FormState>();
});

final userNameTextControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  ref.onDispose(() => ref.state.dispose());
  return TextEditingController();
});
