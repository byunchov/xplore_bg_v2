import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/review.repository.dart';

final reviewFormKeyProvider = Provider.autoDispose.family<GlobalKey<FormState>, String>((ref, id) {
  return GlobalKey<FormState>();
});

final reviewTextControllerProvider =
    Provider.autoDispose.family<TextEditingController, String>((ref, id) {
  ref.onDispose(() => ref.state.dispose());
  return TextEditingController();
});

final reviewRatingValueProvider = StateProvider.autoDispose.family<double, String>((ref, id) {
  return 0;
});

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(ref.read);
});
