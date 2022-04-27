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
