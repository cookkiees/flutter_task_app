import 'firebase_result_type.dart';

class FirebaseResult<T> {
  FirebaseResultType? result;
  String? message;
  T? data;

  FirebaseResult({this.result, this.message, this.data});
}

class FirestoreResult<T> {
  final FirestoreResultType result;
  final T? data;
  final String? meessage;

  FirestoreResult({
    required this.result,
    this.data,
    this.meessage,
  });
}
