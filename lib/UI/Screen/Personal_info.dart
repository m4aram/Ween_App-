import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../../Controller/Personal_info_controller.dart';
import '../../framwork/Constant/app_colors.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PersonalInfoController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.dark,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: AppColors.textWhite),
        ),
        title: Text('personal_info'.tr, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textWhite)),
        centerTitle: true,
        actions: [
          Obx(() => TextButton(
            onPressed: controller.isEditing.value ? controller.saveChanges : controller.toggleEdit,
            child: Text(
              controller.isEditing.value ? 'save'.tr : 'edit'.tr,
              style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          )),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildAvatar(controller),
            const SizedBox(height: 32),
            Obx(() => Column(
              children: [
                _buildInfoField(label: 'full_name'.tr, controller: controller.nameController, icon: Icons.person_outline, isEditing: controller.isEditing.value),
                const SizedBox(height: 16),
                _buildInfoField(label: 'email'.tr, controller: controller.emailController, icon: Icons.email_outlined, isEditing: controller.isEditing.value, keyboardType: TextInputType.emailAddress),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(PersonalInfoController controller) {
    return Obx(() => Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.primary, width: 3)),
          child: ClipOval(
            child: controller.imagePath.value.isNotEmpty
                ? Image.file(File(controller.imagePath.value), fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 55, color: AppColors.textGrey))
                : const Icon(Icons.person, size: 55, color: AppColors.textGrey),
          ),
        ),
        controller.isEditing.value
            ? Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: controller.pickImage,
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
              child: const Icon(Icons.camera_alt, size: 16, color: AppColors.textWhite),
            ),
          ),
        )
            : const SizedBox(),
      ],
    ));
  }

  Widget _buildInfoField({required String label, required TextEditingController controller, required IconData icon, required bool isEditing, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: AppColors.textGrey, fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          enabled: isEditing,
          keyboardType: keyboardType,
          style: const TextStyle(fontSize: 15, color: AppColors.textDark, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: isEditing ? AppColors.primary : AppColors.textGrey, size: 20),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 1.5)),
            disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ],
    );
  }
}