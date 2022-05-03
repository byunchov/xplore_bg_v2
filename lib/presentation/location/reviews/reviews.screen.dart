import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/place_reviews.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceReviewsScreen extends StatelessWidget {
  final String id;
  const PlaceReviewsScreen({
    Key? key,
    @PathParam() required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.reviews.tr(),
          leading: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            onTap: () {
              context.router.pop();
            },
          ),
        ),
      ),
      // body: MultiSliver(children: [
      //   SliverPinnedHeader(child: _ReviewHeaderSection(id)),
      //   _ReviewHeaderSection(id),
      // ]),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          // SliverPinnedHeader(child: _ReviewHeaderSection(id)),
          SliverToBoxAdapter(
            child: _ReviewHeaderSection(id),
          ),
        ],
        body: _ReviewListSection(id),
      ),
      // body: CustomScrollView(
      //   slivers: [
      //     SliverToBoxAdapter(
      //       child: _ReviewHeaderSection(id),
      //     ),
      //     SliverFillRemaining(child: _ReviewListSection(id)),
      //   ],
      // ),
    );
  }
}

class _ReviewHeaderSection extends ConsumerWidget {
  final String id;
  const _ReviewHeaderSection(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider.notifier);
    if (user.isAuthenticated) {
      return _CurrentUserReviewSection(id);
    }
    return BlankPage(
      heading: LocaleKeys.not_signed_in.tr(),
      shortText: LocaleKeys.not_signed_in_desc.tr(),
    );
  }
}

class _CurrentUserReviewSection extends ConsumerWidget {
  final String id;
  const _CurrentUserReviewSection(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final review = ref.watch(placeUserReviewProvider(id));
    return review.when(
      data: (data) {
        if (data == null) {
          return const _AddUserReviewSection();
        }

        return ReviewCardWidget(review: data);
      },
      error: (error, stk) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _AddUserReviewSection extends ConsumerWidget {
  const _AddUserReviewSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      color: theme.listTileTheme.tileColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.add_review_h,
            style: theme.textTheme.headline5,
          ).tr(),
          const SizedBox(height: 5),
          Text(
            LocaleKeys.add_review_hint,
            style: theme.textTheme.subtitle2,
          ).tr(),
          const SizedBox(height: 20),
          Row(
            children: [
              ClipOval(
                child: SizedBox.square(
                  dimension: 60,
                  child: CustomCachedImage(
                    imageUrl: user!.photoURL!,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: false,
                glowColor: Colors.amber[300],
                itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                itemSize: 36,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewListSection extends ConsumerWidget {
  final String id;
  const _ReviewListSection(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PaginatedListViewWidget<ReviewModel>(
      provider: placeReiewListProvider(id),
      builder: (review) => ReviewCardWidget(review: review),
      loadingPlaceholder: const Center(child: CircularProgressIndicator()),
      emptyResultPlaceholder: BlankPage(
        icon: Icons.rate_review_rounded,
        heading: tr(LocaleKeys.no_reviews),
        shortText: tr(LocaleKeys.no_reviews_desc),
      ),
    );
  }
}
