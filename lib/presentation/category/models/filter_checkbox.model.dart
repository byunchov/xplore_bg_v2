// ignore_for_file: constant_identifier_names

class SubcategoryCheckBox {
  final String name;
  final String? tag;
  final int itemCount;
  bool value;

  SubcategoryCheckBox({
    required this.name,
    required this.itemCount,
    this.tag,
    this.value = false,
  });
}

enum CategorySortableCriteria {
  rating,
  like_count,
}

enum CategorySortOrder { asc, desc }

class SortOrderDirection {
  String name;
  CategorySortOrder order;

  SortOrderDirection({required this.name, required this.order});
}

class SortCtiteria {
  String name;
  CategorySortableCriteria criteria;

  SortCtiteria({
    required this.name,
    required this.criteria,
  });
}
