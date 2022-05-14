import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/explore/controllers/explore.controller.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/featured_section.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/main_appbar.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/nearby_section.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/search_secton.widget.dart';
import 'package:xplore_bg_v2/presentation/explore/widgets/searchbox_appbar.widget.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxScrolled) {
            return const [
              MainAppBarWidget(),
              SearchBoxAppBarWidget(),
            ];
          },
          body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(featurePlacesProvider);
              ref.refresh(locationsNearbyProvider);
              ref.refresh(locationSortProvider);
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  FeauturedSectionWidget(),
                  NearbySectionWidget(),
                  SortableSectionWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
