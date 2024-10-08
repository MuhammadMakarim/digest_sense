import 'package:get/get.dart';
import '../controllers/kalkulator_controller.dart';

class KalkulatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KalkulatorController>(
          () => KalkulatorController(),
    );
  }
}