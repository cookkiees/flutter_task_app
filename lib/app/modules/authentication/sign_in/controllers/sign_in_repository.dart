import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../core/services/firebase_request.dart';
import '../../../../core/services/firebase_request_method.dart';
import '../../../../core/services/firebase_result.dart';
import '../../../../core/services/firebase_service.dart';

class SignInRepository {
  FirebaseService service = Get.find<FirebaseService>();

  Future<FirebaseResult<UserCredential>> prosesSignIn(
      String email, String password) async {
    FirebaseRequest request = FirebaseRequest(
      method: FirebaseRequestMethod.signIn,
      email: email,
      password: password,
    );
    final firebaseResult = await service.firebaseAuth(request);

    return firebaseResult;
  }

  Future<FirebaseResult<UserCredential>> prosesGoogleSignIn() async {
    FirebaseRequest request = FirebaseRequest(
      method: FirebaseRequestMethod.googleSignIn,
    );
    final firebaseResult = await service.firebaseAuth(request);
    return firebaseResult;
  }
}
