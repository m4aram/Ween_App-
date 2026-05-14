import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Data/models/place_model.dart';

class FavoritesController extends GetxController {
  final RxList<PlaceModel> favorites = <PlaceModel>[].obs;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  String get _userId => _auth.currentUser?.uid ?? '';

  Future<void> fetchFavorites() async {
    if (_userId.isEmpty) return;
    final snapshot = await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .get();
    favorites.value = snapshot.docs.map((doc) {
      final data = doc.data();
      return PlaceModel(
        id: doc.id,
        name: data['name'] ?? '',
        country: data['country'] ?? '',
        imagePath: data['imagePath'] ?? '',
        phone: data['phone'] ?? '',
        web: data['web'] ?? '',
        instagram: data['instagram'] ?? '',
        galleryImages: List<String>.from(data['galleryImages'] ?? []),
        menuImage: data['menuImage'],  // ✅ أضفنا
        menuUrl: data['menuUrl'],      // ✅ أضفنا
      );
    }).toList();
  }

  Future<void> addFavorite(PlaceModel place) async {
    if (_userId.isEmpty) return;
    if (!favorites.any((p) => p.id == place.id)) {
      favorites.add(place);
      await _firestore
          .collection('users')
          .doc(_userId)
          .collection('favorites')
          .doc(place.id)
          .set({
        'name': place.name,
        'country': place.country,
        'imagePath': place.imagePath,
        'phone': place.phone,
        'web': place.web,
        'instagram': place.instagram,
        'galleryImages': place.galleryImages,
        'menuImage': place.menuImage,  // ✅ أضفنا
        'menuUrl': place.menuUrl,      // ✅ أضفنا
      });
    }
  }

  Future<void> removeFavorite(String id) async {
    if (_userId.isEmpty) return;
    favorites.removeWhere((place) => place.id == id);
    await _firestore
        .collection('users')
        .doc(_userId)
        .collection('favorites')
        .doc(id)
        .delete();
  }

  bool get isEmpty => favorites.isEmpty;
}