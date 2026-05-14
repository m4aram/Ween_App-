import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SettingsController extends GetxController {
  final RxString selectedLanguage = 'English'.obs;
  final RxString currentLocale = 'en'.obs; // ✅ يراقب اللغة
  final List<String> languages = ['English', 'Arabic'];

  @override
  void onInit() {
    super.onInit();
    final locale = Get.locale;
    if (locale?.languageCode == 'ar') {
      selectedLanguage.value = 'Arabic';
      currentLocale.value = 'ar';
    } else {
      selectedLanguage.value = 'English';
      currentLocale.value = 'en';
    }
  }

  void setLanguage(String val) {
    selectedLanguage.value = val;
    if (val == 'Arabic') {
      Get.updateLocale(const Locale('ar', 'SA'));
      currentLocale.value = 'ar'; // ✅
    } else {
      Get.updateLocale(const Locale('en', 'US'));
      currentLocale.value = 'en'; // ✅
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    Get.offAllNamed('/login');
  }
}