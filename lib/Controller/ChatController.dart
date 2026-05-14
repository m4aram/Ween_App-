import 'package:get/get.dart';
import '../../Data/models/place_model.dart';
import 'home_controller.dart';

class ChatMessage {
  final String text;
  final bool isUser;
  final PlaceModel? place;

  ChatMessage({required this.text, required this.isUser, this.place});
}

class ChatController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isTyping = false.obs;

  // ✅ كلمات الشكر
  final List<String> thankWords = [
    'شكرا', 'شكراً', 'شكرا لك', 'مشكور', 'thanks', 'thank you', 'thx', 'ty', 'merci'
  ];

  // ✅ كلمات التحية
  final List<String> greetingWords = [
    'هلا', 'هلو', 'مرحبا', 'مرحباً', 'السلام عليكم', 'hi', 'hello', 'hey', 'سلام'
  ];

  @override
  void onInit() {
    super.onInit();
    messages.add(ChatMessage(text: 'greeting'.tr, isUser: false));
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    messages.add(ChatMessage(text: text, isUser: true));
    isTyping.value = true;

    Future.delayed(const Duration(milliseconds: 800), () {
      final response = _getResponse(text.trim().toLowerCase());
      messages.add(response);
      isTyping.value = false;
    });
  }

  ChatMessage _getResponse(String query) {
    // ✅ 1. تحقق من كلمات الشكر
    if (_matchesAny(query, thankWords)) {
      return ChatMessage(text: 'thank_response'.tr, isUser: false);
    }

    // ✅ 2. تحقق من التحية
    if (_matchesAny(query, greetingWords)) {
      return ChatMessage(text: 'greeting'.tr, isUser: false);
    }

    // ✅ 3. ابحث في المطاعم
    final results = _searchPlaces(query);
    if (results.isNotEmpty) {
      return ChatMessage(
        text: 'found_restaurant'.tr,
        isUser: false,
        place: results.first,
      );
    }

    // ✅ 4. ما عنده علاقة بالأكل
    return ChatMessage(text: 'off_topic'.tr, isUser: false);
  }

  bool _matchesAny(String query, List<String> words) {
    return words.any((word) => query.contains(word.toLowerCase()));
  }

  List<PlaceModel> _searchPlaces(String query) {
    final homeController = Get.find<HomeController>();
    final cleanQuery = query.trim().toLowerCase();

    return homeController.places.where((place) {
      return place.tags.any((tag) {
        final cleanTag = tag.toLowerCase();
        return cleanTag.contains(cleanQuery) ||
            cleanQuery.split(' ').any((word) => word == cleanTag);
      });
    }).toList();
  }
}