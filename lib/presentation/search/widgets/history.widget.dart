import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/generated/locale_keys.g.dart';
import 'package:xplore_bg_v2/presentation/search/controllers/search.controller.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

/*
class SearchHistoryWidget extends ConsumerWidget {
  const SearchHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(searchHistoryProvider);
    final controller = ref.watch(searchHistoryProvider.notifier);

    return Visibility(
      visible: history.isNotEmpty,
      child: ListView.builder(
        itemCount: history.length,
        itemBuilder: (BuildContext context, int index) {
          final term = history[index];
          return ListTile(
            title: Text(term, style: const TextStyle(fontSize: 17)),
            leading: const Icon(Icons.history),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => controller.deleteSearchTerm(term),
            ),
            onTap: () async {
              controller.setSearchTermFromHistory(term);
              FocusManager.instance.primaryFocus?.unfocus();
            },
          );
        },
      ),
      replacement: const BlankPage(
        icon: Icons.pending_actions,
        heading: 'Празна хронология',
        shortText:
            'Потърсете нещо в полето по-горе.\nСписък с последни 5 тъсерния ще бъде показан тук.',
      ),
    );
  }
}
*/

class SearchHistoryWidget extends ConsumerWidget {
  const SearchHistoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final history = ref.watch(searchHistoryProvider);
    final controller = ref.watch(searchHistoryProvider.notifier);

    return Visibility(
      visible: history.isNotEmpty,
      child: SectionWithTitleWidget(
        title: Text(
          LocaleKeys.search_history,
          style: theme.textTheme.headline6,
        ).tr(),
        child: Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: history.length,
            itemBuilder: (BuildContext context, int index) {
              final term = history[index];
              return ListTile(
                title: Text(term, style: const TextStyle(fontSize: 17)),
                leading: const Icon(Icons.history),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => controller.deleteSearchTerm(term),
                ),
                onTap: () async {
                  controller.setSearchTermFromHistory(term);
                  FocusManager.instance.primaryFocus?.unfocus();
                },
              );
            },
          ),
        ),
      ),
      replacement: BlankPage(
        icon: Icons.pending_actions,
        heading: LocaleKeys.empty_search_history.tr(),
        shortText: LocaleKeys.empty_search_history_hint.tr(),
      ),
    );
  }
}
