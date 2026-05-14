import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'firebase_options.dart';
import 'framwork/Constant/app_pages.dart';
import 'framwork/Constant/app_routes.dart';
import 'framwork/Constant/app_translations.dart';
import 'Controller/Settings_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // ✅ سجّل SettingsController مبكراً عشان يكون جاهز
  Get.put(SettingsController());
  runApp(const Ween());
}

class Ween extends StatelessWidget {
  const Ween({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return GetMaterialApp(
      title: 'Ween',
      debugShowCheckedModeBanner: false,
      translations: AppTranslations(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      builder: (context, child) {
        // ✅ يراقب تغيير اللغة ويحدث الاتجاه
        return Obx(() {
          final isArabic = settingsController.currentLocale.value == 'ar';
          return Directionality(
            textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
            child: _NetworkWrapper(child: child!),
          );
        });
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00A66F)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}

class _NetworkWrapper extends StatefulWidget {
  final Widget child;
  const _NetworkWrapper({required this.child});

  @override
  State<_NetworkWrapper> createState() => _NetworkWrapperState();
}

class _NetworkWrapperState extends State<_NetworkWrapper> {
  bool _isOffline = false;

  @override
  void initState() {
    super.initState();

    Connectivity().checkConnectivity().then((result) {
      final offline = result.every((r) => r == ConnectivityResult.none);
      if (offline) {
        setState(() => _isOffline = true);
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            'no_internet'.tr,
            'check_connection'.tr,
            icon: const Icon(Icons.wifi_off, color: Colors.white),
            backgroundColor: Colors.red.shade700,
            colorText: Colors.white,
            duration: const Duration(days: 1),
            isDismissible: false,
            snackPosition: SnackPosition.TOP,
          );
        });
      }
    });

    Connectivity().onConnectivityChanged.listen((result) {
      final offline = result.every((r) => r == ConnectivityResult.none);
      if (offline != _isOffline) {
        setState(() => _isOffline = offline);
        if (offline) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.snackbar(
              'no_internet'.tr,
              'check_connection'.tr,
              icon: const Icon(Icons.wifi_off, color: Colors.white),
              backgroundColor: Colors.red.shade700,
              colorText: Colors.white,
              duration: const Duration(days: 1),
              isDismissible: false,
              snackPosition: SnackPosition.TOP,
            );
          });
        } else {
          Get.closeAllSnackbars();
          Get.snackbar(
            'connected'.tr,
            'back_online'.tr,
            icon: const Icon(Icons.wifi, color: Colors.white),
            backgroundColor: Colors.green.shade700,
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}