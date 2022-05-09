import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/featured_card.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/loading_featured_card.widget.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/place.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class FeauturedSectionWidget extends ConsumerWidget {
  const FeauturedSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return SectionWithTitleWidget(
      title: Text(
        LocaleKeys.feautured_places.tr(),
        style: theme.textTheme.titleLarge,
      ),
      child: SizedBox(
        height: 296,
        width: size.width,
        child: ref.watch(featurePlacesProvider).when(
              data: (data) {
                if (data.isEmpty) return BlankPage(heading: LocaleKeys.no_places_found.tr());

                return CarouselSliderWidget(
                  autoPlay: false,
                  showIndicator: true,
                  viewportFraction: 0.9,
                  children: data
                      .map((e) => ProviderScope(
                            overrides: [
                              placeProvider(e.id).overrideWithValue(StateController(e)),
                            ],
                            child: FeaturedCardWidget(place: e),
                          ))
                      .toList(),
                );
              },
              error: (err, stack) => Text("Error: $err"),
              loading: () => const FeaturedLoadingCardWidget(),
            ),
      ),
    );
  }
}
