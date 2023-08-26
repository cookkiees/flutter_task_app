import 'package:get/get.dart';
import 'home_controller.dart';
import 'home_interactor.dart';
import 'home_worker.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeWorker>(() => HomeWorker());
    Get.lazyPut<HomeInteractor>(() => HomeInteractor());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
