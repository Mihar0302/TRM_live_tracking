import 'package:get/get.dart';

import '../utils/app_color.dart';

class Methods {
  static showAlertSnack(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        colorText: AppColor.white,
        backgroundColor: AppColor.red.withOpacity(0.8));
  }

  static showConfirmSnack(String title, String message) {
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        colorText: AppColor.white,
        backgroundColor: AppColor.green.withOpacity(0.6));
  }
}
