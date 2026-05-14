import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Details_controller.dart';
import '../../framwork/Constant/app_colors.dart';
import '../Widgets/App bottom nav bar.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DetailsController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16),
                      _buildHeader(controller),
                      const SizedBox(height: 24),
                      // _buildContactCard(controller),
                      const SizedBox(height: 28),
                      Text('location'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                      const SizedBox(height: 12),
                      _buildMap(controller),
                      const SizedBox(height: 20),
                      _buildPhotoGallery(controller),
                      const SizedBox(height: 24),
                      _buildMenuButton(controller, context),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 0) Get.back();
          if (index == 1) Get.toNamed('/favorites');
          if (index == 2) Get.toNamed('/settings');
        },
      ),
    );
  }

  Widget _buildHeader(DetailsController controller) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.textDark, size: 24),
        ),
        const SizedBox(width: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(22),
          child: Image.asset(
            controller.place.imagePath,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              width: 44,
              height: 44,
              color: AppColors.background,
              child: const Icon(Icons.store, color: AppColors.textGrey),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(controller.place.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark)),
        ),
        Obx(() => GestureDetector(
          onTap: controller.toggleFavorite,
          child: Icon(
            controller.isFavorite.value ? Icons.favorite : Icons.favorite_border,
            color: controller.isFavorite.value ? AppColors.darkRed : AppColors.textGrey,
            size: 26,
          ),
        )),
      ],
    );
  }

  // Widget _buildContactCard(DetailsController controller) {
  //   return Stack(
  //     clipBehavior: Clip.none,
  //     children: [
  //       Positioned(
  //         bottom: -6,
  //         left: 12,
  //         right: 12,
  //         child: Container(
  //           height: 30,
  //           decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(20)),
  //         ),
  //       ),
  //       Container(
  //         width: double.infinity,
  //         padding: const EdgeInsets.all(24),
  //         decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(20)),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             _buildContactRow(icon: Icons.phone_outlined, label: 'phone'.tr, value: controller.place.phone),
  //             const SizedBox(height: 16),
  //             _buildContactRow(icon: Icons.language, label: 'web'.tr, value: controller.place.web),
  //             const SizedBox(height: 16),
  //             _buildContactRow(icon: Icons.camera_alt_outlined, label: 'instagram'.tr, value: controller.place.instagram),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildContactRow({required IconData icon, required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
            const SizedBox(width: 6),
            Icon(icon, color: AppColors.textWhite, size: 18),
          ],
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 13, color: AppColors.textWhite60)),
      ],
    );
  }

  Widget _buildMap(DetailsController controller) {
    return GestureDetector(
      onTap: () async {
        final query = Uri.encodeComponent(controller.place.name);
        final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$query');
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: 180,
          color: AppColors.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.map, size: 50, color: AppColors.primary),
              const SizedBox(height: 8),
              Text('open_in_google'.tr, style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoGallery(DetailsController controller) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.place.galleryImages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              controller.place.galleryImages[index],
              width: 120,
              height: 110,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 120,
                height: 110,
                color: AppColors.background,
                child: const Icon(Icons.image, color: AppColors.textGrey),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuButton(DetailsController controller, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: () async {
          if (controller.place.menuImage != null && controller.place.menuImage!.isNotEmpty) {
            showDialog(
              context: context,
              builder: (_) => Dialog(
                backgroundColor: Colors.transparent,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Builder(
                      builder: (_) {
                        final isUrl = controller.place.menuImage!.startsWith('http');
                        return isUrl
                            ? Image.network(
                          controller.place.menuImage!,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white54, size: 60),
                        )
                            : Image.asset(
                          controller.place.menuImage!,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(Icons.image, color: Colors.white54, size: 60),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
            return;
          }
          if (controller.place.menuUrl != null && controller.place.menuUrl!.isNotEmpty) {
            final url = Uri.parse(controller.place.menuUrl!);
            try {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            } catch (e) {
              Get.snackbar('warning'.tr, 'no_menu'.tr);
            }
            return;
          }
          Get.snackbar('warning'.tr, 'no_menu'.tr);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Text('menu'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textWhite, letterSpacing: 1)),
      ),
    );
  }
}