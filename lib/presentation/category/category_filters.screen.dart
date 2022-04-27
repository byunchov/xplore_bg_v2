import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'models/filter_checkbox.model.dart';
import 'providers/categories.provider.dart';

class CategoryFilterScreen extends ConsumerWidget {
  final String tag;
  final String name;
  const CategoryFilterScreen({
    Key? key,
    required this.tag,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final facets = ref.watch(categoryFacetsProvider(tag));
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: AppbarTitleWidget(
          title: name,
          leading: AppbarActionWidget(
            iconData: Icons.arrow_back,
            buttonSize: 42,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          facets.when(
            data: (data) {
              return ExpansionTile(
                title: const Text("subcategories").tr(),
                initiallyExpanded: true,
                leading: const Icon(Icons.access_time),
                children: data.map(_checkboxTile).toList(),
              );
            },
            error: (err, _) => Text(err.toString()),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Widget _checkboxTile(SubcategoryCheckBox checkBox) {
    return CheckboxListTile(
      value: checkBox.value,
      title: Row(
        children: [
          Expanded(child: Text(checkBox.name)),
          Chip(label: Text(checkBox.itemCount.toString())),
        ],
      ),
      activeColor: null,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (value) {
        print("Checkbox '${checkBox.name}' value is: $value");
        checkBox.value = value!;
      },
    );
  }
}
