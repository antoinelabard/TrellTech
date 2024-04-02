import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mytodo/service/services/auth_service.dart';

class NavigationBarComponent extends StatelessWidget {
  /// Constructs a [NavigationBarComponent]
  const NavigationBarComponent({super.key});

  // Define constants for colors and icon size
  static const Color iconColor = Color.fromRGBO(20, 25, 70, 1);
  static const double iconSize = 26.0;

  // Function to generate IconButton
  IconButton generateIconButton({required IconData icon, required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(103, 141, 236, 1.0),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 16,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          generateIconButton(
            icon: Icons.home_outlined,
            onPressed: () => context.go('/home'),
          ),
          generateIconButton(
            icon: Icons.arrow_back,
            onPressed: () => Navigator.pop(context),
          ),
          generateIconButton(
            icon: Icons.build_outlined,
            onPressed: () => context.go('/debug'),
          ),
          generateIconButton(
            icon: Icons.logout_outlined,
            onPressed: () => Auth().signOut(),
          ),
        ],
      ),
    );
  }
}