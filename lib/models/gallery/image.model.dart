class ImageModel {
  final String url;
  final String? author;

  ImageModel({required this.url, this.author});

  factory ImageModel.fromJson(Map<String, dynamic> snap) {
    return ImageModel(
      url: snap['url'] as String,
      author: snap['author'] as String?,
    );
  }
}
