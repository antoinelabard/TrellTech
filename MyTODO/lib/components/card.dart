import 'package:flutter/material.dart';

class CardComponent extends StatelessWidget {
  const CardComponent({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.iconData,
  });

  final String title;
  final String subtitle;
  final IconData iconData;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        surfaceTintColor: const Color(0xff51ccf6),
        color: const Color(0xff51ccf6),
        child: GestureDetector(
          onTap: onTap,
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            leading: Icon(
              iconData,
              size: 24.0,
              color: const Color(0xff141946),
            ),
            title: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xff141946),
              ),
            ),
            subtitle: Text(
              subtitle,
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: Color(0xff141946),
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
            shape: const RoundedRectangleBorder(
            ),
            trailing: const Icon(
              Icons.remove_red_eye_outlined,
              color: Color(0xff141946),
            ),
          ),
        )
      ),
    );
  }
}
