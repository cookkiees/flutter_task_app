import '../entities/user_base_entity.dart';

class UserBaseViewModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? photoUrl;
  final dynamic creationTime;
  final dynamic lastSignIn;

  UserBaseViewModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.photoUrl,
    this.creationTime,
    this.lastSignIn,
  });

  factory UserBaseViewModel.fromEntity(UserBaseEntity? user) {
    return UserBaseViewModel(
      uid: user?.uid ?? '',
      name: user?.displayName ?? '',
      email: user?.email ?? '',
      phoneNumber: user?.phoneNumber ?? '',
      photoUrl: user?.photoUrl ?? '',
      creationTime: user?.creationTime as dynamic,
      lastSignIn: user?.lastSignIn as dynamic,
    );
  }
}
