import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/config.util.dart';
import 'package:xplore_bg_v2/infrastructure/providers/general.provider.dart';

class ChooseLanguageScreen extends ConsumerWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: ListView.separated(
        itemCount: AppConfig.appLanguages.length,
        itemBuilder: (ctx, index) {
          final localeName = AppConfig.appLanguages[index];
          final locale = AppConfig.appLocales[index];
          return ListTile(
            leading: const Icon(Icons.language),
            title: Text(localeName),
            trailing:
                (context.locale.toString() == locale.toString()) ? const Icon(Icons.check) : null,
            onTap: () async {
              context.setLocale(locale);
              ref.read(appLocaleProvider.notifier).setAppLocale(locale);
              // ref.read(appLocaleProvider.state).state = locale;

              context.router.pop();
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 2.5),
      ),
    );
  }
}
