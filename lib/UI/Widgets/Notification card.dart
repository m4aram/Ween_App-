import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const NotificationCard({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // الكارد الأبيض خلف (الظل)
        Positioned(
          bottom: -6,
          left: 12,
          right: 12,
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(60),
            ),
          ),
        ),

        // الكارد الأخضر الرئيسي
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(50),
          decoration: BoxDecoration(
            color: const Color(0xFF00A66F),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),

        // زر الإغلاق X

      ],
    );
  }
}