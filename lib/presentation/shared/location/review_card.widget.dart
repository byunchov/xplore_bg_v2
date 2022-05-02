import 'package:easy_localization/easy_localization.dart';
import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class ReviewCardWidget extends StatelessWidget {
  final ReviewModel review;
  final Widget? actionMenu;
  final bool showRelativeTime;
  final double avatarRadius;

  const ReviewCardWidget({
    Key? key,
    required this.review,
    this.actionMenu,
    this.showRelativeTime = false,
    this.avatarRadius = 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String createdAt = showRelativeTime && (review.relativeTimeDescription != null)
        ? review.relativeTimeDescription!
        : review.createdAt.toLocal().toIso8601String();

    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              SizedBox.square(
                dimension: avatarRadius,
                child: ClipOval(
                  child: CustomCachedImage(
                    imageUrl: review.profileImage,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      review.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.subtitle1?.copyWith(
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.7,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      createdAt,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              if (actionMenu != null) actionMenu!,
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              RatingBar.builder(
                initialRating: review.rating.toDouble(),
                minRating: 0,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                ignoreGestures: true,
                itemPadding: EdgeInsets.zero,
                itemSize: 18,
                itemBuilder: (_, __) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (_) {},
              ),
              const SizedBox(width: 6),
              Text(review.rating.toString()),
            ],
          ),
          const SizedBox(height: 10),
          ExpandText(
            review.content,
            maxLines: 6,
            collapsedHint: LocaleKeys.show_more.tr(),
            expandedHint: LocaleKeys.show_less.tr(),
            style: theme.textTheme.bodyMedium,
            expandArrowStyle: ExpandArrowStyle.both,
            arrowSize: 25,
            arrowColor: Theme.of(context).primaryColor,
            arrowPadding: const EdgeInsets.only(top: 5),
            hintTextStyle: TextStyle(color: theme.primaryColor),
          ),
        ],
      ),
    );
  }
}
