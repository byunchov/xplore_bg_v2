import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';
import 'package:xplore_bg_v2/models/models.dart';

final categoriesProvider = FutureProvider<List<CategoryModel>>((ref) async {
  final lang = ref.watch(appLocaleProvider).languageCode;
  final firestore = ref.read(firebaseFirestoreProvider);

  final query = await firestore.collection("categories").get();

  return query.docs.map((e) => CategoryModel.fromSnapshot(e, locale: lang)).toList();
});
