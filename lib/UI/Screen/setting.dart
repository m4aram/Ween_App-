import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Settings_controller.dart';
import '../../framwork/Constant/app_colors.dart';
import '../Widgets/App bottom nav bar.dart';
import '../Widgets/Profile header.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          ProfileHeader(subtitle: 'welcome_back'.tr),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text('my_profile'.tr, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textDark)),
                  const SizedBox(height: 16),
                  _buildPersonalInfoRow(),
                  const Divider(height: 32, color: Colors.black12),
                  Obx(() => _buildLanguageRow(controller)),
                  const Divider(height: 32, color: Colors.black12),
                  _buildLogoutRow(controller),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTap: (index) {
          if (index == 0) Get.until((route) => route.settings.name == '/home');
          else if (index == 1) Get.offNamed('/favorites');
        },
      ),
    );
  }

  Widget _buildPersonalInfoRow() {
    return GestureDetector(
      onTap: () => Get.toNamed('/personal-info'),
      child: Row(
        children: [
          const Icon(Icons.person_outline, color: AppColors.textGrey, size: 22),
          const SizedBox(width: 12),
          Expanded(child: Text('personal_info'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textDark))),
          const Icon(Icons.arrow_forward_ios, color: AppColors.textGrey, size: 16),
        ],
      ),
    );
  }

  Widget _buildLanguageRow(SettingsController controller) {
    return Row(
      children: [
        const Icon(Icons.language, color: AppColors.textGrey, size: 22),
        const SizedBox(width: 12),
        Text('language'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.textDark)),
        const Spacer(),
        DropdownButton<String>(
          value: controller.selectedLanguage.value,
          isDense: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textDark),
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textDark),
          items: controller.languages.map((item) => DropdownMenuItem<String>(value: item, child: Text(item))).toList(),
          onChanged: (val) { if (val != null) controller.setLanguage(val); },
        ),
      ],
    );
  }

  Widget _buildLogoutRow(SettingsController controller) {
    return GestureDetector(
      onTap: () => Get.dialog(
        AlertDialog(
          title: Text('logout'.tr),
          content: Text('logout_confirm'.tr),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('cancel'.tr)),
            TextButton(
              onPressed: () => controller.logout(),
              child: Text('logout'.tr, style: const TextStyle(color: Colors.red)),
            ),
          ],
        ),
      ),
      child: Row(
        children: [
          const Icon(Icons.logout, color: Colors.red, size: 22),
          const SizedBox(width: 12),
          Text('logout'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16),
        ],
      ),
    );
  }
}