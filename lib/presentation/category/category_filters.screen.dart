import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:xplore_bg_v2/presentation/shared/widgets.dart';

import 'models/filter_checkbox.model.dart';
import 'providers/categories.provider.dart';

class CategoryFilterScreen extends ConsumerWidget {
  @pathParam
  final String tag;
  final String name;
  const CategoryFilterScreen({
    Key? key,
    required this.tag,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: _CategoryFiltersWidget(tag),
      // body: ListView(
      //   physics: const BouncingScrollPhysics(),
      //   children: [
      //     _SubcategoryFacets(tag),
      //     _SortCriteriaSection(tag),
      //     _OrderbySection(tag),
      //   ],
      // ),
    );
  }
}

class _SortCriteriaSection extends ConsumerStatefulWidget {
  const _SortCriteriaSection(this.tag, {Key? key}) : super(key: key);

  final String tag;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SortCriteriaSectionState();
}

class __SortCriteriaSectionState extends ConsumerState<_SortCriteriaSection> {
  final sortCriteria = [
    SortCtiteria(name: tr('tag_loves'), criteria: CategorySortableCriteria.like_count),
    SortCtiteria(name: tr('tag_rating'), criteria: CategorySortableCriteria.rating),
  ];

  late SortCtiteria _currentSortCtiteria;

  @override
  Widget build(BuildContext context) {
    final criteria = ref.read(categorySortCriteriaProvider(widget.tag));

    _currentSortCtiteria = sortCriteria.firstWhere((element) => element.criteria == criteria);

    return ExpansionTile(
      title: const Text(LocaleKeys.criteria).tr(),
      initiallyExpanded: true,
      leading: const Icon(Icons.access_time),
      children: sortCriteria.map(_radioBtnCriteria).toList(),
    );
  }

  Widget _radioBtnCriteria(SortCtiteria criteria) {
    return RadioListTile<SortCtiteria>(
      value: criteria,
      groupValue: _currentSortCtiteria,
      title: Text(criteria.name),
      onChanged: (value) {
        print("Radio btn value is: ${value?.criteria.name}");
        ref.read(categorySortCriteriaProvider(widget.tag).state).state = value!.criteria;
        setState(() {
          _currentSortCtiteria = value;
        });
      },
    );
  }
}

class _OrderbySection extends ConsumerStatefulWidget {
  const _OrderbySection(this.tag, {Key? key}) : super(key: key);

  final String tag;

  @override
  ConsumerState<_OrderbySection> createState() => __OrderbySectionState();
}

class __OrderbySectionState extends ConsumerState<_OrderbySection> {
  final orderDirection = [
    SortOrderDirection(name: tr('tag_order_asc'), order: CategorySortOrder.asc),
    SortOrderDirection(name: tr('tag_order_desc'), order: CategorySortOrder.desc),
  ];

  late SortOrderDirection _orderDirection = orderDirection.first;

  @override
  Widget build(BuildContext context) {
    final order = ref.read(categorySortOrderDirectionProvider(widget.tag));

    _orderDirection = orderDirection.firstWhere((element) => element.order == order);

    return ExpansionTile(
      title: const Text(LocaleKeys.criteria).tr(),
      initiallyExpanded: true,
      leading: const Icon(Icons.access_time),
      children: orderDirection.map(_radioBtnOrderBy).toList(),
    );
  }

  Widget _radioBtnOrderBy(SortOrderDirection direction) {
    return RadioListTile<SortOrderDirection>(
      value: direction,
      groupValue: _orderDirection,
      title: Text(direction.name),
      onChanged: (value) {
        print("Radio btn value is: ${value?.order.name}");
        ref.read(categorySortOrderDirectionProvider(widget.tag).state).state = value!.order;
        setState(() {
          _orderDirection = value;
        });
      },
    );
  }
}

