import 'package:get/get.dart';
import 'package:plant_monitoring/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;

  void redirect() async {
    Get.offAllNamed(Routes.HOME);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
