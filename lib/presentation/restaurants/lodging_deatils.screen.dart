import 'package:auto_route/annotations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/lodging.provider.dart';
import 'package:xplore_bg_v2/presentation/location/location.screen.dart';
import 'package:xplore_bg_v2/presentation/shared/location/review_card.widget.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class LodgingDetailsScreen extends HookConsumerWidget {
  final GMapsPlaceModel lodging;
  final String id;
  final String heroTag;

  const LodgingDetailsScreen({
    Key? key,
    @PathParam() required this.id,
    required this.lodging,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final details = ref.watch(lodgingDetailsProvider(restaurant.id));

    final scrollController = useScrollController();

    return LocationDetailsScreen(
      scrollController: scrollController,
      location: lodging,
      heroTag: heroTag,
      slivers: [
        SliverToBoxAdapter(
          child: LocationGallerySection(locationId: id),
        ),
        SliverToBoxAdapter(
          child: _DetailSection(id),
        ),
        SliverToBoxAdapter(
          child: _ReviewSection(id),
        ),
      ],
    );
  }
}

class _DetailSection extends ConsumerWidget {
  const _DetailSection(this.locId, {Key? key}) : super(key: key);
  final String locId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(gmapsPlaceDetailsProvider(locId));
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
          listTileTheme: theme.listTileTheme.copyWith(
        tileColor: Colors.transparent,
      )),
      child: SectionWithTitleWidget(
        title: SectionTitleWithDividerWidget(LocaleKeys.section_description.tr()),
        child: details.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          data: (data) {
            final infoList = _infoList(data);
            return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: infoList.length + 2,
              itemBuilder: (_, index) {
                final _index = index - 1;
                if (index == 0) return const Divider();
                if (_index == infoList.length) return const Divider();
                return infoList[_index];
              },
              separatorBuilder: (_, index) {
                if (index == 0) return const SizedBox.shrink();
                if (index == infoList.length) return const SizedBox.shrink();
                return const Divider();
              },
            );
          },
          error: (e, stk) => Text(e.toString()),
        ),
      ),
    );
  }

  List<Widget> _infoList(GMapsPlaceModel data) {
    return [
      // add location details ?
      if (data.residence != null && data.residence!.isNotEmpty)
        ListTile(
          title: Text(data.residence!),
          leading: const Icon(Icons.location_pin),
          onTap: () {},
        ),

      // add place phone number
      if (data.phoneNumber != null && data.phoneNumber!.isNotEmpty)
        ListTile(
          title: Text(data.phoneNumber!),
          leading: const Icon(Icons.phone),
          onTap: () {},
        ),

      // add place website
      if (data.website != null && data.website!.isNotEmpty)
        ListTile(
          title: Text(
            data.website!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          leading: const Icon(Icons.language_sharp),
          onTap: () {},
        ),

      if (data.openingHours != null && data.openingHours!.isNotEmpty)
        ExpansionTile(
          title: const Text(LocaleKeys.opening_hours).tr(),
          leading: const Icon(Icons.access_time),
          children: data.openingHours!.map<Widget>((day) {
            final parts = day.split(':');
            final dayOfWeek = parts[0].trim();
            final openInterval = parts.sublist(1).join(':').trim();

            return ListTile(
              title: Text(dayOfWeek),
              subtitle: Text(openInterval),
              leading: const Icon(Icons.share_arrival_time),
            );
          }).toList(),
        ),
    ];
  }
}

class _ReviewSection extends ConsumerWidget {
  const _ReviewSection(this.locId, {Key? key}) : super(key: key);
  final String locId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(gmapsPlaceDetailsProvider(locId));

    return SectionWithTitleWidget(
      title: SectionTitleWithDividerWidget(LocaleKeys.reviews.tr()),
      child: details.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (data) {
          if (data.reviews == null || data.reviews!.isEmpty) {
            return const SizedBox(
              width: double.infinity,
              height: 150,
              child: Center(child: Text("No reviews")),
            );
          }
          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.reviews!.length,
            itemBuilder: ((_, index) {
              final review = data.reviews![index];
              return ReviewCardWidget(review: review, showRelativeTime: true);
            }),
            separatorBuilder: (_, __) => const Divider(),
          );
        },
        error: (e, stk) => Center(child: Text(e.toString())),
      ),
    );
  }
}
