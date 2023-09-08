import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_app/app/core/helpers/task_logger.dart';
import 'package:task_app/app/core/local_storage/shared_preference.dart';
import 'package:task_app/app/routes/app_routes.dart';

import '../../../core/services/firebase_result_type.dart';
import '../../authentication/entities/user_base_entity.dart';
import '../../authentication/models/user_base_view_model.dart';
import '../../schedule/entities/schedule_base_entity.dart';
import '../../schedule/models/schedule_view_model.dart';
import 'home_repository.dart';

class HomeController extends GetxController {
  HomeRepository repository = Get.find<HomeRepository>();

  RxBool isLoadingUser = false.obs;
  var currentIndex = 0.obs;

  var selectedIndex = 0.obs;
  void changeTab(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() async {
    await fetchUserAndConvertViewModel();
    await handleUpComingTask();
    await handleTodayTask();
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await SharedPref.removeAccessTokenFrom();
      Get.offAllNamed(AppRoutes.signIn);
      TaskLogger.logInfo("Logged out successfully");
    } catch (e) {
      TaskLogger.logError("$e");
    }
  }

  final userViewModel = Rx<UserBaseViewModel>(UserBaseViewModel());
  Future<void> fetchUserAndConvertViewModel() async {
    isLoadingUser.value = true;
    try {
      final response = await repository.prossesGetUser();
      if (response.result == FirestoreResultType.success) {
        final firestoreData = response.data;
        if (firestoreData?.exists ?? false) {
          final results = firestoreData!.data() as Map<String, dynamic>;
          final data = UserBaseEntity.fromFirestoreData(results);
          userViewModel.value = UserBaseViewModel.fromEntity(data);
        } else {
          TaskLogger.logError("${response.meessage}");
        }
      }
    } catch (e) {
      TaskLogger.logError(e.toString());
    } finally {
      isLoadingUser.value = false;
    }
  }

  RxBool isEmptyUpComingTask = false.obs;
  RxBool isLoadingUpComingTask = false.obs;
  List<ScheduleViewModel?> upcomingTask = [];

  Future<void> handleUpComingTask() async {
    isLoadingUpComingTask.value = true;
    isEmptyUpComingTask.value = false;
    try {
      final firestore = await repository.prosesGetUpComingTask();
      if (firestore.result == FirestoreResultType.success) {
        List<ScheduleBaseEntity>? entity = firestore.data;

        if (entity!.isNotEmpty) {
          upcomingTask = entity.map((scheduleEntity) {
            return ScheduleViewModel.fromEntity(scheduleEntity);
          }).toList();
        } else {
          isEmptyUpComingTask.value = true;
        }
      } else if (firestore.result == FirestoreResultType.failure) {
        TaskLogger.logError("${firestore.meessage}");
      }
    } finally {
      isLoadingUpComingTask.value = false;
    }
  }

  RxBool isEmptyTodayTask = false.obs;
  RxBool isLoadingTodayTask = false.obs;
  List<ScheduleViewModel?> todayTask = [];

  Future<void> handleTodayTask() async {
    isLoadingTodayTask.value = true;
    isEmptyTodayTask.value = false;
    try {
      final firestore = await repository.prosesGetTodayTask();
      if (firestore.result == FirestoreResultType.success) {
        List<ScheduleBaseEntity>? entity = firestore.data;

        if (entity!.isNotEmpty) {
          todayTask = entity.map((scheduleEntity) {
            return ScheduleViewModel.fromEntity(scheduleEntity);
          }).toList();
        } else {
          isEmptyTodayTask.value = true;
        }
      } else if (firestore.result == FirestoreResultType.failure) {
        TaskLogger.logError("${firestore.meessage}");
      }
    } finally {
      isLoadingTodayTask.value = false;
    }
  }
}
