import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class ReviewSectionWidget extends ConsumerWidget {
  const ReviewSectionWidget(this.locId, {Key? key}) : super(key: key);
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
            // separatorBuilder: (_, __) => const Divider(),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
        },
        error: (e, stk) => Center(child: Text(e.toString())),
      ),
    );
  }
}
