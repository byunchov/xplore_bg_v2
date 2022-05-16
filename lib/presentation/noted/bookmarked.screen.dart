import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/infrastructure/repositories/failure.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/authentication/controllers/auth.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'controllers/bookmarks.controller.dart';

class BookmarkedLocationsScreen extends ConsumerWidget {
  const BookmarkedLocationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const field = "bookmarks";
    final user = ref.watch(authControllerProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(notedPlacesProvider(field).notifier);
      },
      child: user != null
          ? PaginatedListViewWidget<PlaceModel>(
              provider: notedPlacesProvider(field),
              emptyResultPlaceholder: BlankPage(
                heading: LocaleKeys.no_bookmarks.tr(),
                shortText: LocaleKeys.no_bookmarks_desc.tr(),
                icon: Icons.bookmark_remove_rounded,
              ),
              errorPlaceholderBuilder: (error) {
                final message = error is Failure ? error.message.tr() : error.toString();
                return BlankPage(
                  icon: Icons.error_outline_rounded,
                  heading: LocaleKeys.error_title.tr(),
                  shortText: message,
                );
              },
              builder: (item) {
                return PlaceListTile(placePreview: item);
              },
            )
          : const UserNotLoggedInWidget(),
    );
  }
}
