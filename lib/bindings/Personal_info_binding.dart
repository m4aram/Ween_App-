import 'package:get/get.dart';

import '../Controller/Personal_info_controller.dart';

class PersonalInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PersonalInfoController>(() => PersonalInfoController());
  }
}