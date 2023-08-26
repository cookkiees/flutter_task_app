import 'package:firebase_auth/firebase_auth.dart';

class UserBaseEntity {
  final String uid;
  final String displayName;
  final String email;
  final String phoneNumber;
  final String photoUrl;
  final dynamic creationTime;
  final dynamic lastSignIn;

  UserBaseEntity({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoUrl,
    required this.creationTime,
    required this.lastSignIn,
  });

  factory UserBaseEntity.fromFirebase(User user) {
    final creationTime = user.metadata.creationTime;
    final lastSignIn = user.metadata.lastSignInTime;
    return UserBaseEntity(
      uid: user.uid,
      displayName: user.displayName ?? '',
      email: user.email ?? '',
      phoneNumber: user.phoneNumber ?? '',
      photoUrl: user.photoURL ?? '',
      creationTime: creationTime as dynamic,
      lastSignIn: lastSignIn as dynamic,
    );
  }
  Map<String, dynamic> toFirebase() {
    return {
      'uid': uid,
      'display_name': displayName,
      'email': email,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
      'creation_time': creationTime,
      'last_sign_in': lastSignIn,
    };
  }

  factory UserBaseEntity.fromFirestoreData(Map<String, dynamic> data) {
    return UserBaseEntity(
      uid: data['uid'] ?? '',
      displayName: data['display_name'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
      photoUrl: data['photo_url'] ?? '',
      creationTime: data['creation_time'] as dynamic,
      lastSignIn: data['last_sign_in'] as dynamic,
    );
  }
}
