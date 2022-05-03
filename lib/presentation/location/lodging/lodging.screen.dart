import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/google_maps.util.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/place.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class LodgingScreen extends ConsumerWidget {
  final String locId;
  const LodgingScreen(this.locId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.read(placeDetailsProvider(locId)).value!;

    final pageName = LocaleKeys.tag_hotel.tr();

    return GMapsLisitngWidget(
      locId: LocationIdentifierModel(id: locId, type: GMapsPlaceType.lodging),
      heading: "$pageName - ${location.name}",
    );
  }
}
