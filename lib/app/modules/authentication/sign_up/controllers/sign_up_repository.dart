import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/services/firebase_service.dart';
import '../../../../core/services/firebase_request.dart';
import '../../../../core/services/firebase_request_method.dart';
import '../../../../core/services/firebase_result.dart';

class SignUpRepository {
  FirebaseService service = Get.find<FirebaseService>();

  Future<FirebaseResult<UserCredential>> prosesSignUp(
      String email, String password) async {
    FirebaseRequest request = FirebaseRequest(
      method: FirebaseRequestMethod.signUp,
      email: email,
      password: password,
    );
    final firebaseResult = await service.firebaseAuth(request);
    return firebaseResult;
  }
}
