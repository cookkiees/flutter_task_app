import 'package:get/get.dart';

import 'main_controller.dart';
import 'main_repository.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainRepository>(() => MainRepository());
    Get.lazyPut<MainController>(() => MainController());
  }
}
