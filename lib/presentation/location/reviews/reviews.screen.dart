import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/dialog.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/infrastructure/routing/router.gr.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/add_review.provider.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/place_reviews.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class PlaceReviewsScreen extends ConsumerWidget {
  final String locId;
  const PlaceReviewsScreen({
    Key? key,
    @PathParam('id') required this.locId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: LocaleKeys.reviews.tr(),
          leading: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            onTap: () => context.router.pop(),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(placeReiewListProvider(locId));
          ref.refresh(placeUserReviewProvider(locId));
        },
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverToBoxAdapter(
              child: _ReviewHeaderSection(locId),
            ),
          ],
          body: _ReviewListSection(locId),
        ),
      ),
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
          return _AddUserReviewSection(id);
        }

        return ReviewCardWidget(review: data, actionMenu: _ReviewActionButton(id));
      },
      error: (error, stk) => Text(error.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

class _AddUserReviewSection extends ConsumerWidget {
  final String locId;
  const _AddUserReviewSection(this.locId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final theme = Theme.of(context);
    final rating = ref.watch(reviewRatingValueProvider(locId));

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
                    imageUrl: user!.profileImage,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              RatingBar.builder(
                initialRating: rating,
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
                onRatingUpdate: (value) {
                  ref.read(reviewRatingValueProvider(locId).state).state = value;
                  Future.delayed(const Duration(milliseconds: 150), () {
                    context.router.navigate(AddReviewRoute(locId: locId));
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReviewListSection extends ConsumerWidget {
  final String locId;
  const _ReviewListSection(this.locId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return PaginatedListViewWidget<ReviewModel>(
      listPadding: EdgeInsets.zero,
      provider: placeReiewListProvider(locId),
      hideNoMoreItems: true,
      builder: (review) {
        if (user!.uid == review.uid) {
          return ReviewCardWidget(
            review: review,
            actionMenu: _ReviewActionButton(locId),
          );
        }

        return ReviewCardWidget(review: review);
      },
      loadingPlaceholder: const Center(child: CircularProgressIndicator()),
      emptyResultPlaceholder: BlankPage(
        icon: Icons.rate_review_rounded,
        heading: tr(LocaleKeys.no_reviews),
        shortText: tr(LocaleKeys.no_reviews_desc),
      ),
    );
  }
}

enum ReviewAction {
  edit,
  delete,
}

class _ReviewActionButton extends ConsumerWidget {
  const _ReviewActionButton(this.locId, {Key? key}) : super(key: key);

  final String locId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<ReviewAction>(
      child: const Center(child: Icon(Icons.more_vert_rounded)),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(LocaleKeys.edit).tr(),
            ),
            value: ReviewAction.edit,
          ),
          PopupMenuItem(
            child: ListTile(
              leading: const Icon(Icons.delete),
              title: const Text(LocaleKeys.delete).tr(),
            ),
            value: ReviewAction.delete,
          ),
        ];
      },
      onSelected: (select) async {
        switch (select) {
          case ReviewAction.edit:
            log(select.name);
            break;
          case ReviewAction.delete:
            _handleDelete(context, ref);
            log(select.name);
            break;
        }
      },
    );
  }

  void _handleDelete(BuildContext context, WidgetRef ref) {
    DialogUtils.showYesNoDialog(
      context,
      onConfirm: () async {
        ref.read(reviewRepositoryProvider).deleteUserReview(locId);
        Future.delayed(const Duration(seconds: 4), () {
          ref.refresh(placeReiewListProvider(locId));
          ref.refresh(placeUserReviewProvider(locId));
        });

        SnackbarUtils.showSnackBar(
          context,
          message: LocaleKeys.deleted_review.tr(),
          snackBarType: SnackBarType.info,
        );
      },
      title: LocaleKeys.delete.tr(),
      message: LocaleKeys.delete_review.tr(),
    );
  }
}
