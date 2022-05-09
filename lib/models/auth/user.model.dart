import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:xplore_bg_v2/domain/core/utils/typedef.util.dart';

class UserModel {
  final String fullName;
  final String uid;
  final String profileImage;
  final String email;
  final DateTime? joinDate;
  final DateTime? lastSignIn;
  final int? likeCount;
  final int? bookmarkCount;
  UserModel({
    required this.fullName,
    required this.uid,
    required this.profileImage,
    required this.email,
    this.joinDate,
    this.lastSignIn,
    this.likeCount,
    this.bookmarkCount,
  });

  UserModel copyWith({
    String? fullName,
    String? uid,
    String? profileImage,
    String? email,
    DateTime? joinDate,
    DateTime? lastSignIn,
    int? likeCount,
    int? bookmarkCount,
  }) {
    return UserModel(
      fullName: fullName ?? this.fullName,
      uid: uid ?? this.uid,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      joinDate: joinDate ?? this.joinDate,
      lastSignIn: lastSignIn ?? this.lastSignIn,
      likeCount: likeCount ?? this.likeCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount,
    );
  }

  JsonMap toMap() {
    return {
      'full_name': fullName,
      'uid': uid,
      'profile_image': profileImage,
      'email': email,
      'join_date': joinDate?.millisecondsSinceEpoch,
      'last_signin': lastSignIn?.millisecondsSinceEpoch,
      'like_count': likeCount,
      'bookmark_count': bookmarkCount,
    };
  }

  factory UserModel.fromMap(JsonMap map) {
    return UserModel(
      fullName: map['full_name'] ?? '',
      uid: map['uid'] ?? '',
      profileImage: map['profile_image'] ?? '',
      email: map['email'] ?? '',
      joinDate:
          map['join_date'] != null ? DateTime.fromMillisecondsSinceEpoch(map['join_date']) : null,
      lastSignIn: map['last_signin'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['last_signin'])
          : null,
      likeCount: map['like_count']?.toInt(),
      bookmarkCount: map['bookmark_count']?.toInt(),
    );
  }

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      fullName: user.displayName ?? '',
      uid: user.uid,
      profileImage: user.photoURL ?? '',
      email: user.email ?? '',
      joinDate: user.metadata.creationTime,
      lastSignIn: user.metadata.lastSignInTime,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(fullName: $fullName, uid: $uid, profileImage: $profileImage, email: $email, joinDate: $joinDate, lastSignIn: $lastSignIn, likeCount: $likeCount, bookmarkCount: $bookmarkCount)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.fullName == fullName &&
        other.uid == uid &&
        other.profileImage == profileImage &&
        other.email == email &&
        other.joinDate == joinDate &&
        other.lastSignIn == lastSignIn &&
        other.likeCount == likeCount &&
        other.bookmarkCount == bookmarkCount;
  }

  @override
  int get hashCode {
    return fullName.hashCode ^
        uid.hashCode ^
        profileImage.hashCode ^
        email.hashCode ^
        joinDate.hashCode ^
        lastSignIn.hashCode ^
        likeCount.hashCode ^
        bookmarkCount.hashCode;
  }
}
