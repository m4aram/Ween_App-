import 'package:get/get.dart';
import '../../Data/models/place_model.dart';
import 'favorites_controller.dart';

class DetailsController extends GetxController {
  late PlaceModel place;
  final RxBool isFavorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    place = Get.arguments as PlaceModel;
    // نتحقق إذا المكان موجود في المفضلة
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    final favController = Get.find<FavoritesController>();
    isFavorite.value = favController.favorites.any((p) => p.id == place.id);
  }

  void toggleFavorite() {
    final favController = Get.find<FavoritesController>();
    if (isFavorite.value) {
      favController.removeFavorite(place.id);
      isFavorite.value = false;
    } else {
      favController.addFavorite(place);
      isFavorite.value = true;
    }
  }
}