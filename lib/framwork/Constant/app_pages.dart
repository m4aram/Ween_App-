import 'package:get/get.dart';

import '../../UI/Screen/Menu.dart';
import '../../UI/Screen/NoInternetScreen.dart';
import '../../UI/Screen/Personal_info.dart';
import '../../UI/Screen/chat_screen.dart';
import '../../bindings/Personal_info_binding.dart';
import '../../bindings/Settings_binding.dart';
import '../../UI/Screen/Favorites.dart';
import '../../UI/Screen/detiles.dart';
import '../../UI/Screen/home.dart';
import '../../UI/Screen/login.dart';
import '../../UI/Screen/logo.dart';
import '../../UI/Screen/setting.dart';
import '../../bindings/Login_binding.dart';
import '../../bindings/details_binding.dart';
import '../../bindings/favorites_binding.dart';
import '../../bindings/home_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      bindings: [
        HomeBinding(),
        // FavoritesBinding(), // ← يشتغل من الهوم
      ],
    ),
    GetPage(
      name: AppRoutes.details,
      page: () => const DetailsScreen(),
      binding: DetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      binding: FavoritesBinding(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.personalInfo,
      page: () => const PersonalInfoScreen(),
      binding: PersonalInfoBinding(),
    ),
    GetPage(
      name: AppRoutes.menu,
      page: () => const MenuScreen(),
      binding: DetailsBinding(), // نفس كنترولر التفاصيل
    ),
    GetPage(name: '/no_internet', page: () => const NoInternetScreen()),
    GetPage(name: '/chat', page: () => const ChatScreen()),  ];
}