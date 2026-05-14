import 'package:get/get.dart';
import '../Controller/Details_controller.dart';
import '../Controller/favorites_controller.dart';

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<FavoritesController>(); // فقط يبحث عن الموجود
    Get.lazyPut<DetailsController>(() => DetailsController());
  }
}