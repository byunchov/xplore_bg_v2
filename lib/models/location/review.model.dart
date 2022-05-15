import 'dart:convert';

import 'package:xplore_bg_v2/domain/core/utils/typedef.util.dart';
import 'package:xplore_bg_v2/models/models.dart';

class ReviewModel {
  final String id;
  final String locId;
  final String uid;
  final String fullName;
  final String profileImage;
  final String lang;
  final double rating;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? relativeTimeDescription;

  ReviewModel({
    required this.id,
    required this.locId,
    required this.uid,
    required this.fullName,
    required this.profileImage,
    required this.lang,
    required this.rating,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.relativeTimeDescription,
  });

  ReviewModel copyWith({
    String? id,
    String? locId,
    String? uid,
    String? fullName,
    String? profileImage,
    String? lang,
    double? rating,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? relativeTimeDescription,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      locId: locId ?? this.locId,
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      profileImage: profileImage ?? this.profileImage,
      lang: lang ?? this.lang,
      rating: rating ?? this.rating,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      relativeTimeDescription: relativeTimeDescription ?? this.relativeTimeDescription,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'loc_id': locId,
      'full_name': fullName,
      'profile_image': profileImage,
      'lang': lang,
      'rating': rating,
      'content': content,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
      'relativeTimeDescription': relativeTimeDescription,
    };
  }

  factory ReviewModel.fromMap(JsonMap map) {
    return ReviewModel(
      id: map['id'] ?? '',
      locId: map['loc_id'] ?? '',
      uid: map['uid'] ?? '',
      fullName: map['full_name'] ?? '',
      profileImage: map['profile_image'] ?? '',
      lang: map['lang'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      content: map['content'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] ?? 0),
      updatedAt:
          map['updated_at'] != null ? DateTime.fromMillisecondsSinceEpoch(map['updated_at']) : null,
      relativeTimeDescription: map['relativeTimeDescription'],
    );
  }

  factory ReviewModel.fromGMaps(JsonMap map) {
    return ReviewModel(
      id: map['id'] ?? '',
      locId: map['id'] ?? '',
      uid: map['uid'] ?? '',
      fullName: map['author_name'] ?? '',
      profileImage: map['profile_photo_url'] ?? '',
      lang: map['language'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
      content: map['text'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['time'] * 1000 ?? 0),
      relativeTimeDescription: map['relative_time_description'],
    );
  }

  factory ReviewModel.fromUserInput(
      String content, String locId, UserModel user, String language, double rating) {
    return ReviewModel(
      id: user.uid,
      locId: locId,
      uid: user.uid,
      fullName: user.fullName,
      profileImage: user.profileImage,
      lang: language,
      rating: rating,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReviewModel.fromJson(String source) => ReviewModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewModel(id: $id, uid: $uid, fullName: $fullName, profileImage: $profileImage, lang: $lang, rating: $rating, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, relativeTimeDescription: $relativeTimeDescription)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewModel &&
        other.id == id &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.profileImage == profileImage &&
        other.lang == lang &&
        other.rating == rating &&
        other.content == content &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.relativeTimeDescription == relativeTimeDescription;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        fullName.hashCode ^
        profileImage.hashCode ^
        lang.hashCode ^
        rating.hashCode ^
        content.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        relativeTimeDescription.hashCode;
  }
}
