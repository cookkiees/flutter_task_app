import 'package:get/get.dart';

import '../../../core/local_storage/shared_preference.dart';
import '../../../core/services/firebase_firestore_service.dart';
import '../../../core/services/firebase_request.dart';
import '../../../core/services/firebase_request_method.dart';
import '../../../core/services/firebase_result_type.dart';
import '../../authentication/entities/user_base_entity.dart';
import '../../authentication/models/user_base_view_model.dart';
import 'home_repository.dart';

class HomeController extends GetxController {
  HomeRepository repository = Get.find<HomeRepository>();

  final firestore = Get.find<FirebaseFirestoreService>();

  var selectedIndex = 0.obs;

  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    await fetchUserAndConvertViewModel();
    super.onInit();
  }

  final userViewModel = Rx<UserBaseViewModel?>(null);
  Future<void> fetchUserAndConvertViewModel() async {
    final userEmail = await SharedPref.getAccessTokenFrom();
    final firestoreRequest = FirebaseFirestoreRequest(
      method: FirestoreRequestMethod.get,
      collection: 'users',
      documentId: userEmail,
    );
    final response = await firestore.firestoreRequestUser(firestoreRequest);
    if (response.result == FirestoreResultType.success) {
      final firestoreData = response.data;
      if (firestoreData?.exists ?? false) {
        final results = firestoreData!.data() as Map<String, dynamic>;
        final data = UserBaseEntity.fromFirestoreData(results);
        userViewModel.value = UserBaseViewModel.fromEntity(data);
      } else {}
    }
  }
}
