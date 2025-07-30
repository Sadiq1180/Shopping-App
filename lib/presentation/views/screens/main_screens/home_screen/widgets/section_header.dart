import 'package:flutter/material.dart';
import 'package:shopping_app/presentation/views/screens/main_screens/home_screen/widgets/notification_icon.dart';
import 'package:shopping_app/shared/shared.dart';

class SSenseHeader extends StatelessWidget implements PreferredSizeWidget {
  const SSenseHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SSENSE Logo
            const Text(
              'SSENSE',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.5,
              ),
            ),

            // Right side icon
            Row(
              children: [
                NotificationIcon(notificationCount: 6),
                16.spaceX,
                // Profile Picture
                ClipOval(
                  child: Image.asset(
                    AppAssets.person3,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
