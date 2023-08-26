import 'firebase_request_method.dart';

class FirebaseRequest<T> {
  final FirebaseRequestMethod method;
  final String? email;
  final String? password;

  FirebaseRequest({required this.method, this.email, this.password});
}

class FirebaseFirestoreRequest {
  final FirestoreRequestMethod method;
  final String collection;
  final String? documentId;
  final Map<String, dynamic>? data;

  FirebaseFirestoreRequest({
    required this.method,
    required this.collection,
    this.documentId,
    this.data,
  });
}
