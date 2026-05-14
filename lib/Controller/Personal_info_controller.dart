import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PersonalInfoController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final RxBool isEditing = false.obs;
  final RxString imagePath = ''.obs; // ← مسار الصورة
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _picker = ImagePicker();

  String get _userId => _auth.currentUser?.uid ?? '';

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (_userId.isEmpty) return;
    final doc = await _firestore.collection('users').doc(_userId).get();
    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      emailController.text = data['email'] ?? '';
      imagePath.value = data['imagePath'] ?? '';
    } else {
      nameController.text = _auth.currentUser?.displayName ?? '';
      emailController.text = _auth.currentUser?.email ?? '';
    }
  }

  // اختيار صورة من الاستوديو
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
  }

  Future<void> saveChanges() async {
    if (_userId.isEmpty) return;
    await _firestore.collection('users').doc(_userId).set({
      'name': nameController.text,
      'email': emailController.text,
      'imagePath': imagePath.value,
    }, SetOptions(merge: true));

    isEditing.value = false;
    Get.snackbar(
      'Saved',
      'Your info has been updated',
      backgroundColor: const Color(0xFF00A66F),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}