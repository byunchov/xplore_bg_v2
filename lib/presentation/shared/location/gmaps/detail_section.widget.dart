import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/domain/core/utils/snackbar.util.dart';
import 'package:xplore_bg_v2/domain/core/utils/url_launcher.util.dart';
import 'package:xplore_bg_v2/models/models.dart';
import 'package:xplore_bg_v2/presentation/location/controllers/gmaps.provider.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

class DetailSectionWidget extends ConsumerWidget {
  const DetailSectionWidget(this.locId, {Key? key}) : super(key: key);
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
            final infoList = _infoList(context, data);
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

  List<Widget> _infoList(BuildContext context, GMapsPlaceModel data) {
    return [
      // add location details ?
      if (data.residence != null && data.residence!.isNotEmpty)
        ListTile(
          title: Text(data.residence!),
          leading: const Icon(Icons.location_pin),
          onTap: () async {
            final launched = await UrlLauncherUtils.launchCoordinates(
                data.coordinates!.latitude, data.coordinates!.longitude, data.name);

            if (!launched) {
              SnackbarUtils.showSnackBar(context, message: "Error launching target!");
            }
          },
        ),

      // add place phone number
      if (data.phoneNumber != null && data.phoneNumber!.isNotEmpty)
        ListTile(
          title: Text(data.phoneNumber!),
          leading: const Icon(Icons.phone),
          onTap: () async {
            final launched = await UrlLauncherUtils.launchPhone(data.phoneNumber!);

            if (!launched) {
              SnackbarUtils.showSnackBar(context, message: "Error launching target!");
            }
          },
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
          onTap: () async {
            final launched = await UrlLauncherUtils.launchWebsite(data.website!);

            if (!launched) {
              SnackbarUtils.showSnackBar(context, message: "Error launching target!");
            }
          },
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
