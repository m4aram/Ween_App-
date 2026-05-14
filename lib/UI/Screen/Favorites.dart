import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Details_controller.dart';
import '../../Controller/favorites_controller.dart';
import '../../Data/models/place_model.dart';
import '../../framwork/Constant/app_colors.dart';
import '../Widgets/App bottom nav bar.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoritesController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.textDark),
        ),
        title: Text(
          'favorites'.tr,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
        ),
        centerTitle: true,
      ),
      body: Obx(
            () => controller.isEmpty
            ? const _EmptyFavorites()
            : ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final place = controller.favorites[index];
            return _FavoriteItem(
              place: place,
              onTap: () {
                Get.put(DetailsController()..place = place);
                Get.toNamed('/details');
              },
              onRemove: () => controller.removeFavorite(place.id),
            );
          },
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Get.offAllNamed('/home'); // ✅ بدل Get.back()
          if (index == 2) Get.toNamed('/settings');
        },
      ),
    );
  }
}

class _FavoriteItem extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _FavoriteItem({required this.place, required this.onTap, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.dark,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white12,
              backgroundImage: AssetImage(place.imagePath),
              onBackgroundImageError: (_, __) {},
              child: place.imagePath.isEmpty
                  ? const Icon(Icons.person, color: Colors.white38, size: 28)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(place.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
                  const SizedBox(height: 4),
                  Text(place.country, style: const TextStyle(fontSize: 13, color: AppColors.textWhite60)),
                ],
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.delete_outline, color: AppColors.white, size: 26),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyFavorites extends StatelessWidget {
  const _EmptyFavorites();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.favorite_border, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text('no_favorites'.tr, style: const TextStyle(fontSize: 16, color: AppColors.textGrey)),
        ],
      ),
    );
  }
}