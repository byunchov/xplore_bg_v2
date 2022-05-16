import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String name;
  String thumbnail;
  String? tag;
  int itemCount;

  CategoryModel({
    required this.name,
    required this.itemCount,
    required this.thumbnail,
    this.tag,
  });

  factory CategoryModel.fromSnapshot(DocumentSnapshot snapshot, {String locale = "bg"}) {
    return CategoryModel(
      name: snapshot['locales'][locale] as String,
      itemCount: snapshot['item_count'] as int,
      thumbnail: snapshot['thumbnail'] as String,
      tag: snapshot['tag'] as String,
    );
  }
}
