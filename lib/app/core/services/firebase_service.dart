import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_app/app/core/helpers/task_logger.dart';
import 'package:task_app/app/core/services/firebase_result.dart';

import 'firebase_request.dart';
import 'firebase_request_method.dart';
import 'firebase_result_type.dart';

class FirebaseService extends GetConnect {
  Future<FirebaseResult<UserCredential>> firebaseAuth(
      FirebaseRequest request) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    UserCredential userCredential;
    try {
      switch (request.method) {
        case FirebaseRequestMethod.signIn:
          userCredential = await firebaseAuth.signInWithEmailAndPassword(
            email: request.email ?? '',
            password: request.password ?? '',
          );
          break;
        case FirebaseRequestMethod.signUp:
          userCredential = await firebaseAuth.createUserWithEmailAndPassword(
            email: request.email ?? '',
            password: request.password ?? '',
          );
          break;
        case FirebaseRequestMethod.googleSignIn:
          await googleSignIn.signOut();
          await firebaseAuth.signOut();
          final googleSignInAccount = await googleSignIn.signIn();
          final googleSignInAuth = await googleSignInAccount!.authentication;
          final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuth.accessToken,
            idToken: googleSignInAuth.idToken,
          );
          userCredential = await firebaseAuth.signInWithCredential(credential);
          break;
        default:
          throw Exception("Invalid request method");
      }
      debugPrintFirebaseAuth(request, userCredential);
      return FirebaseResult<UserCredential>(
        result: FirebaseResultType.success,
        message: "Successful",
        data: userCredential,
      );
    } catch (e) {
      String? errorMessage = e.toString();
      String? relevantErrorMessage = '';
      List<String> errorMessageParts = errorMessage.split('] ');
      if (errorMessageParts.length > 1) {
        relevantErrorMessage = errorMessageParts[1];
      }
      TaskLogger.logError(relevantErrorMessage);
      if (e is FirebaseAuthException) {
        return FirebaseResult<UserCredential>(
          result: FirebaseResultType.failure,
          message: relevantErrorMessage,
        );
      } else {
        return FirebaseResult<UserCredential>(
          result: FirebaseResultType.failure,
          message: "An error occurred",
        );
      }
    }
  }

  Future<void> debugPrintFirebaseAuth(
      FirebaseRequest request, UserCredential userCredential) async {
    TaskLogger.logDebug('----------------- REQUEST AUTH -----------------');
    TaskLogger.logDebug('Method: ${request.method}');
    TaskLogger.logDebug('Email: ${request.email ?? 'Google SignIn'}');
    TaskLogger.logDebug('Password: ${request.password ?? 'Google SignIn'}');
    TaskLogger.logDebug('User: ${userCredential.user}');
    TaskLogger.logDebug(
        '------------------------------------------------------');
  }
}
