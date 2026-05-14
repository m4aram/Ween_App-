import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../Controller/home_controller.dart';
import '../../framwork/Constant/app_colors.dart';
import '../Widgets/App bottom nav bar.dart';
import '../Widgets/Place card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildHeader(controller),
              const SizedBox(height: 20),
              _buildChatCard(),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.centerLeft,
                child: Text('explore'.tr, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark)),
              ),
              const SizedBox(height: 12),
              Obx(() => _buildCitySearchBar(controller.selectedCity.value, controller)),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (controller.places.isEmpty) {
                    return Center(
                      child: Text(
                        'no_places'.tr,
                        style: const TextStyle(fontSize: 16, color: AppColors.textGrey),
                      ),
                    );
                  }
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: controller.places.length,
                    itemBuilder: (context, index) {
                      final place = controller.places[index];
                      return PlaceCard(
                        imagePath: place.imagePath,
                        name: place.name,
                        country: place.country,
                        onCheck: () => Get.toNamed('/details', arguments: place),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => AppBottomNavBar(
        currentIndex: controller.currentNavIndex.value,
        onTap: (index) {
          if (index == 1) Get.toNamed('/favorites');
          else if (index == 2) Get.toNamed('/settings');
          else controller.currentNavIndex.value = index;
        },
      )),
    );
  }

  Widget _buildChatCard() {
    return GestureDetector(
      onTap: () => Get.toNamed('/chat'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('chat_card_title'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 6),
                  Text('chat_card_subtitle'.tr, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(HomeController controller) {
    return Obx(() => Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
          child: ClipOval(
            child: controller.userImage.value.isNotEmpty
                ? Image.file(File(controller.userImage.value), fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.person, color: AppColors.textWhite, size: 28))
                : const Icon(Icons.person, color: AppColors.textWhite, size: 28),
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.userName.value.isNotEmpty ? controller.userName.value : 'welcome'.tr,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
            ),
            Text('welcome_back'.tr, style: const TextStyle(fontSize: 13, color: AppColors.textGrey)),
          ],
        ),
        const Spacer(),
      ],
    ));
  }

  Widget _buildCitySearchBar(String city, HomeController controller) {
    return GestureDetector(
      onTap: () => _showCityPicker(controller),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            const Icon(Icons.location_on, color: AppColors.primary, size: 20),
            const SizedBox(width: 8),
            Text('from'.tr, style: const TextStyle(fontSize: 14, color: AppColors.textGrey)),
            const SizedBox(width: 8),
            Text(
              city == 'All' ? 'all_cities'.tr : city,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
            ),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: AppColors.textGrey, size: 20),
          ],
        ),
      ),
    );
  }

  void _showCityPicker(HomeController controller) {
    final cities = ['All', 'United States','Manhattan','Bronx','Brooklyn'];
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('select_city'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            ...cities.map((city) => ListTile(
              title: Text(city == 'All' ? 'all_cities'.tr : city),
              trailing: controller.selectedCity.value == city
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                controller.selectedCity.value = city;
                Get.back();
              },
            )),
          ],
        ),
      ),
    );
  }
}