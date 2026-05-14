import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.wifi_off, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 24),
            Text(
              'no_internet'.tr,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'check_connection'.tr,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () async {
                try {
                  final result = await InternetAddress.lookup('google.com')
                      .timeout(const Duration(seconds: 5));
                  if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Get.offAllNamed('/home');
                    } else {
                      Get.offAllNamed('/login');
                    }
                  }
                } catch (_) {
                  Get.snackbar(
                    'warning'.tr,
                    'still_no_internet'.tr,
                    backgroundColor: Colors.red.shade700,
                    colorText: Colors.white,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A66F),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
              ),
              child: Text('retry'.tr, style: const TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}