class _SubcategoryFacets extends ConsumerStatefulWidget {
  final String tag;
  const _SubcategoryFacets(this.tag, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __SubcategoryFacetsState();
}

class __SubcategoryFacetsState extends ConsumerState<_SubcategoryFacets> {
  @override
  Widget build(BuildContext context) {
    final facets = ref.watch(categoryFacetsProvider(widget.tag));

    return ExpansionTile(
      title: const Text(LocaleKeys.subcategories).tr(),
      initiallyExpanded: true,
      leading: const Icon(Icons.access_time),
      children: [
        facets.when(
          data: (data) {
            if (data.isEmpty) return const Text("Empty");

            return ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: data.map(_checkboxTile).toList(),
            );
          },
          error: (err, _) => Text(err.toString()),
          loading: () => const Center(child: CircularProgressIndicator()),
        )
      ],
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
        final filter = "subcategory='${checkBox.name}'";
        if (value != null && value) {
          ref
              .read(subcategoryFilterListProvider(widget.tag).state)
              .update((state) => [...state, filter]);
        } else {
          ref.read(subcategoryFilterListProvider(widget.tag).state).update((state) {
            final removed = [...state];
            removed.removeWhere((element) => element == filter);
            return removed;
          });
        }
        setState(() {
          checkBox.value = value!;
        });
      },
    );
  }
}

class _CategoryFiltersWidget extends ConsumerStatefulWidget {
  final String tag;
  const _CategoryFiltersWidget(this.tag, {Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => __CategoryFiltersWidgetState();
}

class __CategoryFiltersWidgetState extends ConsumerState<_CategoryFiltersWidget> {
  final sortCriteria = [
    SortCtiteria(name: tr('tag_loves'), criteria: CategorySortableCriteria.like_count),
    SortCtiteria(name: tr('tag_rating'), criteria: CategorySortableCriteria.rating),
  ];

  final orderDirection = [
    SortOrderDirection(name: tr('tag_order_asc'), order: CategorySortOrder.asc),
    SortOrderDirection(name: tr('tag_order_desc'), order: CategorySortOrder.desc),
  ];

  late SortOrderDirection _orderDirection = orderDirection.first;
  late SortCtiteria _currentSortCtiteria;

  @override
  Widget build(BuildContext context) {
    final order = ref.read(categorySortOrderDirectionProvider(widget.tag));
    final criteria = ref.read(categorySortCriteriaProvider(widget.tag));

    _orderDirection = orderDirection.firstWhere((element) => element.order == order);
    _currentSortCtiteria = sortCriteria.firstWhere((element) => element.criteria == criteria);

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _SubcategoryFacets(widget.tag),
        ExpansionTile(
          title: const Text(LocaleKeys.criteria).tr(),
          initiallyExpanded: true,
          leading: const Icon(Icons.access_time),
          children: sortCriteria.map(_radioBtnCriteria).toList(),
        ),
        ExpansionTile(
          title: const Text(LocaleKeys.criteria).tr(),
          initiallyExpanded: true,
          leading: const Icon(Icons.access_time),
          children: orderDirection.map(_radioBtnOrderBy).toList(),
        ),
      ],
    );
  }

  Widget _radioBtnOrderBy(SortOrderDirection direction) {
    return RadioListTile<SortOrderDirection>(
      value: direction,
      groupValue: _orderDirection,
      title: Text(direction.name),
      onChanged: (value) {
        print("Radio btn value is: ${value?.order.name}");
        ref.read(categorySortOrderDirectionProvider(widget.tag).state).state = value!.order;
        setState(() {
          _orderDirection = value;
        });
      },
    );
  }

  Widget _radioBtnCriteria(SortCtiteria criteria) {
    return RadioListTile<SortCtiteria>(
      value: criteria,
      groupValue: _currentSortCtiteria,
      title: Text(criteria.name),
      onChanged: (value) {
        print("Radio btn value is: ${value?.criteria.name}");
        ref.read(categorySortCriteriaProvider(widget.tag).state).state = value!.criteria;
        setState(() {
          _currentSortCtiteria = value;
        });
      },
    );
  }
}
