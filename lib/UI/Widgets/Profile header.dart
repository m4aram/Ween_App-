import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

class ProfileHeader extends StatelessWidget {
  final String subtitle;

  const ProfileHeader({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .get(),
      builder: (context, snapshot) {
        String name = user?.displayName ?? 'User';
        String imagePath = '';

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          name = data['name'] ?? name;
          imagePath = data['imagePath'] ?? '';
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(top: 60, bottom: 40, left: 24),
          decoration: const BoxDecoration(
            color: Color(0xFF02414F),
          ),
          child: Row(
            children: [
              // صورة المستخدم
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF00A66F),
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: imagePath.isNotEmpty
                      ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.white,
                    ),
                  )
                      : const Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // الاسم والترحيب
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}