import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Data/models/place_model.dart';

class HomeController extends GetxController {
  final RxInt currentNavIndex = 0.obs;
  final RxString selectedCity = 'All'.obs;
  final RxList<PlaceModel> places = <PlaceModel>[].obs;
  final RxList<PlaceModel> _allPlaces = <PlaceModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxString userName = ''.obs;
  final RxString userImage = ''.obs;

  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchPlaces();
    fetchUserData();
    ever(selectedCity, (_) => _filterByCity());
  }

  Future<void> fetchUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        userName.value = doc.data()?['name'] ?? user.displayName ?? '';
        userImage.value = doc.data()?['imagePath'] ?? '';
      } else {
        userName.value = user.displayName ?? '';
      }
    }
  }

  Future<void> fetchPlaces() async {
    try {
      isLoading.value = true;
      final snapshot = await _firestore.collection('places').get();
      _allPlaces.value = snapshot.docs.map((doc) {
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
          menuImage: data['menuImage'],
          menuUrl: data['menuUrl'],
          tags: List<String>.from(data['tags'] ?? []),
          city: data['country'] ?? '', // ✅ يقرأ من country
        );
      }).toList();

      _filterByCity();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load places',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  void _filterByCity() {
    if (selectedCity.value == 'All') {
      places.value = _allPlaces.toList();
    } else {
      places.value = _allPlaces
          .where((place) =>
      place.city.toLowerCase() == selectedCity.value.toLowerCase())
          .toList();
    }
  }
}