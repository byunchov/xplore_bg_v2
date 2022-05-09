import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/add_review.provider.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/place_reviews.provider.dart';
import 'package:xplore_bg_v2/presentation/place/controllers/place.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class AddReviewScreen extends ConsumerWidget {
  final String locId;
  const AddReviewScreen({
    Key? key,
    @PathParam('id') required this.locId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final user = ref.watch(authControllerProvider);
    final formKey = ref.read(reviewFormKeyProvider(locId));
    final textController = ref.watch(reviewTextControllerProvider(locId));
    final rating = ref.watch(reviewRatingValueProvider(locId));
    final place = ref.read(placeDetailsProvider(locId)).value;

    return UnfocusWidget(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: AppbarTitleWidget(
            title: MarqueeWidget(child: Text(place!.name)),
            leading: AppbarActionWidget(
              iconData: Icons.arrow_back,
              buttonSize: 42,
              onTap: () => context.router.pop(),
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
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
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user.fullName,
                          style: theme.textTheme.subtitle1?.copyWith(
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.7,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          LocaleKeys.public_post,
                          style: theme.textTheme.subtitle2?.copyWith(fontWeight: FontWeight.w400),
                        ).tr(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ignoreGestures: false,
                  glowColor: Colors.amber[300],
                  itemPadding: const EdgeInsets.symmetric(horizontal: 12),
                  itemSize: 36,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (value) {
                    ref.read(reviewRatingValueProvider(locId).state).state = value;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: textController,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    labelText: LocaleKeys.review_input_lbl.tr(),
                    hintText: LocaleKeys.review_input_hint.tr(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.input_sth.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(
                    height: 45,
                  ),
                  child: ElevatedButton(
                    child: Text(tr(LocaleKeys.submit_btn).toUpperCase()),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      primary: theme.primaryColor,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        final message = ref.read(reviewTextControllerProvider(locId)).text;

                        ref.read(reviewRepositoryProvider).saveUserReview(locId);
                        Future.delayed(const Duration(seconds: 3), () {
                          ref.refresh(placeReiewListProvider(locId));
                          ref.refresh(placeUserReviewProvider(locId));
                          log("refreshed review list", name: "onPressed(addreview)");
                        });

                        SnackbarUtils.showSnackBar(
                          context,
                          message: LocaleKeys.review_saved.tr(),
                          snackBarType: SnackBarType.info,
                        );
                        context.router.pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
