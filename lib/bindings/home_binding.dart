import 'package:get/get.dart';
import '../Controller/home_controller.dart';
import '../Controller/favorites_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.put<FavoritesController>(
      FavoritesController(),
      permanent: true, // ← يخليه دائم ما يتحذف
    );
  }
}