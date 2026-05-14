import 'package:get/get.dart';
import '../Controller/favorites_controller.dart';

class FavoritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.find<FavoritesController>(); }}// فقط يبحث عن الموجود  }
