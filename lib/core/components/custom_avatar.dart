import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'custom_network_image.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    this.text = '',
    this.size = 50,
    this.imageUrl = '',
    this.isAssetsImage = false,
    this.isOnline,
    this.borderColor = Colors.white,
    this.borderWidth = 2,
  });

  final String text;
  final double size;
  final String imageUrl;
  final bool isAssetsImage;
  final bool? isOnline;
  final Color borderColor;
  final double borderWidth;

  final Color randomBackgroundColor = AppColors.primaryColor;

  String getInitials(String text) {
    if (text.trim().isEmpty) return 'U';
    List<String> parts = text.trim().split(" ");
    if (parts.length > 1) {
      return "${parts[0].characters.first}${parts[1].characters.first}"
          .toUpperCase();
    } else {
      return parts[0].characters.first.toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Avatar with border & shadow
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: borderColor, width: borderWidth),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipOval(
            child: imageUrl.isEmpty
                ? CircleAvatar(
                    backgroundColor: randomBackgroundColor,
                    child: Text(
                      getInitials(text),
                      style: TextStyle(
                        fontSize: size / 2.5,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : CustomNetworkImage(
                    imageUrl: imageUrl,
                    height: size,
                    width: size,
                    borderRadius: BorderRadius.circular(size / 2),
                    isAssetsImage: isAssetsImage,
                  ),
          ),
        ),

        // Online/offline indicator
        if (isOnline != null)
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              width: size * 0.25,
              height: size * 0.25,
              decoration: BoxDecoration(
                color: isOnline! ? Colors.green : Colors.grey,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  if (isOnline!)
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.6),
                      blurRadius: 6,
                      spreadRadius: 2,
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
