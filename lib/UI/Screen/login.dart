import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/Login_controller.dart';
import '../../framwork/Constant/app_colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const _AvatarWidget(),
              const SizedBox(height: 40),
              _EmailField(controller: controller.emailController),
              const SizedBox(height: 16),
              Obx(() => _PasswordField(
                controller: controller.passwordController,
                isVisible: controller.isPasswordVisible.value,
                onToggleVisibility: controller.togglePasswordVisibility,
              )),
              const SizedBox(height: 24),
              _LoginButton(onPressed: controller.login),
              const SizedBox(height: 20),
              const _OrDivider(),
              const SizedBox(height: 20),
              const _SocialLoginButtons(),
              const SizedBox(height: 20),
              const _TermsAndPrivacyText(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
      child: ClipOval(
        child: Image.asset(
          'assets/images/avatar.png',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 80, color: AppColors.textWhite),
        ),
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  final TextEditingController controller;
  const _EmailField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'email_hint'.tr,
        hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
        suffixIcon: const Icon(Icons.email_outlined, color: AppColors.textGrey),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}

class _PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  final VoidCallback onToggleVisibility;

  const _PasswordField({required this.controller, required this.isVisible, required this.onToggleVisibility});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: 'password_hint'.tr,
        hintStyle: const TextStyle(color: AppColors.textGrey, fontSize: 14),
        suffixIcon: GestureDetector(
          onTap: onToggleVisibility,
          child: Icon(isVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.textGrey),
        ),
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _LoginButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 0,
        ),
        child: Text('login'.tr, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textWhite)),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Text('or'.tr, style: const TextStyle(fontSize: 14, color: AppColors.textGrey));
  }
}

class _SocialLoginButtons extends StatelessWidget {
  const _SocialLoginButtons();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();
    return Column(
      children: [
        const SizedBox(height: 12),
        _SocialButton(
          backgroundColor: AppColors.background,
          icon: Icons.g_mobiledata,
          iconColor: Colors.red,
          label: 'login_google'.tr,
          labelColor: AppColors.textDark,
          onPressed: controller.signInWithGoogle,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color labelColor;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.labelColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 10),
            Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: labelColor)),
          ],
        ),
      ),
    );
  }
}

class _TermsAndPrivacyText extends StatelessWidget {
  const _TermsAndPrivacyText();

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
        children: [
          TextSpan(text: 'terms_text'.tr),
          TextSpan(text: 'terms_of_use'.tr, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
          TextSpan(text: 'and'.tr),
          TextSpan(text: 'privacy_policy'.tr, style: const TextStyle(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w500)),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}