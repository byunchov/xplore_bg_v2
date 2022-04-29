import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/search/search.repository.dart';
import 'package:xplore_bg_v2/models/models.dart';

final placeDetailsProvider = FutureProvider.autoDispose.family<PlaceModel?, String>(
  (ref, id) async {
    final searchRepo = ref.read(searcRepositoryProvider);
    final document = await searchRepo.getDocument("locations", "bg_$id");

    if (document != null) {
      return PlaceModel.formJson(document);
    }

    return null;
  },
);
