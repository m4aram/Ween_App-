import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Details_controller.dart';
import '../../framwork/Constant/app_colors.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.textDark),
        ),
        title: Text(
          controller.place.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: controller.place.galleryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showFullImage(context, controller.place.galleryImages[index]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                controller.place.galleryImages[index],
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.background,
                  child: const Icon(Icons.image, color: AppColors.textGrey, size: 40),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFullImage(BuildContext context, String imagePath) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: GestureDetector(
          onTap: () => Get.back(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const Icon(
                Icons.image,
                color: AppColors.textGrey,
                size: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}